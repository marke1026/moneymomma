class ArticlesController < ApplicationController
  before_filter :admin_login_required, :except => [:index, :show]
  before_filter :find_article, :only => [:edit, :update, :destroy]
  
  uses_tiny_mce :only => [:new, :create, :edit, :update], :options => {
                              :theme => 'advanced',
                              :theme_advanced_resizing => true,
                              :theme_advanced_resize_horizontal => false,
                              :plugins => %w{ table fullscreen }
                          }
  
  def index
    @articles = Article.find(:all)
  end
  
  def new
    @article = current_user.articles.new
  end
  
  def create
    @article = current_user.articles.new(params[:article])
    if @article.save
      flash[:notice] = "Article has been added successfully!"
      redirect_to articles_path
    else
      render :action => :new
    end
  end
  
  def edit
  end
  
  def update
    if @article.update_attributes(params[:article])
      flash[:notice] = "Article has been updated!"
      redirect_to articles_path
    else
      render :action => :edit
    end
  end
  
  def show
    @article = Article.find_by_id(params[:id])
  end
  
  def destroy
    @article.destroy
    if request.xhr?
      render :update do |page|
        page.remove "article_#{params[:id]}"
      end
    end
  end
  
  private
  
  def find_article
    @article = current_user.articles.find_by_id(params[:id])
  end
  
end
