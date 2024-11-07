class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :phone_number, :string, null: false
    add_column :users, :birthday, :string, null: false
  end
end
