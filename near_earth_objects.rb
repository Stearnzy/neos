require 'faraday'
require 'figaro'
require 'pry'
require 'json'

require_relative 'neos_api_service'
require_relative 'astroid'
# Load ENV vars via Figaro
Figaro.application = Figaro::Application.new(environment: 'production', path: File.expand_path('config/application.yml', __dir__))
Figaro.load

class NearEarthObjects
  def self.find_neos_by_date(date)
    {
      astroid_list: formatted_astroid_data(date),
      biggest_astroid: largest_astroid_diameter(date),
      total_number_of_astroids: total_number_of_astroids(date)
    }
  end

  def self.objectify_astroids(date)
    NeosApiService.new.get_astroids(date).map do |astroid|
      Astroid.new(astroid)
    end
  end

  def self.formatted_astroid_data(date)
    objectify_astroids(date).map do |astroid|
      {
        name: astroid.name,
        diameter: "#{astroid.diameter.to_i} ft",
        miss_distance: "#{astroid.miss_distance.to_i} miles"
      }
    end
  end

  def self.largest_astroid_diameter(date)
    objectify_astroids(date).max_by do |astroid|
      astroid.diameter
    end.diameter.to_i
  end

  def self.total_number_of_astroids(date)
    objectify_astroids(date).count
  end
end
