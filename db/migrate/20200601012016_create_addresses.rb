class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.integer :post_code
      t.string :prefecture
      t.string :city
      t.string :block
      t.string :building
      t.string :phone_number
      t.string :destination_family_name      
      t.string :destination_first_name      
      t.string :destination_family_name_kana 
      t.string :destination_first_name_kana 
      t.references :user,         foreign_key: true

      t.timestamps
    end
  end
end
