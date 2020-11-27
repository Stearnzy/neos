require 'pry'

require_relative 'near_earth_objects'
require_relative 'neos_view'

NeosView.welcome_message

date = gets.chomp
astroid_details = NearEarthObjects.find_neos_by_date(date)

output = NeosView.new(astroid_details)

output.display_info(date)
