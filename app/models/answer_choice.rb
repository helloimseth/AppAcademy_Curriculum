class AnswerChoice  < ActiveRecord::Base
  validates :answer_text, :question_id, presence: true

end
