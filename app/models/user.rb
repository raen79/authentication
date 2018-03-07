require 'mail'

class User < ApplicationRecord
  before_validation :upcase
  has_secure_password

  validates :email, :presence => true, :uniqueness => true, 'valid_email_2/email' => true
  validates :password, :length => { :minimum => 8 }
  validate :id_cannot_be_nil

  private
    def upcase
      [student_id, lecturer_id].each do |id|
        id.upcase! unless id.blank?
      end
    end

    def id_cannot_be_nil
      if student_id.blank? && lecturer_id.blank?
        errors.add(:student_id, 'cannot be nil if lecturer_id is also nil')
        errors.add(:lecturer_id, 'cannot be nil if student_id is also nil')
      end
    end
end
