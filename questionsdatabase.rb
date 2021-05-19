require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Question

  attr_accessor :id, :title, :body, :associated_author

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    data.map { |datum| Question.new(datum) }
  end

  def self.find_by_id(id)
    question = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL

    return nil if question.length < 0 # might be <= 0
    Question.new(question.first)
  end



  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @associated_author = options['associated_author']
  end

  def self.find_by_author_id(author_id)
      question = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        associated_author = ?
    SQL

    return nil if question.length < 0 # might be <= 0
    # Question.new(question.first)
    question.map {|ob| Question.new(ob)}
  end

end

class User 

    attr_accessor :id, :fname, :lname

    def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM users")
    data.map { |datum| User.new(datum) }
  end

    def self.find_by_id(id)
    user = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL

    return nil if user.length < 0 # might be <= 0
    User.new(user.first)
    end

    def self.find_by_name(fname,lname)
    user = QuestionsDatabase.instance.execute(<<-SQL, fname,lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL

    return nil if user.length < 0 # might be <= 0
    User.new(user.first)
    end

    def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end
end

class Reply
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

      def self.find_by_question_id(user_id)
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

end
