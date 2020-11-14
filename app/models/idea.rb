# frozen_string_literal: true

class Idea < ApplicationRecord
  belongs_to :category
  validates :body, presence: true
end
