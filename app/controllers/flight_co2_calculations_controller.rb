class FlightCo2CalculationsController < ApplicationController 
  before_filter :get_airports, :only => :create 
  
  def new
    # render default template
  end
  
  def create
    if @origin_airport && @destination_airport
      @data_item = Rails.cache.fetch([@origin_airport, @destination_airport,"data-item-#{@return_flight}"]) do
        data_item_uid =  @return_flight ? AmeeConnection.auto_return_uid : AmeeConnection.auto_oneway_uid
        AmeeConnection.session.get_data_item("/data/transport/plane/generic/#{data_item_uid}", 
          :query => {:IATACode1 => @origin_airport.iata_code, :IATACode2 => @destination_airport.iata_code})
      end
      @distance = Airport.distance(@origin_airport, @destination_airport, @return_flight)
    else
      render :new
    end
  end
  
  protected
  def get_airports
    @return_flight = params[:flight_co2_calculation][:return]
    @origin_id = params[:flight_co2_calculation][:origin_airport_id]
    @destination_id = params[:flight_co2_calculation][:destination_airport_id]
    if !@origin_id.empty? && !@destination_id.empty?
      @origin_airport = Rails.cache.fetch("airport-#{@origin_id}") {Airport.find(@origin_id)}
      @destination_airport = Rails.cache.fetch("airport-#{@destination_id}") {Airport.find(@destination_id)}
    end
  end
end