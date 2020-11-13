# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    sequence(:title) { |n| "category#{n}" }

    after(:create) do |category|
      create_list(:idea, 3, category: category)
    end
  end
end
