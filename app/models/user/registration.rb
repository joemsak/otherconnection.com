class User::Registration < ApplicationRecord
  has_secure_token :session_token, length: 36
  has_secure_token :auth_token, length: 36

  def self.auth_token(query)
    find_auth_token_by_secure_query(query)
  end

  private
  def self.find_auth_token_by_secure_query(query)
    where(session_token: query[:session_token]).pluck(:auth_token).first
  end
end
