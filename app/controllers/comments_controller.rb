# frozen_string_literal: true

class CommentsController < ActionController::Base
  def create
    @comment = Comment.create(comment_params)

    redirect_to users_path
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :author)
  end
end
