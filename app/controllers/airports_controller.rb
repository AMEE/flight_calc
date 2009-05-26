class AirportsController < ApplicationController
  
  # searching for airport via ajax type calls
  def search
    if !params[:airport].blank?
      @airports = Airport.search(params[:airport])
      render :json => @airports.map{|airport| [:id => airport.id, :address => airport.display]}.flatten.to_json rescue [:error_code => 0].to_json
    end
  end
end