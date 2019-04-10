FactoryBot.define do
  factory :default_workspace, class: Workspace do
    workspace          { 'CentralizedBilling' }
    installed_by       { 'nsantiago' }
    installed_date     { Date.now }
    token              { 'qwertyuio' }
  end

  factory :invalid_workspace, class: Workspace do
    workspace       { '' }
    installed_by    { '' }
  end
end

