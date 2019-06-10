# frozen_string_literal: true

require 'rails_helper'

describe V1::DnsServersController do
  describe 'POST #create' do
    context 'with valid params' do
      context 'with only ip' do
        it 'does create a dns_server without hostname' do
          params = { dns_server: { ip: '1.1.1.1' } }

          expect do
            post :create, params: params
          end.to change { DnsServer.count }.by(1)

          expect(Hostname.count).to eq 0
          expect(response.content_type).to eq 'application/json'
          is_expected.to respond_with :ok
          parsed_response = JSON.parse(response.body, symbolize_names: true)
          expect(parsed_response.except(:id, :created_at, :updated_at)).to eq(ip: '1.1.1.1')
        end
      end

      context 'with ip and a hostname' do
        it 'does create a dns_server and a hostname' do
          params = { dns_server: { ip: '1.1.1.1', hostnames_attributes: [{ domain: 'google.com' }] } }

          expect do
            post :create, params: params
          end.to change { DnsServer.count }.by(1)

          expect(Hostname.count).to eq 1
          expect(response.content_type).to eq 'application/json'
          is_expected.to respond_with :ok
          parsed_response = JSON.parse(response.body, symbolize_names: true)
          expect(parsed_response.except(:id, :created_at, :updated_at)).to eq(ip: '1.1.1.1')
        end
      end

      context 'with ip and multiple hostnames' do
        it 'does create a dns_server and multiple hostnames' do
          params = { dns_server: { ip: '1.1.1.1',
                                   hostnames_attributes: [{ domain: 'google.com' }, { domain: 'twitter.com' }] } }

          expect do
            post :create, params: params
          end.to change { DnsServer.count }.by(1)

          expect(Hostname.count).to eq 2
          expect(response.content_type).to eq 'application/json'
          is_expected.to respond_with :ok
          parsed_response = JSON.parse(response.body, symbolize_names: true)
          expect(parsed_response.except(:id, :created_at, :updated_at)).to eq(ip: '1.1.1.1')
        end
      end
    end

    context 'with invalid params' do
      context 'with no ip and multiple hostnames' do
        it 'does not create a dns_server and multiple hostnames' do
          params = { dns_server: { ip: nil,
                                   hostnames_attributes: [{ domain: 'google.com' }, { domain: 'twitter.com' }] } }

          errors = { errors:
            { messages: { ip: [I18n.t('errors.messages.blank'), I18n.t('errors.messages.invalid')] } } }

          expect do
            post :create, params: params
          end.to change { DnsServer.count }.by(0)

          expect(Hostname.count).to eq 0
          expect(response.content_type).to eq 'application/json'
          is_expected.to respond_with :unprocessable_entity
          parsed_response = JSON.parse(response.body, symbolize_names: true)
          expect(parsed_response).to eq errors
        end
      end

      context 'with ip and errors in hostnames' do
        it 'does not create a dns_server and multiple hostnames' do
          params = { dns_server: { ip: '1.1.1.1',
                                   hostnames_attributes: [{ domain: 'google.com' }, { domain: 'google.com' }] } }
          error_msg = I18n.t('activerecord.errors.models.dns_server.attributes.hostnames.duplicated_domains')
          errors = { errors: { messages: { hostnames: [error_msg] } } }

          expect do
            post :create, params: params
          end.to change { DnsServer.count }.by(0)

          expect(Hostname.count).to eq 0
          expect(response.content_type).to eq 'application/json'
          is_expected.to respond_with :unprocessable_entity
          parsed_response = JSON.parse(response.body, symbolize_names: true)
          expect(parsed_response).to eq errors
        end
      end
    end
  end
end
