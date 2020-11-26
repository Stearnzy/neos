class NeosView
    attr_reader :astroid_list, :total_number_of_astroids, :biggest_astroid

    def initialize(astroid_details)
        # @astroid_details = astroid_details
        @astroid_list = astroid_details[:astroid_list]
        @total_number_of_astroids = astroid_details[:total_number_of_astroids]
        @biggest_astroid = astroid_details[:biggest_astroid]
    end

    

#    def welcome_message
#     puts "________________________________________________________________________________________________________________________________"
#     puts "Welcome to NEO. Here you will find information about how many meteors, astroids, comets pass by the earth every day. \nEnter a date below to get a list of the objects that have passed by the earth on that day."
#     puts "Please enter a date in the following format YYYY-MM-DD."
#     print ">>"    
#    end 
end