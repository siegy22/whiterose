class AddPubKeyUidToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :pub_key_uid, :string
  end
end
