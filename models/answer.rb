class Answer < ActiveRecord::Base
	belongs_to :user
	belongs_to :question
	has_many :votes


	def self.add_answer(answer_text, user_id, question_id)
		answer = Answer.new(answer: answer_text, user_id: user_id, question_id: question_id)
		answer.save
		p answer
	end


	def self.current_answer(answer_id)
		q =Answer.find_by_id(answer_id.to_i)
		q.answer
	end

	def self.delete_current_answer(answer_id)
		q = Answer.all.find_by_id(answer_id)
		q.delete
	end

	def self.edit_current_answer(answer_id, answer_text)
		q = Answer.all.find_by_id(answer_id)
		q.update(answer: answer_text)
	end

	def self.all_answer_to_question(answer_id, answer_text)
		q = Answer.all.find_by_id(question_id)
		q.update(answer: answer_text)
	end


end

