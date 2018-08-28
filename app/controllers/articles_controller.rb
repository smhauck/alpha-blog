class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit,:update,:show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = 'Article successfully created'
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def destroy
    @article.destroy
    flash[:danger] = 'Article was successfully deleted'
    redirect_to articles_path
  end
  
  def edit
  end
 
  def index
    @articles = Article.paginate(page: params[:page], per_page: 3)
  end
 
  def new
    @article = Article.new
  end

  def show
  end
  

  def update
    if @article.update(article_params)
      flash[:success] = 'Article successfully updated'
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user and !current_user.admin?
      flash[:danger] = 'You can only edit or delete your own article'
      if request.referer
        redirect_to request.referer
      else
        redirect_to root_path
      end
    else
      render 'edit'
    end
  end

end
