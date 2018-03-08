require 'rails_helper'
include API

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    let!(:user_lecturer_id) { FactoryBot.create :user, :student_id => nil, :lecturer_id => 'C1529373', :email => 'peere@cardiff.ac.uk' }
    let!(:user_student_id) { FactoryBot.create :user, :student_id => 'C1529373', :lecturer_id => nil, :email => 'ceere@cardiff.ac.uk' }
    let!(:user_email) { FactoryBot.create :user, :student_id => 'C1529371', :lecturer_id => nil, :email => 'zeere@cardiff.ac.uk' }
    let!(:request) { get users_path, :params => query_params, :headers => default_headers }

    subject { JSON.parse(response.body) }

    context 'when searching by lecturer_id' do
      let(:query_params) { { :lecturer_id => lecturer_id } }

      context 'when lecturer exists' do
        let(:lecturer_id) { user_lecturer_id.lecturer_id }
        it { expect(response).to have_http_status(:ok) }
        it { is_expected.to include(attributes_of(user_lecturer_id)) }
      end

      context 'when lecturer does not exist' do
        let(:lecturer_id) { user_lecturer_id.lecturer_id + '1' }
        it { expect(response).to have_http_status(:not_found) }
        it { is_expected.to include('error' => 'could not find the user with the parameters provided') }
      end
    end

    context 'when searching by student_id' do
      let(:query_params) { { :student_id => student_id } }

      context 'when student exists' do
        let(:student_id) { user_student_id.student_id }
        it { expect(response).to have_http_status(:ok) }
        it { is_expected.to include(attributes_of(user_student_id)) }
      end

      context 'when student does not exist' do
        let(:student_id) { user_student_id.student_id + '1' }
        it { expect(response).to have_http_status(:not_found) }
        it { is_expected.to include('error' => 'could not find the user with the parameters provided') }
      end
    end

    context 'when searching by email' do
      let(:query_params) { { :email => email } }

      context 'when exists' do
        let(:email) { user_email.email }
        it { expect(response).to have_http_status(:ok) }
        it { is_expected.to include(attributes_of(user_email)) }
      end

      context 'when does not exist' do
        let(:email) { user_email.email + '1' }
        it { expect(response).to have_http_status(:not_found) }
        it { is_expected.to include('error' => 'could not find the user with the parameters provided') }
      end
    end

    context 'when searching by jwt' do
      let(:query_params) { { :jwt => jwt } }

      context 'when exists' do
        let(:jwt) { jwt_token(attributes_of(user_email)) }
        it { expect(response).to have_http_status(:ok) }
        it { is_expected.to include(attributes_of(user_email)) }
      end

      context 'when does not exist' do
        let(:jwt) { jwt_token(attributes_of(user_email).merge(:id => user_email.id + 1)) }
        it { expect(response).to have_http_status(:not_found) }
        it { is_expected.to include('error' => 'could not find the user with the parameters provided') }
      end
    end
  end

  describe 'GET /users/:id' do
    let(:user) { FactoryBot.create :user }
    let!(:request) { get user_path(:id => user_id), :headers => default_headers }
    subject { JSON.parse(response.body) }
    
    context 'when user exists' do
      let(:user_id) { user.id }
      let(:user_attrs) { attributes_of(user).merge('url' => "http://#{@request.host}/api/users/#{user.id}.json") }
      it { expect(response).to have_http_status(:ok) }
      it { is_expected.to include(user_attrs) }
    end

    context 'when user doesn\'t exist' do
      let(:user_id) { user.id + 1 }
      it { expect(response).to have_http_status(:not_found) }
    end
  end
end
