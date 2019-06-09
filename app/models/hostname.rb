# frozen_string_literal: true

require 'resolv'

class Hostname < ApplicationRecord
  belongs_to :dns_server

  validates :domain, presence: true,
                     uniqueness: { case_sensitive: false, scope: :dns_server_id }
end
