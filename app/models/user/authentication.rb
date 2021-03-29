class User::Authentication < ApplicationRecord
  belongs_to :registration

  scope :docusign, -> { where(provider: :docusign) }

  def email
    info_email || extra_raw_info_resource_email
  end

  private
  def info_email
    info["email"].presence
  end

  def extra_raw_info_resource_email
    extra_raw_info_resource["email"].presence
  end

  def extra_raw_info_resource
    extra_raw_info.fetch("resource") { {} }
  end

  def extra_raw_info
    extra["raw_info"]
  end
end
