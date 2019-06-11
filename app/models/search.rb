# frozen_string_literal: true

class Search
  include Pagy::Backend

  def initialize(page = 1, include_domains = nil, exclude_domains = nil)
    @page = page
    @include_domains = include_domains
    @exclude_domains = exclude_domains
  end

  def parsed_hosts
    hosts = paginate_hosts
    hash = {}
    hash[:count] = hosts.pluck(:dns_server_id).uniq.count
    hash[:servers] = map_dns_servers(hosts)
    hash[:hostnames] = map_hosts(hosts)

    hash
  rescue Pagy::OverflowError => e
    { error: I18n.t('search.error.wrong_page', last_page: e.pagy.last) }
  end

  private

  def excluded_dns_ids
    return [] if @exclude_domains.blank?

    Hostname.with_domains(@exclude_domains).pluck(:dns_server_id)
  end

  def collection
    ids = excluded_dns_ids

    if @include_domains.blank?
      Hostname.includes(:dns_server).where.not(dns_server_id: ids)
    else
      Hostname.with_domains(@include_domains, ids)
    end
  end

  def paginate_hosts
    _pagy, result = pagy(collection, page: @page, items: 5)

    result
  end

  def map_dns_servers(hosts)
    hosts.map do |host|
      { id: host.dns_server.id, ip: host.dns_server.ip }
    end.uniq
  end

  def map_hosts(hosts)
    hosts.map do |host|
      { domain: host.domain, count: hosts.select { |host2| host2.domain == host.domain }.count }
    end.uniq
  end
end
