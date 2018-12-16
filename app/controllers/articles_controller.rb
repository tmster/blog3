class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :authorize_article, only: [:destroy, :edit, :update]

  def index
    @articles = Article.all.order(id: :desc)
    @articles = @articles.where("? = any(tags)", params[:q]) if params[:q].present?
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.author = current_user if current_user
    if @article.save
      flash[:notice] = 'Your article has been saved'
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
    @comment = Comment.new(commenter: session[:commenter])
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:notice] = 'Your article has been updated'
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = 'Your article has been deleted'
    redirect_to articles_path
  end

  private

  def authorize_article
    if current_user != @article.author && !current_user&.admin?
      flash[:alert] = "You are not allowed to be here"
      redirect_to articles_path
      false
    else
      true
    end
  end

  def article_params
    params.require(:article).permit(:title, :text, :tags)
  end

  def find_article
    @article = Article.find(params[:id])
  end
end
