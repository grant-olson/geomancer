require_relative './zips'

module Geode
  module ZipCode
    def self.geolocate address
      address ||= ""
      zip = address.match(/^(?:.* )?(\d\d\d\d\d)(?:-\d\d\d\d)?$/)

      if zip.nil? || zip[1].nil?
        lat = nil
        long = nil
      else
        zip_code = ZIP_CODES[zip[1]]

        if zip_code.nil?
          lat = nil
          long = nil
        else
          lat = zip_code[:latitude]
          long = zip_code[:longitude]
        end
        
      end
      
      {:latitude => lat, :longitude => long}
    end

  end
end
