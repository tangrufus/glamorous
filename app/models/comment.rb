# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  user_id    :integer          not null
#  issue_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_comments_on_issue_id  (issue_id)
#  index_comments_on_user_id   (user_id)
#

class Comment < ActiveRecord::Base
  include MarkdownHelper

  belongs_to :user
  belongs_to :issue, touch: true

  validates :body, presence: true
  validates :user, presence: true
  validates :issue, presence: true
  validates_associated :user, :issue

  def participants
    return [user] unless mentioned_users
    users = mentioned_users << user
    users.flatten.uniq
  end

  def mentioned_users
    @mentioned ||= markdownify_mentioned_user(body)
  end
end
