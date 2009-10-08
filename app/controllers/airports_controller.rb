class AirportsController < ApplicationController
  
  def search
    if !params[:airport].blank?
      @airports = Rails.cache.fetch("airport-search-#{params[:airport].gsub(/\W/,"-")}") do 
        query = "#{params[:airport]}%"
        airports = Airport.find(:all, :conditions => ["name LIKE :query OR country LIKE :query OR country LIKE :query OR iata_code LIKE :query", {:query => query}])
        airports.map{|airport| [:id => airport.id, :address => airport.display]}.flatten.to_json
      end
      render :json => @airports
    end
    rescue => e 
      render :json => [:error_code => 0].flatten.to_json
  end
end
