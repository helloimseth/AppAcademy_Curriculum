CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  f_name VARCHAR(255) NOT NULL,
  l_name VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_followers (
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
  FOREIGN KEY (question_id) REFERENCES questions(id)
  FOREIGN KEY (parent_id) REFERENCES replies(id)
);

CREATE TABLE question_likes (
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users(f_name, l_name)
VALUES
  ('Rich', 'Nelson'), ('Seth', 'Hamlin');

INSERT INTO
  questions(body, user_id)
VALUES
  ('Does Sennacy really exist?', (SELECT id FROM users WHERE f_name = 'Rich' AND l_name = 'Nelson')),
  ('What kinda name is Sennacy?', (SELECT id FROM users WHERE f_name = 'Seth' AND l_name = 'Hamlin')),
  ('How old is the earth?', (SELECT id FROM users WHERE f_name = 'Rich' AND l_name = 'Nelson')),
  ('Who framed Roger Rabbit?', (SELECT id FROM users WHERE f_name = 'Seth' AND l_name = 'Hamlin'));

INSERT INTO
  question_followers(user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE f_name = 'Rich' AND l_name = 'Nelson'),
   (SELECT id FROM questions WHERE body = 'What kinda name is Sennacy?')),
  ((SELECT id FROM users WHERE f_name = 'Seth' AND l_name = 'Hamlin'),
   (SELECT id FROM questions WHERE body = 'Does Sennacy really exist?'));

INSERT INTO
  replies(question_id, parent_id, user_id, body)
VALUES
  ((SELECT id FROM questions WHERE body = 'What kinda name is Sennacy?'),
    NULL, (SELECT id FROM users WHERE f_name = 'Seth' AND l_name = 'Hamlin'),
    'I think its a funny name'),
  ((SELECT id FROM questions WHERE body = 'What kinda name is Sennacy?'),
   (SELECT id FROM replies WHERE body = 'I think its a funny name'),
   (SELECT id FROM users WHERE f_name = 'Rich' AND l_name = 'Nelson'),
   'I think its a beautiful name'),
  ((SELECT id FROM questions WHERE body = 'Who framed Roger Rabbit?'),
    NULL, (SELECT id FROM users WHERE f_name = 'Rich' AND l_name = 'Nelson'),
    'That judge guy');

INSERT INTO
  question_likes(user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE f_name = 'Rich' AND l_name = 'Nelson'),
   (SELECT id FROM questions WHERE body = 'What kinda name is Sennacy?')),
  ((SELECT id FROM users WHERE f_name = 'Seth' AND l_name = 'Hamlin'),
   (SELECT id FROM questions WHERE body = 'Does Sennacy really exist?'));
