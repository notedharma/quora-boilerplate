class User < ActiveRecord::Base
	validates :email, format: { with:/\S*@\S*\.../, message: "Invalid email"}
	validates :email, uniqueness: true
	validates :password, length: { in: 3..20}

	def self.add_user(name, email, password)
		user = User.new(name: name, email: email, password: password)
		user.save
		return user
	end

	def self.login_user(email, password)
		t = User.find_by email: email
		if t
			if t.password == password
				return t.name
			else
				return false
			end
		else
			return false
		end
	end



end

