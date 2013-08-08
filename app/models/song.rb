class Song < ActiveRecord::Base
  has_and_belongs_to_many :repertoires
  has_many :users, through: :repertoires
end
