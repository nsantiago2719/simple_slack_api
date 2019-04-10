require 'rails_helper'

RSpec.describe Workspace, type: :model do

  it 'should fail empty workspace and installed_by fields' do
    expect(Workspace.new(attributes_for(:invalid_workspace))).not_to be_valid
  end
end
