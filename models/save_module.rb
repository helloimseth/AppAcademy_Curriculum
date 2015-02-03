module SaveFunctions

  def save
    id.nil? ? insert : update
  end

  def insert
    fields = self.instance_variables
    QuestionsDatabase.instance.execute(<<-SQL, fields)
    INSERT INTO
      replies(question_id, parent_id, user_id, body )
    VALUES
      (:question_id, :parent_id, :user_id, :body)
    SQL

    self.id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    fields = self.instance_variables
    QuestionsDatabase.instance.execute(<<-SQL, fields)
    UPDATE
      replies
    SET
      question_id = :question_id, parent_id = :parent_id,
      user_id = :user_id, body = :body
    WHERE
      id = :id
    SQL
  end

end
