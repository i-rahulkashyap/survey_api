class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base || ENV['SECRET_KEY_BASE']

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    payload[:jti] = SecureRandom.uuid  # Add JTI (unique token identifier)
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    body, header = JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')
    return nil if BlacklistedToken.exists?(jti: body['jti']) # Check if token is blacklisted
    HashWithIndifferentAccess.new(body)
  rescue
    nil
  end
end
