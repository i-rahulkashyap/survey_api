class SessionsController < ApplicationController
  # Skip JWT authentication for the OmniAuth callback
  before_action :authorize_request, only: [:logout]

  skip_before_action :authenticate_request, only: [:google_auth]

  def google_auth
   
    auth = request.env['omniauth.auth']

    # Find or create the user based on their email
    user = User.find_or_create_by(email: auth.info.email) do |u|
      u.name  = auth.info.email
      # u.image = auth.info.image
    end


    token = JsonWebToken.encode({ user_id: user.id })

    redirect_to "http://localhost:4000/?token=#{token}"
    # For an API, return the token (and optionally user info) as JSON.
    # render json: { message: "Login successful", token: token, user: user }


    # if user.persisted?
    #   token = JsonWebToken.encode({ user_id: user.id })
    #   redirect_to "http://localhost:4000/?token=#{token}"
    # else
    #   Rails.logger.error "User creation failed: #{user.errors.full_messages.join(', ')}"
    #   redirect_to 'http://localhost:4000/login', alert: 'Authentication failed'
    # end

  end

  def logout
    BlacklistedToken.create(jti: @decoded_token[:jti])
    render json: { message: "Logged out successfully" }, status: :ok
  end

  private

  def authorize_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    @decoded_token = JsonWebToken.decode(token)

    render json: { error: 'Unauthorized' }, status: :unauthorized unless @decoded_token
  end
end
