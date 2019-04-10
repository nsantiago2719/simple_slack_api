class Workspace < ApplicationRecord
  validates :workspace, presence: true
  validates :installed_by, presence: true
end

