class Order < ApplicationRecord
  validates :email, format: { with: /\A(.+)@(.+)\z/ }, allow_blank: true
  validates :end_point, :passengers, :start_point, presence: true
  validates :phone, presence: true
  validates_format_of :phone, with: /\A(0)([0-9]{9})\z/
  validates :baggage, presence: true, allow_blank: true, allow_nil: false

  has_many :orders_blogs

  enum status: { incoming: 'incoming', waiting: 'waiting', arrived: 'arrived',
                 accepted: 'accepted', declined: 'declined', done: 'done',
                 canceled: 'canceled' }

  scope :on_driver, -> { where(status: %w(waiting arrived accepted)) }
end
