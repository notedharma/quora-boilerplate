class User < ActiveRecord::Base
	has_secure_password
	validates :email, format: { with:/\S*@\S*\.../, message: "Invalid email"}
	validates :email, uniqueness: true
	validates :password, length: { in: 3..20}
	has_many :questions
	has_many :answers
	
	def self.add_user(name, email, password)
		user = User.new(name: name, email: email, password: password)
		user.save
		return user
	end

	def self.login_user(email, password)
		User.find_by(email: email).try(:authenticate, password)
		
	
	end



end

