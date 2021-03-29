require "rails_helper"

RSpec.describe OauthProvider do
  describe ".brand_name" do
    %i[
      docusign
      calendly
    ].each do |provider|
      it "has a response for #{provider}" do
        expected = OauthProvider::BRAND_NAMES[provider]
        expect(OauthProvider.brand_name(provider)).to eq(expected)
      end
    end

    it "returns a not-found message for anything else" do
      expect(OauthProvider.brand_name('foo')).to eq(
        "OauthProvider.brand_name not found for: foo"
      )
    end
  end
end
