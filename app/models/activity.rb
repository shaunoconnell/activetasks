class Activity
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :follower_ids, type: Array



  belongs_to :user
  has_many :activity_posts

  validates :name, :user, :presence => true


  #alias_method :followers, :users
end
