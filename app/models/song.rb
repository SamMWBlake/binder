class Song < ActiveRecord::Base
  has_many :users, through: :repertoire_entries
end
