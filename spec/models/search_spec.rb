# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Search do
  describe '#parsed_hosts' do
    it 'should return blank when passing an excluded domain that matches a hostname' do
      dns = create(:dns_server)
      create(:hostname, dns_server: dns, domain: 'twitter.com')
      create(:hostname, dns_server: dns, domain: 'google.com')
      expected_response = { count: 0, hostnames: [], servers: [] }

      search = described_class.new(1, 'twitter.com', 'google.com')
      response = search.parsed_hosts

      expect(response).to eq expected_response
    end

    it 'should return blank when passing an excluded domain that matches a hostname' do
      dns = create(:dns_server)
      create(:hostname, dns_server: dns, domain: 'twitter.com')
      create(:hostname, dns_server: dns, domain: 'google.com')
      expected_response = { count: 0, hostnames: [], servers: [] }

      search = described_class.new(1, nil, 'google.com')
      response = search.parsed_hosts

      expect(response).to eq expected_response
    end

    it 'should return a list of hostnames when passing domains that matches any hostnames' do
      dns = create(:dns_server)
      host1 = create(:hostname, dns_server: dns, domain: 'twitter.com')
      host2 = create(:hostname, dns_server: dns, domain: 'google.com')
      expected_response = {
        count: 1,
        hostnames: [{ count: 1, domain: host1.domain }, { count: 1, domain: host2.domain }],
        servers: [{ id: dns.id, ip: dns.ip }]
      }

      search = described_class.new(1, ['twitter.com', 'google.com'])
      response = search.parsed_hosts

      expect(response).to eq expected_response
    end

    it 'should return only hostnames with included domains' do
      dns = create(:dns_server)
      host = create(:hostname, dns_server: dns, domain: 'twitter.com')
      create(:hostname, dns_server: dns, domain: 'google.com')
      expected_response = {
        count: 1,
        hostnames: [{ count: 1, domain: host.domain }],
        servers: [{ id: dns.id, ip: dns.ip }]
      }

      search = described_class.new(1, host.domain)
      response = search.parsed_hosts

      expect(response).to eq expected_response
    end

    it 'should return correctly count how many times an host is found and its dns severs' do
      dns1 = create(:dns_server)
      dns2 = create(:dns_server)
      host1 = create(:hostname, dns_server: dns1, domain: 'twitter.com')
      create(:hostname, dns_server: dns2, domain: 'twitter.com')
      create(:hostname, dns_server: dns2, domain: 'google.com')
      expected_response = {
        count: 2,
        hostnames: [{ count: 2, domain: host1.domain }],
        servers: [{ id: dns1.id, ip: dns1.ip }, { id: dns2.id, ip: dns2.ip }]
      }

      search = described_class.new(1, host1.domain)
      response = search.parsed_hosts

      expect(response).to eq expected_response
    end

    it 'should return all hostnames when passing no args' do
      dns = create(:dns_server)
      host1 = create(:hostname, dns_server: dns, domain: 'twitter.com')
      host2 = create(:hostname, dns_server: dns, domain: 'google.com')
      expected_response = {
        count: 1,
        hostnames: [{ count: 1, domain: host1.domain }, { count: 1, domain: host2.domain }],
        servers: [{ id: dns.id, ip: dns.ip }]
      }

      search = described_class.new(1)
      response = search.parsed_hosts

      expect(response).to eq expected_response
    end

    it 'should rescue and return a error message when passing a wrong page' do
      dns = create(:dns_server)
      create(:hostname, dns_server: dns, domain: 'twitter.com')
      create(:hostname, dns_server: dns, domain: 'google.com')

      search = described_class.new(10)
      response = search.parsed_hosts

      expect(response).to eq(error: I18n.t('search.error.wrong_page', last_page: 1))
    end
  end
end
