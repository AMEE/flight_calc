class FlightCo2CalculationsController < ApplicationController
  before_filter :find_user
  
  def new
    
  end
  
  def create
    from_airport  = Airport.find(params[:flight_co2_calculation][:from_airport_id])
    to_airport  = Airport.find(params[:flight_co2_calculation][:to_airport_id])
    # OBVIOSULY NOT "HARDCODED FOR REAL"
    @distance = Haversine.distance_between(from_airport, to_airport)
    @data_item = AmeeConnection.session.get_data_item("/data/transport/plane/generic/FFC7A05D54AD", 
      :query => {:IATACode1 => from_airport.iata_code, :IATACode2 => to_airport.iata_code})
  end
  
  protected
  def find_user
    # we dont know how the user is going to be found just yet 
    # this will probably be from the cookie that cnn will have 
    # to set; therefore we will either have a profile or a none
    # profile for that user;
    #
  end
end