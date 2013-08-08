class RemoveIdFromRepertoiresSongs < ActiveRecord::Migration
  def change
    remove_column :repertoires_songs, :id
  end
end
