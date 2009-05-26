class FlightCo2CalculationsController < ApplicationController
  before_filter :find_user
  
  def new
    
  end
  
  def create
    
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