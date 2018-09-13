class CreateVoteList < ActiveRecord::Migration[5.0]
  def change
   create_table :votes do |t|
    	t.integer :vote
    	t.belongs_to :user, index: true
    	t.belongs_to :answer, index: true
    	t.belongs_to :question, index: true
    	t.timestamps
    end
  end
end
