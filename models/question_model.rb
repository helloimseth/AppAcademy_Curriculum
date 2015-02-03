class Question
  def self.find_by_id(id)
    fields = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
      SQL
    Question.new(fields.first)
  end

  def self.find_by_author_id(id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        user_id = ?
      SQL
    questions.map { |question| Question.new(question)}
  end

  attr_accessor :id, :user_id, :body

  def initialize( options = {} )
    @id = options['id']
    @user_id = options['user_id']
    @body = options['body']
  end

  def author
    User.find_by_id(user_id)
  end

  def replies
    self_replies = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
      SQL
    self_replies.map { |reply| Reply.new(reply) }
  end



end
