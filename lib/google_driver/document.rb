module GoogleDriver
  class Document
    attr_accessor :exports, :response

    def initialize(response, api)
      @response = response
      @exports = response.data.to_hash['exportLinks']
      @api = api
    end

    # Do we want mimetypes as getters?
    # doc.application/pdf doesn't sound like a good getter to me
    def make_getters(*links)
      class << self
        links.each do |link|
          attr_reader link.intern
        end
      end
    end

    def list
      @exports.keys
    end

    def download(type)
      loops = 0
      if @exports and @exports.keys.include? type
        @api.client.execute(uri: @exports[type]).body
      else
        if loops > 5
          break
        end
        loops+=1
        sleep(5)
        self.download(type)
      end
    end
  end
end
