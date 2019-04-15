class ApplicationController < ActionController::API

  protected

  def verify_request
    authorization_header = request.headers['x-slack-api-token']

    decryptor = ActiveSupport::MessageEncryptor
      .new(Rails.application.credentials.key)

    begin
      decryptor.decrypt_and_verify(authorization_header)
      render json: { message: 'Success' }, status: 200
    rescue StandardError => e
      render json: { message: 'Unauthorized Access' }, status: 401
    end
  end
end
