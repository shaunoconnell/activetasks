class User
  include Mongoid::Document
  include Mongoid::Timestamps

  #name, email, pic-small, pic-large, fb-id,fb-friends, channel
  field :name, type: String
  field :email, type: String

  has_many :activities
end
