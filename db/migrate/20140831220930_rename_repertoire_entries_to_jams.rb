class RenameRepertoireEntriesToJams < ActiveRecord::Migration
  def change
    rename_table :repertoire_entries, :jams
  end
end
