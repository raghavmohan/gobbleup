class AddDescriptionAndLocationAndLatitudeAndLongitudeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :description, :string
    add_column :events, :location, :string
    add_column :events, :latitude, :float
    add_column :events, :longitude, :float
  end
end
