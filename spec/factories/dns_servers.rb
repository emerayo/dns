# frozen_string_literal: true

FactoryBot.define do
  factory :dns_server do
    sequence(:ip) { |n| "1.1.1.#{n}" }
  end
end
