class ArticlesController < ApplicationController

  def index
    @articles = policy_scope(Article)
  end

  def show
    @article = Article.find(params[:id])

    if params.has_key?(:comment)
      @comment = Comment.new(comment: params[:comment], commenter: params[:commenter], article_id: params[:id])
      else
      @comment = Comment.new(article_id: params[:id])
    end
  end
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params.merge(user_id: current_user.id))
    
    if @article.save
      redirect_to(@article)
    else

      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    debugger
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to(@article)
    else

      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    authorize @article
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  def publish
    debugger
    @article = Article.find(params[:article_id])
    @article.update!(published: true)
    flash[notice] = "Article has been published successfully"
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :published)
  end
end
