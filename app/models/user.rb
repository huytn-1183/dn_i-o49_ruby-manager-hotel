class User < ApplicationRecord
  has_many :bookings, dependent: :destroy
  belongs_to :contact, optional: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  enum role: {admin: 0, staff: 1, customer: 2}
  attr_accessor :remember_token

  validates :name, presence: true
  validates :password, length:
          {maximum: Settings.digit.length_255,
           minimum: Settings.digit.length_6}
  validates :email, presence: true, uniqueness: true,
           length: {maximum: Settings.digit.length_255,
                    minimum: Settings.digit.length_6},
           format: {with: VALID_EMAIL_REGEX}

  has_secure_password

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def generate_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.generate_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def forget
    update_column :remember_digest, nil
  end

  def authenticated? remember_token
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end
end
