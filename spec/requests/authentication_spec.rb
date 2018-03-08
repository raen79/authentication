require 'rails_helper'
include API

RSpec.describe 'Authentication', type: :request do
  describe 'POST /authentication/login' do
    let!(:user) { FactoryBot.create :user, :email => 'peere@cardiff.ac.uk', :password => '12345678', :password_confirmation => '12345678' }
    let!(:request) { post login_path, :params => { :login => login_params }, :headers => default_headers }
    subject { JSON.parse(response.body) }

    context 'when email parameter not correct' do
      let(:login_params) { { :email => 'test@test.com', :password => user.password } }
      it { is_expected.to eq({'error' => 'email was not found or password incorrect'}) }
      it { expect(response).to have_http_status(:not_found) }
    end

    context 'when password parameter not correct' do
      let(:login_params) { { :email => user.email, :password => '87654321' } }
      it { is_expected.to eq({'error' => 'email was not found or password incorrect'}) }
      it { expect(response).to have_http_status(:not_found) }
    end

    context 'when valid params' do
      let(:login_params) { { :email => user.email, :password => user.password } }
      let(:user_attrs) { attributes_of(user) }
      let(:payload) { token_payload(subject['jwt']) }
      it { expect(payload).to include(user_attrs) }
      it { expect(response).to have_http_status(:ok) }
    end
  end

  describe 'POST /authentication/register' do
    let(:user) { FactoryBot.attributes_for :user, :email => email }
    let(:request) { post register_path, :params => { :user => user }, :headers => default_headers }
    subject { JSON.parse(response.body) }

    context 'when validations fail' do
      let(:email) { '.com/email@wrong' }
      it { request; expect(response).to have_http_status(:unprocessable_entity) }
      it { request; is_expected.to include('errors') }
      it { expect { request }.to change { User.count }.by(0) }
    end

    context 'when validations pass' do
      let(:email) { 'peere@cardiff.ac.uk' }
      let(:user_params) { attributes_of(user) }
      it { request; expect(response).to have_http_status(:created) }
      it { request; is_expected.to include user.except(:password, :password_confirmation).with_indifferent_access }
      it { request; is_expected.to include('jwt') }
      it { expect { request }.to change { User.count }.by(1) }
    end
  end
end
