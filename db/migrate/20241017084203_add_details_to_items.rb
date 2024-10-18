class AddDetailsToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :name, :string
    add_column :items, :content, :text
    add_column :items, :category_id, :integer
    add_column :items, :condition_id, :integer
    add_column :items, :postage_id, :integer
    add_column :items, :prefecture_id, :integer
    add_column :items, :lead_time_id, :integer
    add_column :items, :price, :integer
    add_reference :items, :user, null: false, foreign_key: true
  end
end
