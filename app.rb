require_relative './config/init.rb'
set :run, true

get '/' do
  @name = "Human"
  erb :"home"
end

get '/signup' do
	erb :"signup"
end

get '/login' do
	erb :"login"
end

post '/login' do
	user = User.login_user(params["user"]["email"], params["user"]["password"])
	if user
		@name = user
		p @name
	else
		p "Incorrect email or password. Try Again"
	end
end

get '/confirmation' do
	erb :"confirmation"
end

post '/signup' do
	user = User.add_user(params["user"]["name"], params["user"]["email"], params["user"]["password"])
	if user
		@name = user["name"]
		erb :"confirmation"
	else
		p "Invaid Entry. Try Again."
	end
end
