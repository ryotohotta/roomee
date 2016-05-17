class User < ActiveRecord::Base
  validates :nickname, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:twitter]
  has_many :articles
  has_many :talks
  has_many :likes
  has_many :liked_articles, through: :likes, source: :article
  mount_uploader :photo, PhotoUploader
  def self.update_oauth(auth, id)
    user = User.find(id)
    user.update(
      uid: auth.uid,
      provider: auth.provider,
      token: auth.credentials.token,
      secret: auth.credentials.secret
    )
  end
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    unless user
      user = User.create(
          nickname: auth.info.name,
          uid:      auth.uid,
          provider: auth.provider,
          token: auth.credentials.token,
          secret: auth.credentials.secret,
          email:    User.dummy_email(auth),
          password: Devise.friendly_token[0, 20]
        )
    end
    user
  end
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
  def update_without_current_password(params, *options)
   params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end
