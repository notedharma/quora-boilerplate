class Answer < ActiveRecord::Base
	belongs_to :user
	belongs_to :question


	def self.add_answer(answer_text, user_id)
		answer = Question.new(question: question_text, user_id: user_id)
		answer.save
	end

	# def self.list_questions(user_id)
	# 	list = Hash.new
		
	# 	q = Question.where(user_id: user_id)

	# 	q.each_with_index {|x , index|
	# 		list[index+1] = "#{index+1}. #{x.question}"
	# 		list["#{index+1}id"] = x.id
	# 	}
	# 	return list
	# end

	# def self.current_question(question_id)
	# 	q =Question.find_by_id(question_id.to_i)
	# 	q.question
	# end

	# def self.delete_current_question(question_id)
	# 	q = Question.all.find_by_id(question_id)
	# 	q.delete
	# end

	# def self.edit_current_question(question_id, question_text)
	# 	q = Question.all.find_by_id(question_id)
	# 	q.update(question: question_text)
	# end



end

