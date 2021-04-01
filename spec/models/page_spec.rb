require 'rails_helper'

RSpec.describe Page, type: :model do
  describe "#title" do
    it "is used as the friendly id slug" do
      page = create(:page, title: "hello world")
      expect(page.slug).to eq("hello-world")
      expect(Page.friendly.find('hello-world').id).to eq(page.id)
    end
  end

  describe "#background_image" do
    it "is attached via active storage" do
      page = create(:page)

      page.background_image.attach(
        io: File.open("spec/support/storage/pages/background_image.jpg"),
        filename: "background_image.jpg",
        content_type: "image/jpg"
      )

      expect(page.background_image).to be_attached
      expect(url_for(page.background_image)).to match(
        active_storage_url_pattern('background_image.jpg')
      )
    end
  end
end
