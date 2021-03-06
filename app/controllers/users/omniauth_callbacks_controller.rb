class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    callback_from :twitter
  end

  private

  def callback_from(provider)
    provider = provider.to_s
    # twitter 連携
    if user_signed_in?
      @user = User.update_oauth(request.env['omniauth.auth'], current_user.id)
      redirect_to user_path(current_user.id)
    else
      @user = User.find_for_oauth(request.env['omniauth.auth'])
      if @user.persisted?
        flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
        sign_in_and_redirect @user, event: :authentication
      else
        session["devise.#{provider}_data"] = request.env['omniauth.auth']
        redirect_to new_user_registration_url
      end
    end
  end
end