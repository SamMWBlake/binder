class CreateRepertoiresAndSongs < ActiveRecord::Migration
  def change
    create_table :repertoires_songs do |t|
      t.belongs_to :repertoire
      t.belongs_to :song
    end
  end
end
