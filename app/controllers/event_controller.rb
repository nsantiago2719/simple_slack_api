class EventController < ApplicationController
  def challenge
    url_challenge
    channel = register_workspace_channel
    bot_token = channel.workspace.bots.first.token
    res = Slack::Api.greetings_message(channel.slack_id,
                                 bot_token,
                                 "Thank you for adding me!!"
                                )
    message = JSON.parse(res.body)
    render json: { body: message }, status: res.status
  end

  def url_challenge
    if challenge_data['challange'].present?
      challenge_token = challenge_data['challenge']
      return render json: { challenge: challenge_token }
    end
  end

  def register_workspace_channel
    workspace = Workspace.find_by team_id: members_joined_data['team']
    bot_token = workspace.bots.first.token
    channel_info = Slack::Api.channel_data(bot_token,
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

