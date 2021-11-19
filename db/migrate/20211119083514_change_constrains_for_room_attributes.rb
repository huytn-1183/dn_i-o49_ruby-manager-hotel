class ChangeConstrainsForRoomAttributes < ActiveRecord::Migration[6.1]
  def change
    add_index :room_attributes, :name, unique: true
  end
end
