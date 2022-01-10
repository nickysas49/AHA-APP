CREATE DATABASE AHA_app;

CREATE TABLE images (
    id SERIAL PRIMARY KEY,
    name TEXT,
    image_front TEXT, 
    image_back TEXT, 
    image_top TEXT, 
    image_bottom TEXT, 
    image_left TEXT, 
    image_right TEXT
);

INSERT INTO 
images (name, image_front, image_back, image_top, image_bottom, image_left, image_right)
values('ECLIPSE', 'https://i.pinimg.com/474x/c1/fb/5d/c1fb5d5bcd7fa67f7c4d3a51180c2b27.jpg', 'https://i.pinimg.com/474x/8f/67/9a/8f679a30f1b1f52e15f8e0fef1f49daa.jpg', 'https://i.pinimg.com/474x/35/53/ed/3553edee7ecdc7196e5e1ca78dd1880d.jpg', 'https://i.pinimg.com/474x/ed/11/e4/ed11e434ceae1aa8aeff7787617ab5d4.jpg', 'https://i.pinimg.com/474x/dc/2c/49/dc2c49e09d7672b8126aeb98c0daf14d.jpg', 'https://i.pinimg.com/474x/fe/43/d6/fe43d649aa3a106c44dc173b3f8dc874.jpg');

SELECT * FROM images;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email TEXT,
  password_digest TEXT
);

ALTER TABLE images ADD user_id INTEGER;
INSERT INTO users (email, password_digest) values('niki@niki.com', 'pudding');
SELECT * FROM users;

ALTER TABLE images ADD image_flq TEXT;
ALTER TABLE images ADD image_blq TEXT;
ALTER TABLE images ADD image_frq TEXT;
ALTER TABLE images ADD image_brq TEXT;

ALTER TABLE images ADD catalog TEXT;