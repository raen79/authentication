class User < ApplicationRecord
  @private_key = OpenSSL::PKey::RSA.new(ENV['RSA_PRIVATE_KEY'].gsub('\n', "\n"))
  @public_key = OpenSSL::PKey::RSA.new(ENV['RSA_PRIVATE_KEY'].gsub('\n', "\n"))

  before_validation :upcase
  has_secure_password

  validates :email, :presence => true, :uniqueness => true, 'valid_email_2/email' => true
  validates :password, :length => { :minimum => 8 }
  validate :id_cannot_be_nil

  def self.login(email:, password:)
    user = User.find_by(:email => email)

    if !user.blank? && user.authenticate(password)
      payload = { :id => user.id, :student_id => user.student_id, :lecturer_id => user.lecturer_id, :email => user.email }
      JWT.encode payload, @private_key, 'RS512'
    else
      nil
    end
  end

  def self.find_by_jwt(jwt)
    jwt = JWT.decode jwt, @public_key, true, { :algorithm => 'RS512' }
    User.find_by(:id => jwt[0]['id'])
  end

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
