class NeosApiService
    # def get_asteroids_data
        
    # end

    def conn(date)
        Faraday.new(
         url: 'https://api.nasa.gov',
         params: { start_date: date, api_key: ENV['nasa_api_key']}
          )
    end
end