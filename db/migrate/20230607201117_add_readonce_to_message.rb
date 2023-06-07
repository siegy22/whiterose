class AddReadonceToMessage < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :read_once, :boolean
  end
end
