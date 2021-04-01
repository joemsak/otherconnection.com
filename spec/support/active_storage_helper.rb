module ActiveStorageHelper
  def active_storage_url_pattern(filename)
    %r{http://test.host/rails/active_storage/blobs/redirect/[a-zA-Z0-9\-]+/#{filename}}
  end
end

RSpec.configure do |config|
  config.include ActiveStorageHelper
end
