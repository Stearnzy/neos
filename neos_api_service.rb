class NeosApiService
    def get_asteroids(date)
        response = retreive_data(date)
        parse(response, date)
    end

private
    def access_api(date)
        Faraday.new(
         url: 'https://api.nasa.gov',
         params: { start_date: date, api_key: ENV['nasa_api_key']}
          )
    end

    def retreive_data(date)
        access_api(date).get('/neo/rest/v1/feed')
    end

    def parse(response, date)
        JSON.parse(response.body, symbolize_names: true)[:near_earth_objects][:"#{date}"]
    end
end