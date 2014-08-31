class Song < ActiveRecord::Base
  default_scope { includes(:artist).order("UPPER(title)") }
  scope :starts_with, ->(starts_with) { where("title ILIKE ?", "#{starts_with}%") }

  belongs_to :artist
end
