module ActiveStorageHelper
  def active_storage_url_pattern(filename)
    %r{http://test.host/rails/active_storage/blobs/redirect/[a-zA-Z0-9\-]+/#{filename}}
  end

  def attach_options(filepath, content_type: 'image/jpg')
    {
      io: File.open("spec/support/storage/#{filepath}"),
      filename: filepath.split('/').last,
      content_type: content_type,
    }
  end
end

RSpec.configure do |config|
  config.include ActiveStorageHelper
end
