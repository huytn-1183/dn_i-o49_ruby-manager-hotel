class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :contact, optional: true
  has_many :booking_details, dependent: :destroy
  has_many :rooms, through: :booking_details

  enum status: {inactive: 0, active: 1, accept: 2, remove: 3}
  # inactive: room not booking
  # active: room has booked and wait for accept
  # accept: room has accepted by admin or staff
  # remove: guest cancel booking

  scope :all_as_admin,
        ->(filter_params){pagination_at filter_params[:page]}

  scope :pagination_at,
        ->(page){page(page || 0).per(Settings.digit.length_4)}

  scope :status_is,
        ->(status){where(status: status) if status.present?}

  def self.create_booking booking, room_id, date_in, date_out
    ActiveRecord::Base.transaction do
      booking.save
      booking.booking_details.create(
        room_id: room_id,
        date_in: date_in,
        date_out: date_out
      )
      booking.active! if booking.inactive?
    end
  end

  def self.user_name_search keyword
    joins(:user).where("users.name LIKE ?", "%#{keyword}%")
  end
end
