class CreateEmailAddresses < ActiveRecord::Migration
  def change
    create_table :email_addresses do |t|
      t.string :address
      t.integer :persond_id

      t.timestamps null: false
    end
  end
end
