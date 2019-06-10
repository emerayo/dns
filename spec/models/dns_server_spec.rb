# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DnsServer do
  subject { build(:dns_server) }

  describe 'associations' do
    it { is_expected.to have_many(:hostnames) }
    it { is_expected.to accept_nested_attributes_for(:hostnames) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:ip) }
    it { is_expected.to validate_uniqueness_of(:ip).case_insensitive }

    it do
      allowable_values = %w[208.67.222.222 192.168.2.80]

      is_expected.to allow_values(*allowable_values).for(:ip)
    end

    it do
      invalid_values = [
        'http://www.example.com ',
        'http://www. example  .com',
        'example. com',
        '192.0.2x.0',
        '203.0.1133.255'
      ]

      is_expected.not_to allow_values(*invalid_values).for(:ip)
    end

    describe '#repeated_domains' do
      it 'should add an error for duplicated domains' do
        subject.hostnames.build(domain: '1.com')
        subject.hostnames.build(domain: '1.com')
        error = I18n.t('activerecord.errors.models.dns_server.attributes.hostnames.duplicated_domains')

        expect(subject.valid?).to be_falsey
        expect(subject.errors.messages).to eq(hostnames: [error])
      end
    end
  end
end
