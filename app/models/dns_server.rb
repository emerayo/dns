# frozen_string_literal: true

require 'resolv'

class DnsServer < ApplicationRecord
  has_many :hostnames

  accepts_nested_attributes_for :hostnames, reject_if: :all_blank

  validates :ip, presence: true,
                 uniqueness: { case_sensitive: false },
                 format: { with: ::Resolv::IPv4::Regex }
  validate :repeated_domains

  private

  def repeated_domains
    return if hostnames.map(&:domain).uniq.size == hostnames.size

    errors.add(:hostnames, :duplicated_domains)
  end
end
