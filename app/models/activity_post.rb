class ActivityPost
  include Mongoid::Document
  include Mongoid::Timestamps
  #user, followers [], activity (Activity), post_time, activity_time

  field :description, type: String
  #field :occurred_at, type: DateTime

  belongs_to :activity

  validates :description, :activity, :presence => true
end
