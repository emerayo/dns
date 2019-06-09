# frozen_string_literal: true

require 'resolv'

class DnsServer < ApplicationRecord
  validates :ip, presence: true,
                 uniqueness: { case_sensitive: false },
                 format: { with: ::Resolv::IPv4::Regex }
end
