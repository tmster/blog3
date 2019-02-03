class RatesController < ApplicationController
  def create
    rate = Rate.new(comment_id: params[:comment_id], user: current_user, rate: params[:rate])
    rate.save
    redirect_to article_path(id: rate.comment.article_id)
  end

  def destroy
    rate = Rate.find(params[:id])
    rate.destroy

    redirect_to article_path(id: rate.comment.article_id)
  end
end