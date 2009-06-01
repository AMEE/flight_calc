class FlightCo2CalculationsController < ApplicationController  
  def new
    
  end
  
  def create
    if !params[:flight_co2_calculation][:from_airport_id].empty? && !params[:flight_co2_calculation][:to_airport_id].empty?
      from_airport  = Rails.cache.fetch("airport-#{params[:flight_co2_calculation][:from_airport_id]}") {Airport.find(params[:flight_co2_calculation][:from_airport_id])}
      to_airport  = Rails.cache.fetch("airport-#{params[:flight_co2_calculation][:to_airport_id]}") {Airport.find(params[:flight_co2_calculation][:to_airport_id])}
      
      @data_item = Rails.cache.fetch("cnn-flight-#{params[:flight_co2_calculation][:from_airport_id]}-#{params[:flight_co2_calculation][:to_airport_id]}-#{params[:flight_co2_calculation][:return]}") do
        data_item_uid =  params[:flight_co2_calculation][:return] ? AmeeConnection.auto_return_uid : AmeeConnection.auto_oneway_uid
        AmeeConnection.session.get_data_item("/data/transport/plane/generic/#{data_item_uid}", 
          :query => {:IATACode1 => from_airport.iata_code, :IATACode2 => to_airport.iata_code})
      end
      @distance = Rails.cache.fetch("cnn-flight-distance-#{params[:flight_co2_calculation][:from_airport_id]}-#{params[:flight_co2_calculation][:to_airport_id]}-#{params[:flight_co2_calculation][:return]}") do
        params[:flight_co2_calculation][:return] ? Haversine.distance_between(from_airport, to_airport) * 2 : Haversine.distance_between(from_airport, to_airport)
      end
    else
      flash[:notice] = "Please select your airports"
      render :new
    end
  end
end