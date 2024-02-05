class User < ApplicationRecord
  has_secure_password
  def generate_jwt
    payload = { user_id: id }
    JWT.encode(payload, Rails.application.secret_key_base, 'HS256')
  end
end
