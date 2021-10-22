class ChangeColumn < ActiveRecord::Migration[6.1]
  def change
    change_column :bookings, :contact_id, :integer, null: true
  end
end
