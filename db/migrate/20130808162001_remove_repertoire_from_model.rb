class RemoveRepertoireFromModel < ActiveRecord::Migration
  def change
    drop_table :repertoires
    drop_table :repertoires_songs
    create_table :repertoire_entries, id: false do |t|
      t.belongs_to :user
      t.belongs_to :song
    end
    add_index :repertoire_entries, [:user_id, :song_id], unique: true
  end
end
