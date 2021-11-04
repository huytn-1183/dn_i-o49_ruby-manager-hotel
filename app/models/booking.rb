class Booking < ApplicationRecord
  belongs_to :user

  has_many :booking_details, dependent: :destroy

  enum status: {inactive: 0, active: 1, accept: 2, remove: 3}

  scope :all_as_admin,
        ->(filter_params){pagination_at filter_params[:page]}

  scope :pagination_at,
        ->(page){page(page || 0).per(Settings.digit.length_4)}

  scope :status_is,
        ->(status){where(status: status) if status.present?}

  def self.user_name_search keyword
    joins(:user).where("users.name LIKE ?", "%#{keyword}%")
  end
end
