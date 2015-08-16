class IssueForm < ActionForm::Base
  self.main_model = :issue

  attribute :title, required: true
  attribute :user

  association :comments do
    attribute :body, required: true
    attributes :user, :issue
  end
end
