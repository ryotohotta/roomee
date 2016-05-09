class TalksController < ApplicationController
  def create
    @talk = Talk.create(text: talk_params[:text], article_id: talk_params[:article_id], user_id: current_user.id)
    redirect_to "/articles/#{@talk.article.id}"
  end

  private
  def talk_params
    params.permit(:text, :article_id)
  end
end
