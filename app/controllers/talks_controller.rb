class TalksController < ApplicationController
  def create
    @talk = Talk.create(text: talk_params[:text], article_id: talk_params[:article_id], user_id: current_user.id)
    redirect_to "/articles/#{@talk.article.id}"
  end

  def destroy
    binding.pry
    talk = Talk.find(params[:id])
    if talk.user_id == current_user.id
      talk.destroy
    end
    redirect_to :back
  end

  private
  def talk_params
    params.permit(:text, :article_id)
  end
end
