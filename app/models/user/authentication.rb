class User::Authentication < ApplicationRecord
  belongs_to :registration

  scope :docusign, -> { where(provider: :docusign) }

  def email
    info["email"]
  end
end
