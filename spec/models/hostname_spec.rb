# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hostname do
  subject { build(:hostname) }

  describe 'associations' do
    it { is_expected.to belong_to(:dns_server) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:domain) }
    it { is_expected.to validate_uniqueness_of(:domain).case_insensitive.scoped_to(:dns_server_id) }
  end
end
