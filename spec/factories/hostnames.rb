# frozen_string_literal: true

FactoryBot.define do
  factory :hostname do
    sequence(:domain) { |n| "#{n}.com" }
    association :dns_server, strategy: :build
  end
end
