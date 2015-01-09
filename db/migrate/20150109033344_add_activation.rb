class AddActivation < ActiveRecord::Migration
  def change
    add_column :users, :activated, :boolean, null: false, default: true
    add_column :users, :activation_token, :string
  end
end
