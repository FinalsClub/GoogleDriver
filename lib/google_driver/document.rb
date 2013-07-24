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
      if @exports.keys.include? type
        @api.client.execute(uri: @exports[type]).body
      end
    end
  end
end
