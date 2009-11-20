class FlightCo2CalculationsController < ApplicationController 
  before_filter :get_airports, :only => :create 
  
  def new
    # render default template
  end
  
  def create
    if @origin_airport && @destination_airport
      # Create a profile if there isn't one already stored in the session
      session[:profile] ||= AMEE::Profile::Profile.create(global_amee_connection).uid
      uid = AMEE::Data::DrillDown.get(global_amee_connection, "/data/transport/plane/generic/drill?size=#{@return_flight ? "return" : "one%20way"}&type=auto").data_item_uid
      @item = AMEE::Profile::Item.create_without_category(
        global_amee_connection, 
        "/profiles/#{session[:profile]}/transport/plane/generic",
        uid,
        :IATACode1 => @origin_airport.iata_code, 
        :IATACode2 => @destination_airport.iata_code,
        :name => UUIDTools::UUID.timestamp_create.to_s)
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
