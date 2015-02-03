
class QuestionFollower
  def self.find_by_id(id)
    fields = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_followers
      WHERE
        id = ?
      SQL
    QuestionFollower.new(fields.first)
  end

  def self.followers_for_question_id(question_id)
    followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        question_followers AS followings
      JOIN
        questions ON questions.id = followings.question_id
      JOIN
        users ON users.id = followings.user_id
      WHERE
        followings.question_id = ?
      SQL
      followers.map { |follower| User.new(follower) }
  end

  def self.followed_questions_for_user_id(user_id)
    follows = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        question_followers AS followings
      JOIN
        questions ON questions.id = followings.question_id
      JOIN
        users ON users.id = followings.user_id
      WHERE
        followings.user_id = ?
      SQL
      follows.map { |follow| Question.new(follow) }
  end

  def self.most_followed_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT
      questions.*
    FROM
      question_followers AS followings
    JOIN
      questions ON questions.id = followings.user_id
    GROUP BY
      questions.id
    ORDER BY
      COUNT(followings.user_id)
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
