# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_flight_calculator_session',
  :secret      => '1e10e273a6e55b2fdc3a031666c015213295962788db05eb4f533793141276f64dce38168c09e36dc70efd1f2423c7b5b9ef8d561d94669f24a393b36d435369'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
