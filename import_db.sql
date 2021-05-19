PRAGMA foreign_keys = ON;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname varchar NOT NULL,
  lname varchar NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  associated_author varchar NOT NULL,

  FOREIGN KEY (associated_author) REFERENCES users(id)  
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL , 
  user_id INTEGER NOT NULL, -- id of the user following the question

  FOREIGN KEY (question_id) REFERENCES questions(id)
  FOREIGN KEY (user_id) REFERENCES user(id)
); 

/*
  id  title     user_id
  1    q1        1
  2    q1        2
  3    q2        1
  4    q3        1   #questions should at least have 1 follower(the asker)
  5   NULL       3   #didn't ask or follow any questions
*/

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  subject_question INTEGER NOT NULL,
  parent TEXT,  --top level replies don't need parents
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,

  FOREIGN KEY (parent) REFERENCES replies(id),
  FOREIGN KEY (subject_question) REFERENCES questions(id)
);

CREATE TABLE question_likes (
  question_id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
 users (fname,lname)
VALUES 
 ('Leo','Cao'),
 ('Miguel','Dela Cruz');

INSERT INTO
 questions (title, body, associated_author)
VALUES
 ('question no.1', '1abcdefghijk', 1),
 ('question no.2', '2efgdcvgggbb', 2),
 ('question no.3', '3uujufvbghjh', 2);

INSERT INTO
  replies (subject_question, parent, user_id, body)
VALUES
  (1, NULL, 2, 'questions 1, answered by user 2'),
  (2, NULL, 1, 'questions 2, answered by user 1'),
  (2, 2, 2, 'questions 2, answered by user 1, replied to by user 2');
