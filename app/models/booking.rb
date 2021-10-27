class Booking < ApplicationRecord
  belongs_to :user

  has_many :booking_details, dependent: :destroy

  enum status: {inactive: 0, active: 1, accept: 2, remove: 3}

  scope :all_as_customer,
        ->(user){where(user_id: user.id)}

  scope :all_as_staff,
        ->{where.not(status: :remove)}

  scope :all_as_admin,
        ->(page){pagination_filter page}

  scope :status_is,
        ->(status){where(status: status) if status.present?}

  scope :pagination_at,
        ->(page){page(page || 0).per(Settings.digit.length_4)}
end
