class OmniauthController < ApplicationController
  before_action :set_workspace!, only: %w(install callback)
  before_action :verify_request, only: %w(index authentication)

  def index; end

  def callback
    res = Slack::Authorization.oauth(workspace_data[:code], @slack_app.redirect_uri)
    if res['ok']
      @workspace.update workspace_token:   res['access_token'],
                        installed_date:    Time.zone.today,
                        team_name:         res['team_name'],
                        team_id:           res['team_id']
      bot = @workspace.bots.find_or_create_by bid: res['bot']['bot_user_id'],
      bot.update token: res['bot']['bot_access_token']
    end
    redirect_to "https://#{@workspace.workspace}.slack.com/messages"
  end

  def install
    redirect_to @slack_app.oauth_authorize_url
  end

  def authentication
    workspace = Workspace.find_by(team_id: data[:team_id])
    channel = workspace.channels.where(name: data[:channel])
  end

  private

  def authentication_data
    parames.permit(:team_id, :channel)
  end

  def workspace_data
    params.permit(:installed_by, :workspace, :code)
  end

  def set_workspace!
    @workspace = Workspace.find_or_create_by(
      installed_by: workspace_data[:installed_by],
      workspace: workspace_data[:workspace]
    )
    @slack_app = Slack::Workspace.new(@workspace.workspace, @workspace.installed_by)
  end
end

