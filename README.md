# Geomancer

This is just an extremely simple wrapper around some geolocation code
we use at [WebKite](http://webkite.com).

By default it will just try to extract a US Zip Code from an address
and geolocate coordinates based on an [extremely sophisticated
in-memory NoSQL store](./lib/geomancer/zips.rb?raw=true) known as a
["hash"](http://www.ruby-doc.org/core-2.1.1/Hash.html).

But if configured, it can use
[geocoder](https://github.com/alexreisner/geocoder) to do more refined
geolocation.

This way we ge (albeit bad) results in development and test
environments without having to pay a commercial service, but (good)
results which we're gladly willing to pay for in production
environments.

Usage:

```
require 'geomancer'

# Get a hash with lat/long
Geomancer.geolocate("700 River Avenue Suite 440 Pittsburgh, PA 15217")

# Use yahoo boss
Geomancer.configure(:yahoo, :api_key => [*id*, *secret*])

# Explicitly force bad zip code lookups
Geomancer.configure(:zip_code)

```
