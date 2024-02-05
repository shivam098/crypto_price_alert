class ApplicationController < ActionController::API
  before_action :authenticate_user!

  def create
    # Use current_user to get the authenticated user
    user = current_user
    # Rest of your code...
  end

  private

  def authenticate_user!

    token = request.headers['Authorization']&.split(' ')&.last
    puts "Received token: #{token}"

    return render json: { error: 'Unauthorized' }, status: :unauthorized unless token

    decoded_token = JWT.decode(token, 'your_secret_key', true, algorithm: 'HS256')
    @current_user = User.find_by(id: decoded_token[0]['user_id'])

    return render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
  rescue JWT::DecodeError
    render json: { error: 'Invalid token' }, status: :unauthorized
  end
end
