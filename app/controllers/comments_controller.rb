class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params.merge(article_id: params[:article_id], commenter: current_user.email))
    @article = Article.find(params[:article_id])

    if @comment.save

      redirect_to @article
    else

      redirect_to article_path(@article, comment_show_params)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to article_path(@comment.article), status: :see_other
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :article_id)
  end

  def comment_show_params
    {
      comment: @comment.comment,
      comment_err: @comment.errors.full_messages_for(:comment).first    }
  end
end
