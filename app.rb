require_relative './config/init.rb'
# set :run, true


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
		session[:user_id] = user.id
		redirect '/'
	
	else
	 	@login_fail_msg = "Incorrect email or password. Try Again"
		erb :'/login'
		
	end
end

# post '/question' do
# 	if session[:user_id]
# 		#let him post
# 		Question.new(user_id: session[])
# 	else
# 		redirect 'login'
# 	end
# end

get '/users/:id' do
	if current_user.id.to_s == params[:id]
		# @list = Question.list_questions(params[:id])
		@current_list = Question.all.where(user_id: params[:id])
		erb :"users/profile"
	else
		p "Something went wrong /users/:id"
	end
end


get '/logout' do
	log_out
	@logout_msg = "Thanks for visiting. Login again to return"
	erb :'/login'
end

post '/signup' do
	user = User.add_user(params["user"]["name"], params["user"]["email"], params["user"]["password"])
	if user
		@name = user["name"]
		redirect '/login'
	else
		p "Invalid Entry. Try Again."
	end
end



# QUESTIONS-----------------------------------------------------------

get '/users/:id/question' do
	if current_user.id.to_s == params[:id]
		erb :"users/questionnew"
	else
		p "Something went wrong users/:id/question"
	end
end


# redirect to profile buggy on list
post '/questionnew' do
	question = Question.add_question(params["questiontext"], current_user.id)
	if question
		current_user.id.to_s == params[:id]
		redirect "/users/#{current_user.id}"
	else
		p "Invalid Entry. Try Again."
	end
end

get '/users/:id/question/:question_id' do
	if current_user.id.to_s == params[:id]
		@question_id = params[:question_id]
		@current_question = Question.current_question(params[:question_id])
		erb :"questions/question_view"
	else
		p "Something went wrong users/:id/question/:question_id'"
	end
end

post '/users/:id/question/:question_id/edit' do
	edit = params["edit"]
	if edit != "nil"
		Question.edit_current_question(params[:question_id], edit)
		redirect "/users/#{current_user.id}"

	else
		p "Invalid Entry. Try Again."
	end
end

post '/users/:id/question/:question_id/delete' do
	if params["deleteconfirm"]
		Question.delete_current_question(params[:question_id])
		redirect "/users/#{current_user.id}"
	else
		p "Nothing to delete."
	end
end

get '/users/:id/allquestions' do
	if current_user.id.to_s == params[:id]
		@list_all = Question.all
		erb :"questions/question_all"
	else
		p "Something went wrong users/:id/question"
	end
end




# ANSWERS------------------------------------------------------
