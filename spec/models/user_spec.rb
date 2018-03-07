require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    describe '#email' do
      subject { FactoryBot.build :user, :email => email }

      context 'when not unique' do
        let!(:non_unique_user) { FactoryBot.create :user, :email => email }
        let(:email) { 'peere@cardiff.ac.uk' }
        it { is_expected.not_to be_valid }
      end

      context 'when not present' do
        let(:email) { nil }
        it { is_expected.not_to be_valid }
      end

      context 'when not email' do
        let(:email) { 'blabl.com@hello' }
        it { is_expected.not_to be_valid }
      end
      
      context 'when valid' do
        let(:email) { 'peere@cardiff.ac.uk' }
        it { is_expected.to be_valid }
      end
    end

    describe '#password' do
      subject { FactoryBot.build :user, :password => password, :password_confirmation => password_confirmation }

      context 'when < 8 chars' do
        let(:password) { 'test' }
        let(:password_confirmation) { 'test' }
        it { is_expected.not_to be_valid }
      end

      context 'when doesn\'t match #password_confirmation' do
        let(:password) { 'a_correct_password' }
        let(:password_confirmation) { 'an_incorrect_password' }
        it { is_expected.to_not be_valid }
      end

      context 'when not present' do
        let(:password) { nil }
        let(:password_confirmation) { nil }
        it { is_expected.not_to be_valid }
      end

      context 'when valid' do
        let(:password) { 'xyzabc!!##' }
        let(:password_confirmation) { 'xyzabc!!##' }
        it { is_expected.to be_valid }
      end
    end

    describe '#lecturer_id' do
      it_behaves_like 'id', :user, 'lecturer'
    end

    describe '#student_id' do
      it_behaves_like 'id', :user, 'student'
    end

    describe '(#lecturer_id, #student_id)' do
      subject { FactoryBot.build :user, :lecturer_id => lecturer_id, :student_id => student_id}

      context 'when both are nil' do
        let(:lecturer_id) { nil }
        let(:student_id) { nil }
        it { is_expected.not_to be_valid }
      end
    end

    context 'when valid' do
      subject { FactoryBot.create :user }
      it { expect { subject }.to change { User.count }.by(1) }
    end

    context 'when invalid' do
      subject { FactoryBot.create :user, :email => '@test.com' }
      it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid).and change { User.count }.by(0) }
    end
  end
end
