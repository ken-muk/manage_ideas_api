# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    sequence(:title) { |n| "category#{n}" }
  end
end
