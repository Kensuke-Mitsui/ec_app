class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :itemName#, null: false #商品名
      t.string :size#,     null: false #サイズ表記
      t.string :gender#,  #性別をmale,female,unisexで記載
      t.integer :price#,   null: false # 価格
      t.text :itemDate#,   null: false #商品情報
      
      t.timestamps
    end
  end
end
