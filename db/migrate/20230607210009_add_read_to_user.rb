class AddReadToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :read, :boolean
  end
end
