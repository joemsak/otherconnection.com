module OauthProvider
  BRAND_NAMES = {
    docusign: "DocuSign",
    calendly: "Calendly",
  }

  def self.brand_name(provider)
    BRAND_NAMES.fetch(provider.to_sym) {
      I18n.t("singletons.oauth_provider.brand_name.not_found", provider: provider)
    }
  end
end
