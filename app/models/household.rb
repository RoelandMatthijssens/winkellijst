class Household < ActiveRecord::Base
  attr_accessible :city, :housenumber, :housenumber_addition, :name, :password, :password_protected, :phonenumber, :postal_code, :street

	has_many :shopping_lists, dependent: :destroy
	has_and_belongs_to_many :users

	validates_presence_of :name

	def verify_password pass
		if password_protected
			return self.class.encrypt(pass) == password
		else
			return true
		end
	end

	def self.encrypt pass
		return Digest::MD5.hexdigest pass if pass else ""
	end

	def encrypt_password
		write_attribute(:password, self.class.encrypt(password))
	end
end
