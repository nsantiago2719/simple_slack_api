class Workspace < ApplicationRecord
  has_many :channels
  validates :workspace, presence: true
  validates :installed_by, presence: true
end

