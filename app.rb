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

get '/users/:id' do
	if current_user.id.to_s == params[:id]
		@current_question_list = Question.all.order(:updated_at).reverse_order.where(user_id: params[:id])
		@current_answer_list = Answer.all.order(:updated_at).reverse_order.where(user_id: params[:id])
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



# QUESTIONS ----------- QUESTIONS -----------QUESTIONS-----------QUESTIONS-----------QUESTIONS

get '/users/:id/question' do
	if current_user.id.to_s == params[:id]
		erb :"users/questionnew"
	else
		p "Something went wrong users/:id/question"
	end
end


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
		@all_answers = Answer.all.where(question_id: params[:question_id])
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
		@list_all = Question.includes(:answers).all.order(:updated_at).reverse_order
		erb :"questions/question_all"
	else
		p "Something went wrong users/:id/question"
	end
end




# ANSWERS---------------ANSWERS---------------ANSWERS---------------ANSWERS-----------

get '/users/:id/question/:question_id/answer' do
	if current_user.id.to_s == params[:id]
		@question_id = params[:question_id]
		@current_question = Question.current_question(params[:question_id])
		
		@all_answers = Answer.left_outer_joins(:votes).group("answers.id").order('count(votes.id) desc').where(question_id: params[:question_id])
		# @all_answers = Answer.all.where(question_id: params[:question_id])
		
		erb :"answers/question_to_answer"
	else
		p "Something went wrong users/:id/answernew"
	end
end

post '/users/:id/question/:question_id/answer/new' do
	answer = Answer.add_answer(params["answertext"], current_user.id, params[:question_id])
	if answer
		current_user.id.to_s == params[:id]
		redirect "/users/#{current_user.id}"
	else
		p "Invalid Entry. Try Again."
	end
end


get '/users/:id/question/:question_id/answer/:answer_id' do
	if current_user.id.to_s == params[:id]
		@question_id = params[:question_id]
		@answer_id = params[:answer_id]
		@current_question = Question.current_question(params[:question_id])
		@current_answer = Answer.current_answer(params[:answer_id])
		erb :"answers/answer_view"
	else
		p "Something went wrong /answer/:answer_id'"
	end
end

post '/users/:id/answer/:answer_id/edit' do
	edit = params["edit"]
	if edit != "nil"
		Answer.edit_current_answer(params[:answer_id], edit)
		redirect "/users/#{current_user.id}"

	else
		p "Invalid Entry. Try Again."
	end
end

post '/users/:id/answer/:answer_id/delete' do
	if params["deleteconfirm"]
		Answer.delete_current_answer(params[:answer_id])
		redirect "/users/#{current_user.id}"
	else
		p "Nothing to delete."
	end
end

# VOTE---------------VOTE---------------VOTE---------------VOTE---------------VOTE---------------

# post'/question/:question_id/answer/:answer_id/vote' do
# 	if logged_in?
# 		Vote.add_answer_vote(params[:answer_id], current_user.id)
# 		redirect back
# 		# redirect "/users/#{current_user.id}/question/#{params[:question_id]}/answer"
# 	else
# 		p "Invalid Entry. Try Again."
# 	end
# end

post'/question/:question_id/answer/:answer_id/vote/:index' do
	if logged_in?
		Vote.add_answer_vote(params[:answer_id], current_user.id)
		count = Answer.includes(:votes).all.find_by_id(params[:answer_id]).votes.count
		{votecount: count, index:params[:index]}.to_json

	else
		p "Invalid Entry. Try Again."
	end
end