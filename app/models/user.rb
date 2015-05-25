class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :contacts, dependent: :destroy
  has_many :complaints
  has_many :escalation_rules
  has_many :organization_users
  has_many :organizations, through: :organization_users
  devise :database_authenticatable, :registerable,
    :recoverable, :confirmable, :rememberable, :trackable, :validatable,:authentication_keys => [:login]
  before_validation :defaults
  attr_accessor :login
  validates :username, presence: true, length: {maximum: 255}, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9@._]*\z/, message: "may only contain letters, numbers and '@' '.' and '_'." }
 

  def defaults
    self.username ||= self.email
    self.password ||= SecureRandom.hex
  end


  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = lower(:value)", { :value => login }]).first
    else
      where(conditions).first
    end
  end

  protected
   def confirmation_required?
      false
    end
end