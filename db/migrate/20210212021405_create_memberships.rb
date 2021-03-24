class CreateMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :memberships do |t|
      t.text :appeal
      t.string :postal_code, null: false
      t.integer :prefecture_id, null: false
      t.string :city, null:false
      t.string :addresses, null: false
      t.string :building
      t.string :phone_number, null: false
      t.integer :rank_id, null: false, default: 0
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
