class Room < ApplicationRecord
  standard superior vip luxury
  enum type: {standard: 0, superior: 1, vip: 2, luxury: 3}
  enum status: {not_available: 0, available: 1}
end
