# Geode

This is just a simple wrapper around some geolocation code.  By
default it will just try to extract a US Zip Code from an address and
provide those coordinates.  If configured, it can use
[geocoder](https://github.com/alexreisner/geocoder) to do more refined
geolocation.

This way we ge some (albeit bad) results in development and test
environments without having to pay a service, but some (good) results
that we're willing to pay for in production environments.

Usage:

```
require 'geode'

# Get a hash with lat/long
Geode.geolocate("700 River Avenue Suite 440 Pittsburgh, PA 15217")

# Use yahoo boss
Geode.configure(:yahoo, :api_key => [*id*, *secret*])

# Explicitly force bad zip code lookups
Geode.configure(:zip_code)

```