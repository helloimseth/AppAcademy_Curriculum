class Response < ActiveRecord::Base
  validates :user_id, :answer_id, presence: true
  validate :respondent_has_not_already_answered_question

  belongs_to :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_id,
    primary_key: :id

  belongs_to :respondent,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id

  has_one :question, through: :answer_choice, source: :question

  def sibling_responses
     self.question.responses.where.not(id: self.id)
  end

  private
  def respondent_has_not_already_answered_question
    if sibling_responses.include?(self)
      error[:base] << "you can't answer the same question twice"
    end
  end

end
