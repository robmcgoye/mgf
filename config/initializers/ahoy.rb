class Ahoy::Store < Ahoy::DatabaseStore
  def track_visit(data)
    data[:country] = request.headers["cf-ipcountry"]
    data[:city] = request.headers["cf-ipcity"]
    data[:latitude] = request.headers["cf-iplatitude"]
    data[:longitude] = request.headers["cf-iplongitude"]
    super(data)
  end
end

# set to true for JavaScript tracking
Ahoy.api = false
Ahoy.visit_duration = 30.minutes

# set to true for geocoding (and add the geocoder gem to your Gemfile)
# we recommend configuring local geocoding as well
# see https://github.com/ankane/ahoy#geocoding

# class Ahoy::Store < Ahoy::DatabaseStore
#   def track_visit(data)
#     byebug
#     data[:country] = request.headers["<country-header>"]
#     data[:region] = request.headers["<region-header>"]
#     data[:city] = request.headers["<city-header>"]
#     super(data)
#   end
# end
