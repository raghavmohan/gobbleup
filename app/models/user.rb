class User < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :name, :email, :phone_number
  attr_accessor :friends
  has_and_belongs_to_many :events

  validates :phone_number, presence: true, phone_number: true, :on=> :update
  validates :email, presence: true, email_address: true, :on=> :update
  has_many :created_events, :class_name => "Event", :foreign_key => :creator_id

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
