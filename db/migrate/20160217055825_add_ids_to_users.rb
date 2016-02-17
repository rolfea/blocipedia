class AddIdsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :customer_id, :string
    add_column :users, :last_charge_id, :string
    add_column :users, :refund_id, :string
  end
end
