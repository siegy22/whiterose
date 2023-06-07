class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.belongs_to :from, null: false, foreign_key: { to_table: :users }
      t.belongs_to :to, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
