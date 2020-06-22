class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name,        null: false
      t.text :description,   null: false
      t.integer :price,       null: false
      t.string :unit,        null: false, default: 'yen'   #通貨の単位のため不要かも
      t

      t.timestamps
    end
  end
end
