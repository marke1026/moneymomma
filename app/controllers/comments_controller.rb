class CommentsController < ApplicationController
  before_filter :admin_login_required, :only => [:destroy]
  
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(params[:comment])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to(@article, :notice => 'Comment was successfully created.') }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { redirect_to(@article, :notice => 
        'Comment could not be saved. Please fill in all fields')}
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @article = Article.find(params[:article_id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(@article, :notice => 'Comment was successfully deleted.') }
      format.xml  { head :ok }
    end
  end
  
end

