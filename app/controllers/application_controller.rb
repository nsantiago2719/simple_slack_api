class ApplicationController < ActionController::API
  protected

  def verify_request
    authorization_header = request.headers['x-slack-api-token']
    decryptor = ActiveSupport::MessageEncryptor
      .new(Rails.application.credentials.key)
    begin
      decryptor.decrypt_and_verify(authorization_header)
    rescue
      render json: { message: 'Unauthorized Access' }, status: 401
    end
  end
end
