class EventController < ApplicationController
  def members_joined; end

  def challenge
    challenge_token = challenge_data['body']['challenge']
    render json: { challenge: challenge_token }
  end

  private

  def challenge_data
    params.require(:body)
      .permit(:token, :challenge, :type)
  end
end
