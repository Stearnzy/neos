class Astroid
  attr_reader :name, :diameter, :miss_distance

  def initialize(data)
    @name = data[:name]
    @diameter = data[:estimated_diameter][:feet][:estimated_diameter_max]
    @miss_distance = data[:close_approach_data][0][:miss_distance][:miles]
  end
end
