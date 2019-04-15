class OmniauthController < ApplicationController

  before_action :set_workspace!, only: %w(install callback)
  before_action :verify_request, only: %w(index)

  def index; end

  def callback
    res = Slack::Authorization.oauth(workspace_data[:code], @slack_app.redirect_uri)
    if res['ok']
      @workspace.update workspace_token:   res['access_token'],
                        installed_date:    Date.today,
                        team_name:         res['team_name'],
                        webhook_url:       res['incoming_webhook']['url'],
                        channel:           res['incoming_webhook']['channel']

    end
    redirect_to "https://#{@workspace.workspace}.slack.com/messages"
  end

  def install
    redirect_to @slack_app.oauth_authorize_url
  end

  private

  def workspace_data
    params.permit(:installed_by, :workspace, :code)
  end

  def set_workspace!
    @workspace = Workspace.find_or_create_by(
      installed_by: workspace_data[:installed_by],
      workspace: workspace_data[:workspace])
    @slack_app = Slack::Workspace.new(@workspace.workspace, @workspace.installed_by)
  end
end

