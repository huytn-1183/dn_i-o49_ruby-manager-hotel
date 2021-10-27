class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :gender
      t.string :code
      t.string :email
      t.string :phone
      t.string :address
      t.string :image
      t.string :password_digest
      t.integer :role, null: false, default: 0
      t.references :contact, null: false, foreign_key: true
      t.timestamps
    end
  end
end
