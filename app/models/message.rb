# This model manage the generic message information
# body and attachment are crypted for each destination
# in the Destination model
class Message < ActiveRecord::Base
  include Standardizable
  has_many :destinations, autosave: true
  has_many :logs
  attr_accessor :body, :attachments_attributes, :detail
  accepts_nested_attributes_for :destinations, reject_if: :all_blank
  enum status: { message_new: 0, message_active: 2, message_closed: 3 }

  validates :year, presence: true, on: :create
  validates :detail, presence: true, on: :create
  validates :body, presence: true, on: :create

  before_validation :add_data, on: :create

  # return the message title
  def title
    "#{id} | #{I18n.l created_at}"
  end

  private

  # popolate
  def add_data
    self.year = Time.zone.now.year
    self.destinations_attributes = committee_data
  end

  def committee_data
    User.committee.map { |user| destination_data(user) }
  end

  # generate the destination data
  # require a valid user
  def destination_data(user)
    { user: user, body: body, detail: detail, attachments_attributes: (attachments_attributes || []) }
  end
end
