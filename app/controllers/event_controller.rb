class EventController < ApplicationController
  def challenge
    url_challenge
    channel = register_workspace_channel
    Slack::Api.greetings_message(channel.slack_id,
                                 channel.workspace.workspace_token,
                                 "Thank you for adding me!!"
                                )
    render json: { status: ok }, status: 200
  end

  def url_challenge
    if challenge_data['challange'].present?
      challenge_token = challenge_data['challenge']
      return render json: { challenge: challenge_token }
    end
  end

  def register_workspace_channel
    workspace = Workspace.find_by team_id: members_joined_data['team']
    channel_info = Slack::Api
      .channel_data(workspace.workspace_token,
                    members_joined_data['channel']
                   )
    return workspace
      .channels
      .find_or_create_by(slack_id: channel_info['channel']['id'],
                         name: channel_info['channel']['name']
                        )
  end

  private

  def challenge_data
    params.permit(:token, :challenge, :type)
  end

  def members_joined_data
    params.permit(:team, :channel)
  end
end

