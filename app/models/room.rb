class Room < ApplicationRecord
  has_many :room_attribute_groups, dependent: :destroy
  has_many :room_attributes, through: :room_attribute_groups

  enum level: {normal: 0, superior: 1, vip: 2, luxury: 3}
  enum status: {unavailable: 0, available: 1}

  validates :name, presence: true,
            length: {maximum: Settings.digit.length_255}

  scope :price_sort, ->(sort){order(price: sort || :asc)}

  scope :name_search,
        ->(keyword){where("rooms.name LIKE ?", "%#{keyword}%")}
  # ambiguous with room attributes name

  scope :has_attributes,
        ->(ids){joins(:room_attributes).where(room_attributes: {id: ids})}

  scope :pagination_at,
        ->(page){page(page).per(Settings.digit.length_4)}

  ransack_alias :search_simple,
                :room_attributes_name_or_name_or_description_or_level

  # enum search
  # refer: https://stackoverflow.com/questions/37257835/searching-on-an-enum-field-with-ransack
  ransacker :level, formatter: proc{|v| levels[v]} do |parent|
    parent.table[:level]
  end
end
