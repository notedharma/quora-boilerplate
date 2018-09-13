class Vote < ActiveRecord::Base
	belongs_to :answer
	belongs_to :question
	belongs_to :user


	def self.add_vote(, user_id, question_id)
		answer = Answer.new(answer: answer_text, user_id: user_id, question_id: question_id)
		answer.save
		p answer
	end


end

