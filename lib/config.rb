# frozen_string_literal: true

# Gem Requirements
require 'open-uri'
require 'json'
require 'ipaddr'
require 'geocoder'
require 'csv'
require 'time'
require 'date'
require 'tty-prompt'
require 'tty-spinner'
require 'tty-box'

# preferences
  # Geocoder.configure(:timeout => 1)
# state tracking

# class State
#   def self.internet_connection
#   end
#   def data_cond
#   relevant_data = File.file?('./weather_data.json') and 
#   if internet_connection == true and relevant_data
#   end
# end

