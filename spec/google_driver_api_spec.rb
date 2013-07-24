require "spec_helper"

describe GoogleDriver::Api do

  let (:api) { GoogleDriver::Api.new(PRIVATE['scope'], PRIVATE['issuer'], PRIVATE['p12_path']) }

  it "detects the Mime Type of the file to be uploaded" do
    expect(api.detect_mimetype(file_doc)).to eq('application/msword')
    #expect(@api.modified_on).to eq('Wed, 12 Feb 1997 16:29:51 -0500')
    #expect(@api.filename).to eq('test_doc.doc')
  end

  it "should authorize our Google API client" do
    # This is a poor test.
    # Maybe get the entirety of api.client and check that len > 500 ?
    expect(api.client).to be_kind_of Google::APIClient
  end

  it "should upload a file" do
    expect(api.upload(file_doc)).to be_kind_of GoogleDriver::Document
  end

  it "should accept multiple file uploads at once" do
    expect(api.upload_files(file_doc, file_ppt).count).to eq(2)
  end
end
