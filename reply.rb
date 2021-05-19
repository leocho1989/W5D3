require_relative 'questionsdatabase'
require_relative 'user'

class Reply
  attr_accessor :id, :subject_question, :parent, :user_id, :body

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_user_id(user_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL

    return nil if replies.length < 0 # might be <= 0
    replies.map {|reply| Reply.new(reply)}
  end

  def self.find_by_question_id(question_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        subject_question = ?
    SQL

    return nil if replies.length < 0 # might be <= 0
    replies.map {|reply| Reply.new(reply)}
  end

  def initialize(options)
    @id = options['id']
    @subject_question = options['subject_question']
    @parent = options['parent']
    @user_id = options['user_id']
    @body = options['body']
  end

  def author
    User.find_by_id(@user_id)
  end

end