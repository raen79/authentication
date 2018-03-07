require 'rails_helper'
include API

RSpec.describe 'Authentication', type: :request do
  describe 'POST /authentication/login' do
    let!(:user) { FactoryBot.create :user, :email => 'peere@cardiff.ac.uk', :password => '12345678', :password_confirmation => '12345678' }
    let!(:request) { post login_path, :params => { :login => login_params }, :headers => default_headers }
    subject { JSON.parse(response.body) }
    
    context 'when no parameters provided' do
      let(:login_params) { }
      it { is_expected.to eq({'error' => 'param is missing or the value is empty: login'}) }
      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

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
      let(:user_attrs) { { :id => user.id, :student_id => user.student_id, :lecturer_id => user.lecturer_id, :email => user.email } }
      let(:jwt) { jwt_token(user_attrs) }
      it { is_expected.to include('jwt' => jwt) }
      it { expect(response).to have_http_status(:ok) }
    end
  end
end
