require 'amee'

# enable logger before including everything else, in case we ever want to log initialization 
Amee.logger = RAILS_DEFAULT_LOGGER if Object.const_defined? :RAILS_DEFAULT_LOGGER
