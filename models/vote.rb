class Vote < ActiveRecord::Base
	belongs_to :answer
	belongs_to :question
	belongs_to :user


	def self.add_answer_vote(answer_id, user_id)
		vote = Vote.new(answer_id: answer_id, user_id: user_id,)
		vote.save

	end

	# def self.get_vote_count(answer_id)
	# 	q = Answers.all.find_by_id(answer_id).votes.count
	# 	return q
	# end


end

