class Song < ActiveRecord::Base
  has_many :repertoire_entries
  has_many :users, through: :repertoire_entries
end
