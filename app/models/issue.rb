# == Schema Information
#
# Table name: issues
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  status     :integer          default(0), not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_issues_on_status   (status)
#  index_issues_on_title    (title) UNIQUE
#  index_issues_on_user_id  (user_id)
#

class Issue < ActiveRecord::Base
  enum status: [:open, :closed, :urgent]

  belongs_to :user, touch: true
  has_many :comments, dependent: :destroy

  auto_strip_attributes :title

  validates :title, presence: true, uniqueness: true
  validates :status, presence: true, inclusion: { in: statuses }, allow_blank: true
  validates :user, presence: true
  validates_associated :user

  def participants
    comments.collect(&:participants).flatten.uniq
  end

  def last_commenter_username
    comments.last.user.username
  end

  def last_commenter
    comments.last.user
  end

  def last_commented_at
    comments.last.created_at
  end
end
