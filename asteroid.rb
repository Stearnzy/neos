class Asteroid
    def initialize(data)
        @name = data[:name]
        # Diameter is a FLOAT
        @diameter = data[:estimated_diameter][:feet][:estimated_diameter_max]
        # Miss Distance is a STRING
        @miss_distance = data[:close_approach_data][0][:miss_distance][:miles]
    end
end