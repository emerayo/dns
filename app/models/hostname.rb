# frozen_string_literal: true

class Hostname < ApplicationRecord
  belongs_to :dns_server

  validates :domain, presence: true,
                     uniqueness: { case_sensitive: false, scope: :dns_server_id }

  scope :with_domains, lambda { |domains, excluded_dns_ids = nil|
    if excluded_dns_ids
      includes(:dns_server).where.not(dns_server_id: excluded_dns_ids).where(domain: domains)
    else
      includes(:dns_server).where(domain: domains)
    end
  }
end
