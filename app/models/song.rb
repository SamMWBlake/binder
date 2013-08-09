class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :repertoire_entries
  has_many :users, through: :repertoire_entries
end
