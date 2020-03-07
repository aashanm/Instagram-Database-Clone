DROP DATABASE ig_clone;
CREATE DATABASE ig_clone;
USE ig_clone;

CREATE TABLE users (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
	username VARCHAR(255) UNIQUE NOT NULL,
	created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photos (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(255) NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE comments (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
	comment_text VARCHAR(255) NOT NULL,
	user_id INTEGER NOT NULL,
	photo_id INTEGER NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY(user_id) REFERENCES users(id),
	FOREIGN KEY(photo_id) REFERENCES photos(id)
);

INSERT INTO users (username) VALUES
('Aashan'),
('Bob'),
('Charly');

INSERT INTO photos (image_url, user_id) VALUES
('/weiubw', 1),
('/oigen', 2),
('/erinoe', 2);

INSERT INTO comments(comment_text, user_id, photo_id) VALUES
('Hello!', 1, 2),
('Cool!', 3, 2),
('This is sick', 2, 1);

SELECT photos.image_url, users.username
FROM photos
JOIN users
	ON photos.user_id = users.id;