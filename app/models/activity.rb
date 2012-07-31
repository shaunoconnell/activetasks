class Activity
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  embeds_many :followers, :class_name=>"User"
  #embeds_many :followers, store_as: :user

  belongs_to :user
  has_many :activity_posts

  #alias_method :followers, :users
end
