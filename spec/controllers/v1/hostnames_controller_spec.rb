# frozen_string_literal: true

require 'rails_helper'

describe V1::HostnamesController do
  describe 'GET #search' do
    it 'does create a dns_server without hostname' do
      params = { page: 1 }
      expected_response = { count: 0, hostnames: [], servers: [] }

      get :search, params: params

      expect(response.content_type).to eq 'application/json'
      is_expected.to respond_with :ok
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response).to eq expected_response
    end

    it 'should return a error message when passing a wrong page' do
      params = { page: 10 }
      expected_response = { error: I18n.t('search.error.wrong_page', last_page: 1) }

      get :search, params: params

      expect(response.content_type).to eq 'application/json'
      is_expected.to respond_with :ok
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response).to eq expected_response
    end

    it 'should return blank hash when passing an excluded domain that matches a hostname' do
      dns = create(:dns_server)
      create(:hostname, dns_server: dns, domain: 'twitter.com')
      create(:hostname, dns_server: dns, domain: 'google.com')
      expected_response = { count: 0, hostnames: [], servers: [] }

      params = { excluded_domains: 'google.com' }
      get :search, params: params

      expect(response.content_type).to eq 'application/json'
      is_expected.to respond_with :ok
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response).to eq expected_response
    end

    it 'should return correct hostname when passing an included domain that matches a hostname' do
      dns = create(:dns_server)
      host = create(:hostname, dns_server: dns, domain: 'twitter.com')
      create(:hostname, dns_server: dns, domain: 'google.com')
      expected_response = {
        count: 1,
        hostnames: [{ count: 1, domain: host.domain }],
        servers: [{ id: dns.id, ip: dns.ip }]
      }

      params = { included_domains: 'twitter.com' }
      get :search, params: params

      expect(response.content_type).to eq 'application/json'
      is_expected.to respond_with :ok
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response).to eq expected_response
    end
  end
end
