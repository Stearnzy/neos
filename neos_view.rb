class NeosView
    attr_reader :astroid_list, :total_number_of_astroids, :biggest_astroid

    def initialize(astroid_details)
        @astroid_details = astroid_details
        @astroid_list = astroid_details[:astroid_list]
        @total_number_of_astroids = astroid_details[:total_number_of_astroids]
        @biggest_astroid = astroid_details[:biggest_astroid]
    end

    def self.welcome_message
        puts "________________________________________________________________________________________________________________________________"
        puts "Welcome to NEO. Here you will find information about how many meteors, astroids, comets pass by the earth every day. \nEnter a date below to get a list of the objects that have passed by the earth on that day."
        puts "Please enter a date in the following format YYYY-MM-DD."
        print ">>"
    end

    def column_labels
        { name: "Name", diameter: "Diameter", miss_distance: "Missed The Earth By:" }
    end

    def column_data
        self.column_labels.each_with_object({}) do |(col, label), hash|
            hash[col] = {
            label: label,
            width: [self.astroid_list.map { |astroid| astroid[col].size }.max, label.size].max}
        end
    end

    def header 
        "| #{ self.column_data.map { |_,col| col[:label].ljust(col[:width]) }.join(' | ') } |"
    end

    def divider
        "+-#{self.column_data.map { |_,col| "-"*col[:width] }.join('-+-') }-+"
    end

        
    def format_row_data(row_data, column_info)
        row = row_data.keys.map { |key| row_data[key].ljust(column_info[key][:width]) }.join(' | ')
        puts "| #{row} |"
    end

    def create_rows(astroid_data, column_info)
        rows = astroid_data.each { |astroid| self.format_row_data(astroid, column_info) }
    end

    def formatted_date(date)
        DateTime.parse(date).strftime("%A %b %d, %Y")
    end

    def display_info(date)
        puts "______________________________________________________________________________"
        puts "On #{self.formatted_date(date)}, there were #{self.total_number_of_astroids} objects that almost collided with the earth."
        puts "The largest of these was #{self.biggest_astroid} ft. in diameter."
        puts "\nHere is a list of objects with details:"
        puts self.divider
        puts self.header
        self.create_rows(self.astroid_list, self.column_data)
        puts divider
    end

    # binding.pry
    # column_labels = { name: "Name", diameter: "Diameter", miss_distance: "Missed The Earth By:" }
    # column_data = column_labels.each_with_object({}) do |(col, label), hash|
    # binding.pry
    #     hash[col] = {
    #         label: label,
    #         width: [@astroid_list.map { |astroid| astroid[col].size }.max, label.size].max}
    # end

    # header = "| #{ column_data.map { |_,col| col[:label].ljust(col[:width]) }.join(' | ') } |"
    # divider = "+-#{column_data.map { |_,col| "-"*col[:width] }.join('-+-') }-+"

        
        #     formated_date = DateTime.parse(date).strftime("%A %b %d, %Y")
        #     puts "______________________________________________________________________________"
        #     puts "On #{formated_date}, there were #{total_number_of_astroids} objects that almost collided with the earth."
        #     puts "The largest of these was #{largest_astroid} ft. in diameter."
        #     puts "\nHere is a list of objects with details:"
        #     puts divider
        #     puts header
        #     create_rows(astroid_list, column_data)
        #     puts divider
end