class IssuesController < ApplicationController
  before_action :create_new_form, only: [:new, :create]
  before_action :set_counts, only: [:index, :new, :show]

  def index
    issue_scrope = %w(all open closed).include?(params[:scope]) ? params[:scope] : 'open'

    @issues = Issue.send(issue_scrope).includes(comments: :user).order(updated_at: :desc)
  end

  def new
  end

  def create
    @issue_form.submit(issue_params)
    @issue_form.comments.first.user = current_user
    @issue_form.comments.first.issue = @issue_form.model

    if @issue_form.save
      flash[:success] = 'Issue created successfully'
      redirect_to @issue_form
    else
      flash[:error] = @issue_form.errors.full_messages.uniq.join('. ')
      render :new
    end
  end

  def show
    @issue = Issue.includes(comments: :user).find(params[:id])
  end

  def change_status
    @issue = Issue.find(params[:id])
    if @issue.update(status: issue_status_params)
      flash[:success] = 'Issue updated'
    else
      flash[:error] = @issue.errors.full_messages.uniq.join('. ')
    end
    redirect_to @issue
  end

  private

  def create_new_form
    issue = Issue.new(user: current_user)
    @issue_form = IssueForm.new(issue)
  end

  def issue_params
    params.require(:issue).permit(:title, comments_attributes: [:body])
  end

  def issue_status_params
    params.require(:status)
  end

  def set_counts
    @all_count = Issue.all.size
    @open_count = Issue.open.size
    @closed_count = Issue.closed.size
  end
end
