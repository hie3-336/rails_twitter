# frozen_string_literal: true

class AddUniqueIndexToUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :name, unique: true
  end
end
