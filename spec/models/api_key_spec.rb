require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  describe 'Validations' do
    describe '#service_name' do
      subject { FactoryBot.build :api_key, :service_name => service_name }

      context 'when < 3 chars' do
        let(:service_name) { 'te' }
        it { is_expected.not_to be_valid }
      end

      context 'when nil' do
        let(:service_name) { nil }
        it { is_expected.not_to be_valid }
      end

      context 'when appropriate' do
        let(:service_name) { 'tutor_chatbot' }
        it { is_expected.to be_valid }
      end
    end

    describe '#token' do
      subject { FactoryBot.create :api_key }
      
      it { expect(subject.token.length).to eq(32) }

      context 'when attempt made to set it' do
        let(:attempt_token_modification) do
          subject.token = 'test_token'
          subject.save
        end

        it { expect { attempt_token_modification }.not_to change { ApiKey.find(subject.id).token } }
      end
    end
  end

  describe '#refresh_token' do
    let!(:api_key) { FactoryBot.create :api_key }
    subject { api_key.refresh_token }

    it { expect { subject }.to change { api_key.token } }
    it { expect(api_key.token.length).to eq(32) }
    it { is_expected.to be_truthy }
    it { expect(ApiKey.find(api_key.id).token).to eq(api_key.token) }
  end
end
