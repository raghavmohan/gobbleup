class Event < ActiveRecord::Base
  attr_accessible :location, :description, :latitude, :longitude, :user_ids
  has_and_belongs_to_many :users
  belongs_to :creator, :class_name => "User", :foreign_key => :creator_id
end
