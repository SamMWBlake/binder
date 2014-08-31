class User < ActiveRecord::Base
  attr_accessor :login

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  extend FriendlyId
  friendly_id :username

  validates_presence_of :username
  validates_uniqueness_of :username, case_sensitive: false
  validates_format_of :username, :with => /\A[a-z0-9-]+\z/i
  validates :username, length: { in: 1..50 }

  has_many :jams
  has_many :songs, through: :jams

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
end
