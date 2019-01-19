class CommentsController < ApplicationController
  before_action :find_article
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    @Comment.user = current_user
    @comment.article = @article
    @like = Like.find_or_initialize_by(article: @article, user: current_user)

    if @comment.save
      flash[:notice] = 'Your comment has been saved'
      redirect_to article_path(@article)
    else
      render 'articles/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = 'Your comment has been deleted'
    redirect_to article_path(@article)
  end

  private

  def find_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end