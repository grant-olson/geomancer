require "geomancer/version"

module Geomancer
  # Your code goes here...
  def self.configure(engine, opts={})
    @engine = engine
    @options = opts

    case @engine
    when :zip_code then
      require_relative './geomancer/zip_code'
    else
      require 'geocoder'
      Geocoder.configure(engine => opts)
    end
  end

  def self.geolocate address
    if !@engine
      warn("No configuration provided.  Defaulting to zip code geolocator")
      configure(:zip_code)
    end

    case @engine
    when :zip_code then
      Geomancer::ZipCode.geolocate(address)
    else
      address = address.gsub(/[\r\n]/,", ") # Yahoo doesn't like newlines
      results = Geocoder.search(address)
      return nil if results.empty?

      first_result = results.first
      {:latitude => first_result.latitude, :longitude => first_result.longitude}
    end
  end
end
