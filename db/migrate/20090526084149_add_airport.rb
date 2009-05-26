class AddAirport < ActiveRecord::Migration
  def self.up
    create_table :airports, :force => true do |t|
      t.string :country, :name, :iata_code, :full_name
      t.float :latitude, :longitude
      t.timestamps
    end
  end

  def self.down
    drop_table :airports
  end
end
