require 'faraday'
require 'figaro'
require 'pry'
require 'json'

require_relative 'neos_api_service'
require_relative 'astroid'
# Load ENV vars via Figaro
Figaro.application = Figaro::Application.new(environment: 'production', path: File.expand_path('../config/application.yml', __FILE__))
Figaro.load

class NearEarthObjects
  def self.find_neos_by_date(date)
    parsed_astroids_data = NeosApiService.new.get_astroids(date)
    # conn = Faraday.new(
    #   url: 'https://api.nasa.gov',
    #   params: { start_date: date, api_key: ENV['nasa_api_key']}
    # )
    # astroids_list_data = conn.get('/neo/rest/v1/feed')
    # parsed_astroids_data = JSON.parse(astroids_list_data.body, symbolize_names: true)[:near_earth_objects][:"#{date}"]
    
    astroid_objects = parsed_astroids_data.map do |astroid|
      Astroid.new(astroid)
    end

    # {
    #   astroid_list: astroid_objects, 
    #   biggest_astroid: astroid_objects.max_by {|asteroid| asteroid.diameter}, 
    #   total_number_of_astroids: astroid_objects.count
    # }

    largest_astroid_diameter = (astroid_objects.max_by {|x| x.diameter}).diameter.to_i

    # largest_astroid_diameter = parsed_astroids_data.map do |astroid|
    #   astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i
    # end.max { |a,b| a<=> b}

    total_number_of_astroids = astroid_objects.count

    formatted_astroid_data = astroid_objects.map do |astroid|
      {
        name: astroid.name, 
        diameter: "#{astroid.diameter.to_i} ft", 
        miss_distance: "#{astroid.miss_distance.to_i} miles"
      }
    end

    # formatted_astroid_data = parsed_astroids_data.map do |astroid|
    #   {
    #     name: astroid[:name],
    #     diameter: "#{astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i} ft",
    #     miss_distance: "#{astroid[:close_approach_data][0][:miss_distance][:miles].to_i} miles"
    #   }
    # end

    {
      astroid_list: formatted_astroid_data,
      biggest_astroid: largest_astroid_diameter,
      total_number_of_astroids: total_number_of_astroids
    }
  end
end
