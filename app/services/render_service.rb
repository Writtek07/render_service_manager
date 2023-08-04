class RenderService
    def self.list_services
      url = URI("https://api.render.com/v1/services")
  
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
  
      request = Net::HTTP::Get.new(url)
      request["accept"] = 'application/json'
      request["authorization"] = "Bearer #{ENV['RENDER_API_KEY'] || Rails.application.credentials.dig(:RENDER_API_KEY) }"
  
      response = http.request(request)
      render_data = JSON.parse(response.read_body)
    end

    def self.start_service(service_id)
        url = URI("https://api.render.com/v1/services/#{service_id}/resume")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true

        request = Net::HTTP::Post.new(url)
        request["accept"] = 'application/json'
        request["authorization"] = "Bearer #{ENV['RENDER_API_KEY'] || Rails.application.credentials.dig(:RENDER_API_KEY) }"

        response = http.request(request)        
        response.read_body
    end
    
    def self.stop_service(service_id)
        url = URI("https://api.render.com/v1/services/#{service_id}/suspend")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true

        request = Net::HTTP::Post.new(url)
        request["accept"] = 'application/json'
        request["authorization"] = "Bearer #{ENV['RENDER_API_KEY'] || Rails.application.credentials.dig(:RENDER_API_KEY)}"

        response = http.request(request)        
        response.read_body
    end
end