class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name

      t.timestamps
    end

    remove_column :songs, :artist
    add_column :songs, :artist_id, :integer
    add_index :songs, :artist_id
  end
end
