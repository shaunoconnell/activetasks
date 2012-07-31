class User
  include Mongoid::Document
  include Mongoid::Timestamps

  #name, email, pic-small, pic-large, fb-id,fb-friends, channel
  field :name, type: String
  field :email, type: String

  validates_uniqueness_of :email

  has_many :activities

  #embedded_in :activity
end
