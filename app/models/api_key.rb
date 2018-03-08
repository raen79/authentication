class ApiKey < ApplicationRecord
  attr_readonly :token
  before_create :gen_token

  validates :service_name, :length => { :minimum => 3 }, :presence => true

  def refresh_token
    gen_token
    save
  end

  private
    def gen_token
      self.token = SecureRandom.hex
    end
end
