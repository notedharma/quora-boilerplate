class Question < ActiveRecord::Base
	belongs_to :user
	has_many :answers
	has_many :votes

# example of activerecord calls over many tables
	# a = Question.find(1)
	# a.answers.first
	# answers = Answer.find(10)
	# answers.question.question


	def self.add_question(question_text, user_id)
		question = Question.new(question: question_text, user_id: user_id)
		question.save
		return question
	end

	def self.list_questions(user_id)
		list = Hash.new
		
		q = Question.where(user_id: user_id)

		q.each_with_index {|x , index|
			list[index+1] = "#{index+1}. #{x.question}"
			list["#{index+1}id"] = x.id
		}
		return list
	end

	def self.current_question(question_id)
		q =Question.find_by_id(question_id.to_i)
		q.question
	end

	def self.delete_current_question(question_id)
		q = Question.all.find_by_id(question_id)
		q.delete
	end

	def self.edit_current_question(question_id, question_text)
		q = Question.all.find_by_id(question_id)
		q.update(question: question_text)
	end



end

