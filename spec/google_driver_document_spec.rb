require "spec_helper"

describe GoogleDriver::Document do
  let (:api) { GoogleDriver::Api.new(PRIVATE['scope'], PRIVATE['issuer'], PRIVATE['p12_path']) }
  let (:doc) { api.upload(file_doc) }

  it "should have an exports hash with 1 or more keys" do
    expect(doc.exports.keys.count).to be > 2
  end

  it "should have the original response available" do
    expect(doc.response).to be_kind_of Google::APIClient::Result
  end

  it "should list the available export downloads" do
    expect(doc.list).to be_kind_of Array
  end

  it "should reject a download if it doesn't recognize the type" do
    pending
    expect(-> { doc.download('this is not a mimetype') }).to raise_exception
  end

  it "should return the HTML of an uploaded document" do
    expect(doc.download('text/html')[0..5]).to eq '<html>'
  end
end
