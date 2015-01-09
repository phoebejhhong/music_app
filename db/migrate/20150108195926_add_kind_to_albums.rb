class AddKindToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :kind, :string, null: false, default: "studio"
  end
end
