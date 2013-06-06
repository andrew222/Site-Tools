require 'digest/sha1'
class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :email, type: String
  field :name, type: String
  field :hashed_password, type: String
  field :salt, type: String

  validates_length_of :name, :within => 3..40
  validates_length_of :password, :within => 5..40
  # validates_presence_of :name, :email, :password, :password_confirmation, :salt
  validates_presence_of :name, :email, :password, :salt
  validates_uniqueness_of :name, :email
  validates_confirmation_of :password
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"  

  attr_protected :_id, :salt

  attr_accessor :password, :password_confirmation

  has_many :sites, dependent: :delete

 	def password=(pass)
	  @password = pass
	  self.salt = User.random_string(10) if !self.salt?
	  self.hashed_password = User.encrypt(@password, self.salt)
	end

 	def self.authenticate(name, pass)
	  user = where(name: name).first
	  return nil if user.nil?
	  return user.id if User.encrypt(pass, user.salt)==user.hashed_password
	  nil
	end

	protected
	
  def self.random_string(len)
   #generate a random password consisting of strings and digits
   chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
   newpass = ""
   1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
   return newpass
 	end

 	def self.encrypt(pass, salt)
 		Digest::SHA1.hexdigest(pass+salt)
 	end
end
