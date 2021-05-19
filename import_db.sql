PRAGMA foreign_keys = ON;

CREATE TABLE users (
id INTEGER PRIMARY KEY,
fname varchar NOT NULL,
lname varchar NOT NULL
);

CREATE TABLE questions (
title TEXT PRIMARY KEY,
body TEXT NOT NULL,
associated_author varchar NOT NULL,

FOREIGN KEY (associated_author) REFERENCES users(id)
);

CREATE TABLE question_follows (

);

CREATE TABLE replies (

);

CREATE TABLE question_likes (
title TEXT PRIMARY KEY,
user_id INTEGER NOT NULL,
FOREIGN KEY (title) REFERENCES questions(title),
FOREIGN KEY (user_id) REFERENCES users(id)
);