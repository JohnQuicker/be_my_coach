class Job < ApplicationRecord
  validates :title, presence: true
  validates :hope_dead_line, presence: true
  validates :commit_wage, presence: true
  validates :hope_dead_line, numericality: { greater_than: 0}
  validates :commit_wage, numericality: { greater_than: 0}

end
