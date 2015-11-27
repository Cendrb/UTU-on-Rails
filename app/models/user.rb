require 'digest/sha2'

class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true, email_format: {message: 'není platný email'}
  validates :password, confirmation: true
  validate :password_must_be_present

  has_many :day_teachers
  has_many :details_accesses

  has_many :done_events
  has_many :done_exams
  has_many :done_tasks

  has_many :planned_raking_entries

  has_many :sgroups, through: :class_member

  belongs_to :class_member

  cattr_accessor :current
  attr_accessor :password_confirmation
  attr_reader :password

  def to_s
    return class_member.full_name
  end

  def password=(password)
    @password = password

    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end

  def access_for_level?(required_level)
    if self.access_level
      return self.access_level >= required_level
    else
      self.access_level = User.al_registered
      save!
      return self.access_level >= required_level
    end
  end

  private
  def password_must_be_present
    errors.add(:password, "chybí") unless hashed_password.present?
  end

  private
  def generate_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  # Static
  def User.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + "penis" + salt)
  end

  def User.authenticate(email, password)
    if user = find_by_email(email)
      if user.hashed_password == encrypt_password(password, user.salt)
        user
      end
    end
  end

  # Constants
  def User.al_superuser
    return 10
  end

  def User.al_admin
    return 9
  end

  def User.al_registered
    return 5
  end

  def User.access_levels
    return %w(registrovaný administrátor superuser)
  end

  def User.get_access_level_string(number)
    case number
      when User.al_registered
        return "registrovaný"
      when User.al_admin
        return "administrátor"
      when User.al_superuser
        return "superuser"
    end
  end

  def User.parse_access_level(string)
    case string
      when "registrovaný"
        return User.al_registered
      when "administrátor"
        return User.al_admin
      when "superuser"
        return User.al_superuser
    end
  end

end
