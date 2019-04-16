class EventController < ApplicationController
  def members_joined; end

  def challange
    render json: { challange: challange_data['challange'] }
  end

  private

  def challange_data
    params.permit(:token, :challange, :type)
  end
end
