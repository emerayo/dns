# frozen_string_literal: true

require 'resolv'

class DnsServer < ApplicationRecord
  has_many :hostnames

  validates :ip, presence: true,
                 uniqueness: { case_sensitive: false },
                 format: { with: ::Resolv::IPv4::Regex }
end
