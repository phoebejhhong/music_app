class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :name, null: false

      t.timestamps null: false
    end

    create_table :albums do |t|
      t.string :name, null: false
      t.integer :band_id, null: false

      t.timestamps null: false
    end

    create_table :tracks do |t|
      t.string :name, null: false
      t.integer :album_id, null: false
      t.boolean :bonus, null: false
      t.text :lyrics

      t.timestamps null: false
    end
  end
end
