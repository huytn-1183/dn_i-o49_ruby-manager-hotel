class Room < ApplicationRecord
  has_many :room_attribute_groups, dependent: :destroy
  has_many :room_attributes, through: :room_attribute_groups

  enum level: {normal: 0, superior: 1, vip: 2, luxury: 3}
  enum status: {unavailable: 0, available: 1}

  validates :name, presence: true,
    length: {maximum: Settings.digit.length_255}

  scope :price_sort, ->(sort){order(price: sort || :asc)}

  scope :name_search,
        ->(keyword){where("name LIKE ?", "%#{keyword}%")}

  scope :has_attributes,
        ->(ids){joins(:room_attributes).where(room_attributes: {id: ids})}

  scope :pagination_at,
        ->(page){page(page).per(Settings.digit.length_4)}

  def self.to_csv fields = column_names, options = {}
    CSV.generate(options) do |csv|
      csv << fields
      all.find_each do |room|
        csv << room.attributes.values_at(*fields)
      end
    end
  end

  def self.import file
    ActiveRecord::Base.transaction do
      CSV.foreach(file.path, headers: true) do |row|
        room_hash = row.to_hash
        room = find_or_create_by!(id: room_hash["id"])
        room.update(room_hash)
      end
    end
  end
end
