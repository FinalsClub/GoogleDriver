GoogleDriver
============

A ruby gem for processing word and other common document formats to html using google drive's api

## Using this gem
### GoogleDriver::Api

The api object needs three values to be initalized:

    oauth_scope:  (ex: https://www.googleapis.com/auth/drive)
    issuer:       Privided by Google's api console (ex: 1111111111@developer.gserviceaccount.com)
    p12_path:     Path to your Google provided API private key (ex: ./c37373737373737...-privatekey.p12)
    
----

    api = GoogleDriver::Api.new(PRIVATE['scope'], PRIVATE['issuer'], PRIVATE['p12_path'])

#### Usage

    doc = api.upload('./path/to/file')
    mimetype = api.detect_mimetype('./path/to/file')
    docs = api.upload_files(['./path/to/fileA', './path/to/fileB', './path/to/fileC'])
    # => [Document(FileA), Document(FileB), Document(FileC)]

### GoogleDriver::Document

Document instances are emitted by `api.upload()` and represent a document uploaded to Google Drive. 
The Document can be exported from Google in a number of export formats depending on the original filetype.

#### Usage

    doc.list  # returns the available mimetypes that can be downloaded from Google Drive for this file
    doc.download(mimety
