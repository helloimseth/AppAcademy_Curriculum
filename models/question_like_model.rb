class QuestionLike
  def self.find_by_id(id)
    fields = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?
      SQL
    QuestionLike.new(fields.first)
  end

  def self.likers_for_question_id(question_id)
    likers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        question_likes AS likings
      JOIN
        questions ON questions.id = likings.question_id
      JOIN
        users ON users.id = likings.user_id
      WHERE
        likings.question_id = ?
      SQL
      likers.map { |liker| User.new(liker) }
  end

  def self.num_likes_for_question_id(question_id)
    likes = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        question_likes AS likings
      JOIN
        questions ON questions.id = likings.question_id
      JOIN
        users ON users.id = likings.user_id
      WHERE
        likings.question_id = ?
      SQL
      likes.count
  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        question_likes AS likings
      JOIN
        questions ON questions.id = likings.question_id
      JOIN
        users ON users.id = likings.user_id
      WHERE
        likings.user_id = ?
      SQL

      questions.map { |question| Question.new(question) }
  end

  def self.most_liked_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        question_likes as likings
      JOIN
        questions ON questions.id = likings.question_id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(likings.user_id)
      LIMIT
        ?
    SQL

    questions.map { |question| Question.new(question) }
  end

  attr_accessor :id, :question_id, :user_id

  def initialize( options = {} )
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

end
