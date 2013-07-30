module GoogleDriver
  class Document
    attr_accessor :exports, :response, :file_id

    def initialize(response, api)
      @api = api
      @drive = get_drive_api

      @response = response
      @file_id = response.data.to_hash['id']
      @exports = response.data.to_hash['exportLinks']
    end

    # refresh document information
    # used when we don't immediate get exportLinks in the response
    def update
      response = @api.client.execute(
          api_method: @drive.files.get,
          :parameters => { 'fileId' => @file_id }
          )
      @response = response
      @file_id = response.data.to_hash['id']
      @exports = response.data.to_hash['exportLinks']
    end

    def list
      @exports.keys
    end

    def get_drive_api
      @drive = @api.client.discovered_api('drive', 'v2')
    end

    def download(type)
      loops = 0
      while loops < 5 do
        self.update()
        if @exports and @exports.keys.include?(type)
          return @api.client.execute(uri: @exports[type]).body
        else
          loops+=1
          sleep(5*loops) # Wait an increasing amount of time between loops
        end
      end
    end
  end
end
