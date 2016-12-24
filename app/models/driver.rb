class Driver < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, authentication_keys: [:phone]
  validates :phone, presence: true, uniqueness: true
  validates_format_of :phone, with: /\A(0)([0-9]{9})\z/
  validates :passengers, numericality: { greater_than_or_equal_to: 0 }
  validates :trunk, numericality: { greater_than_or_equal_to: 0 }

  has_attached_file :avatar, styles: { medium: "300x300", thumb: "100x100" }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :orders

  enum status: { available: 'available', busy: 'busy', offline: 'offline' }

  def active_for_authentication?
    super && active?
  end

  def as_json
    super.merge(avatar: avatar.url(:medium))
  end
end
