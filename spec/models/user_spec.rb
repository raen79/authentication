require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    describe '#email' do
      context 'when not unique' do
      end

      context 'when not present' do
      end

      context 'when not email' do
      end
      
      context 'when valid' do
      end
    end

    describe '#password' do
      context 'when < 8 chars' do
      end

      context 'when doesn\'t match #password_confirmation' do
      end

      context 'when not present' do
      end

      context 'when valid' do
      end
    end

    describe '#lecturer_id' do
      it_behaves_like 'id', :user, 'lecturer'
    end

    describe '#student_id' do
      it_behaves_like 'id', :user, 'student'
    end

    describe '(#lecturer_id, #student_id)' do
      context 'when both are nil' do
      end
    end

    context 'when valid' do
    end

    context 'when invalid' do
    end
  end
end
