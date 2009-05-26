class Airport < ActiveRecord::Base
  
  def display
    "#{self.name}, #{self.country}"
  end
  
  # Sphinx
  define_index do
    indexes :country
    indexes :name
    indexes :full_name
    indexes :iata_code
  end
end