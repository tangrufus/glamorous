class CommentForm < ActionForm::Base
  self.main_model = :comment

  attribute :body, required: true
  attributes :user, :issue
end
