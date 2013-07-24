require 'google/api_client'

module GoogleDriver
  class Api
    attr_accessor :client, :drive

    def initialize(scope, issuer, p12_path)
      @oauth_scope = scope
      @issuer = issuer
      @p12_path = p12_path

      google_authorize
    end

    def google_authorize
      @client = Google::APIClient.new(application_name:"GooDrive", application_version:VERSION)
      @drive = @client.discovered_api('drive', 'v2')

      # Create a new server<>server based API client
      key = Google::APIClient::KeyUtils.load_from_pkcs12(@p12_path, 'notasecret')

      # Request Auth
      @client.authorization = Signet::OAuth2::Client.new(
          token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
          audience: 'https://accounts.google.com/o/oauth2/token',
          scope: @oauth_scope,
          issuer: @issuer,
          signing_key: key)

        @client.authorization.fetch_access_token!
    end

    def detect_mimetype(file)
      # use the unix `file` program to get the mimetype of the file
      %x<file --mime-type '#{file}'>.split(':')[1].strip()
      # check success with $?.success? (perlism)
    end


    # ::file            path to a file you wish to upload [REQUIRED]
    # ::title           title of the document for browsing on google drive
    # ::description     description of the document for browsing on google drive
    def upload(file, title="A document", description="Words, words, words")
      #
      # TODO: throw warning if people don't name documents

      resource = @drive.files.insert.request_schema.new(
        'title' => title,
        'description' => description
      )

      mimetype = detect_mimetype(file)

      media = Google::APIClient::UploadIO.new(file, mimetype)

      response = @client.execute(
        api_method: @drive.files.insert,
        body_object: resource,
        media: media,
        parameters: {
          'uploadType' => 'multipart',
          'convert' => true,
          'alt' => 'json'})
      Document.new(response, self)
    end

    def upload_files(*files)
      files.map do |file|
        upload(file)
      end
    end
  end
end
