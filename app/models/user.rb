require 'digest/sha2'

class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true
  validate :password_must_be_present

  attr_accessor :password_confirmation
  attr_reader :password
  
  def password=(password)
    @passwor = password
    
    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end

  private
  def password_must_be_present
    errors.add(:password, "Chybí heslo") unless hashed_password.present?
  end
  
  private
  def generate_salt
    self.salt = slef.object_id.to_s + rand.to_s
  end
  
  # Static
  def User.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + "penis" + salt)
  end
  
  def User.authenticate(email, password)
    if user = find_by_name(name)
      if user.hashed_password == encrypt_password(password, user.salt)
    end
  end
end
