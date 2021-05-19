require_relative 'user'
require_relative 'question'

class QuestionFollow

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
    data.map { |datum| QuestionFollow.new(datum) }
  end

  def self.followers_for_question_id(question_id)
    users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        users
      WHERE
        id IN (
          SELECT
            user_id
          FROM
            question_follows
          WHERE
            question_id = ?
        )
    SQL

    return nil unless users.length > 0  # might be <= 0
    users.map { |user| User.new(user) }

  end
end