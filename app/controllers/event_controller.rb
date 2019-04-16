class EventController < ApplicationController
  def members_joined; end

  def challange
    body = {
      'challange'    =>     data['challange']
    }

    render json: { body }
  end

  private

  def challange_data
    params.permit(:token, :challange, :type)
  end
end
