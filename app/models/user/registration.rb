class User::Registration < ApplicationRecord
  has_secure_token :session_token, length: 36
  has_secure_token :auth_token, length: 36

  has_many :authentications

  has_one :docusign_authentication,
    -> { docusign },
    class_name: "Authentication"

  def self.auth_token(query)
    find_auth_token_by_secure_query(query)
  end

  def self.find_or_create_by_auth(auth_hash)
    registration = find_or_initialize_by(email: auth_hash[:info][:email])

    authentication = registration.authentications.find_or_initialize_by(
      provider: auth_hash[:provider],
      uid: auth_hash[:uid]
    )

    registration.update(name: auth_hash[:info][:name])

    authentication.update(
      info: auth_hash[:info],
      credentials: auth_hash[:credentials],
      extra: auth_hash[:extra],
    )

    registration
  end

  def find_or_create_authentication(auth_hash)
    auth = authentications.find_or_initialize_by(
      provider: auth_hash[:provider],
      uid: auth_hash[:uid]
    )

    auth.update(
      info: auth_hash[:info],
      credentials: auth_hash[:credentials],
      extra: auth_hash[:extra],
    )

    auth
  end

  def authentication_exists?(provider)
    authentications.exists?(provider: provider)
  end

  def oauth_email(provider)
    if auth = authentications.find_by(provider: provider)
      auth.email
    end
  end

  private
  def self.find_auth_token_by_secure_query(query)
    where(session_token: query[:session_token]).pluck(:auth_token).first
  end
end
