class Workspace < ApplicationRecord
  has_many :channels
  has_many :bots
  validates :workspace, presence: true
  validates :installed_by, presence: true
end

