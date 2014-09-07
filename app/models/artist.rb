class Artist < ActiveRecord::Base
  default_scope { order("UPPER(name)") }
  scope :starts_with, ->(starts_with) { where("name ILIKE ?", "#{starts_with}%") }

  has_many :songs

  def to_autocompletable
    { name: name }
  end
end
