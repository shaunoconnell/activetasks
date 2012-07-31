class ActivityPost
  include Mongoid::Document
  include Mongoid::Timestamps
  #user, followers [], activity (Activity), post_time, activity_time

  field :followers, type: Array
  field :occurred_at, type: DateTime

  belongs_to :activity
end
