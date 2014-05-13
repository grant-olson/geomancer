* If an address looks like a zip code, don't ever do 'real' 
  geolocation and fall back to the static lookup.

* If an address looks something like "latitude: 41.9040, longitude:
  12.4530" just extract the numbers and trust that's what we want
  instead of 'real' geolocation.

* Support :cache option to save results: `cache => Redis.new`

0.6.1 - 2014-04-09
==================

*   Strip newlines from address since Yahoo BOSS doesn't like them.

0.6.0 - 2014-04-03
==================

*   Initial Release.