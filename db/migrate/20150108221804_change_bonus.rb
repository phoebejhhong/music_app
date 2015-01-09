class ChangeBonus < ActiveRecord::Migration
  def change
    remove_column :tracks, :bonus
    add_column :tracks, :kind, :string, null: false, default: 'regular'
  end
end
