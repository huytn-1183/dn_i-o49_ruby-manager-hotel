class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookings, dependent: :destroy

  enum role: {admin: 0, staff: 1, customer: 2}

  scope :pagination_at,
        ->(page){page(page || 1).per(Settings.digit.length_4)}
  scope :latest, ->{order(created_at: :asc)}
end
