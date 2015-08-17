class CommentsController < ApplicationController
  before_action :set_issue
  before_action :create_new_form

  def create
    @comment_form.submit(comment_params)

    if @comment_form.save
      flash[:success] = '成功添加留言'
      redirect_to issue_path(@issue, anchor: "comment_#{@comment_form.model.id}")
    else
      flash[:error] = @comment_form.errors.full_messages.uniq.join('. ')
      redirect_to @issue
    end
  end

  private

  def set_issue
    @issue = Issue.find(params[:id])
  end

  def create_new_form
    comment = Comment.new(user: current_user, issue: @issue)
    @comment_form = CommentForm.new(comment)
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
