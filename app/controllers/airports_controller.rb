class AirportsController < ApplicationController
  
  def search
    if !params[:airport].blank?
      @airports = Rails.cache.fetch("airport-search-#{params[:airport].gsub(/\W/,"-")}") do 
        airports = Airport.search("#{params[:airport]}*")
        airports.map{|airport| [:id => airport.id, :address => airport.display]}.flatten.to_json
      end
      render :json => @airports
    end
    rescue => e 
      render :json => [:error_code => 0].flatten.to_json
  end
end