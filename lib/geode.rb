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
      raise "Unknown engine #{engine.inspect}!!!"
    end
  end

  def self.geolocate address
    raise "Not configured!!!" if !@engine

    case @engine
    when :zip_code then
      Geode::ZipCode.geolocate(address)
    else
      raise "Unknown engine #{@engine.inspect}!!!"
    end
      
  end
  

end
