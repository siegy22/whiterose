class AddPgpPublicKeyToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :pgp_public_key, :string
  end
end
