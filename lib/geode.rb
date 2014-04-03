require "geode/version"

module Geode
  # Your code goes here...
  def self.configure(engine, opts={})
    @engine = engine
    @options = opts

    case @engine
    when :zip_code then
      require_relative './geode/zip_code'
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
      Geode::ZipCode.geolocate(address)
    else
      results = Geocoder.search(address)
      return nil if results.empty?

      first_result = results.first
      {:latitude => first_result.latitude, :longitude => first_result.longitude}
    end
  end
end
