Geocoder.configure(
  ip_lookup: :geoip2,
  geoip2: {
    file: "maxmind/GeoLite2-City.mmdb"
  }
  # ip_lookup: :maxmind_local,
  # maxmind_local: {
  #   file: "/usr/share/GeoIP/GeoIP.dat",
  #   package: :country
  # }
)