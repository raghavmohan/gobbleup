class User < ActiveRecord::Base
  attr_accessible :content, :latitude, :longitude, :name, :title
end
