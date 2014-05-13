require "geomancer/version"
require "geomancer/zip_code"

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

      cache = opts.delete(:cache)
      geocoder_config = { :engine => opts }
      geocoder_config[:cache] = cache if cache
      
      Geocoder.configure(geocoder_config)
    end
  end

  LAT_LONG_RE = /lat(itude)?:\s+(?<latitude>[\d\.\-]+)[\s,]+long(itude)?:\s+(?<longitude>[\d\.\-]+)/

  def self.extract_lat_and_long address
    matches = LAT_LONG_RE.match(address)

    return nil if !matches

    latitude = matches["latitude"]
    longitude = matches["longitude"]

    return nil if !(latitude && longitude)

    return {:latitude => latitude.to_f, :longitude => longitude.to_f}
  end

  def self.zip_code_only? address
    address.match(/^\d\d\d\d\d(?:-\d\d\d\d)?$/)
  end

  def self.geolocate address
    return Geomancer::ZipCode.geolocate(address) if zip_code_only?(address)

    lat_and_long = extract_lat_and_long(address)
    return lat_and_long if lat_and_long

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
