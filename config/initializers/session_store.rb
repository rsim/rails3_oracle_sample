# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_rails3_oracle_sample_session',
  :secret => '1a8ff98628f753c9caec53f78cf6a742807dbfdbfde6924d91f5f7b158729a21f1ee40105bf0a203258a02bb5a529fd692a8db8db35e6beb1d36c640817d775d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
