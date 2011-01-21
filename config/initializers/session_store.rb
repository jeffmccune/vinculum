# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_puppetcontroller_session',
  :secret      => '30dfd3a8808b3677675d42fabb26e965ab23630e22c5c95b8e87fcbd16a3542257d04459d09662fd6dda9a8bd4faa9630256c07f0c7492a7a4b05c74cb9c71be'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
