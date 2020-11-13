class Idea < ApplicationRecord
  belongs_to :category
  validates :body, presence: true, uniqueness: true
end
