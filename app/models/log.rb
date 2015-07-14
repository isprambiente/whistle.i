# This model manage the log entry for each user
class Log < ActiveRecord::Base
  belongs_to :user
  belongs_to :message

  validates :user_id, presence: true
  validates :action, presence: true
end
