class ChangeColumnInBookingDetails < ActiveRecord::Migration[6.1]
  def change
    change_column(:booking_details, :date_in, :datetime)
    change_column(:booking_details, :date_out, :datetime)
  end
end
