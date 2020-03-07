-- 1. 5 oldest users on platform

SELECT * 
FROM users
ORDER BY created_at
LIMIT 5;

-- 2. Most Popular Registration Date

SELECT 
	DAYNAME(created_at) AS day,
	COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC
LIMIT 1;

-- 3. Identify Inactive Users (0 photos)

SELECT username
FROM users
LEFT JOIN photos
	ON users.id = photos.user_id
WHERE photos.id IS NULL;

-- 4. User with Most Liked Photo

SELECT 
	username,
	photos.id, 
	photos.image_url, 
	COUNT(*) AS total
FROM photos
INNER JOIN likes
	ON likes.photo_id = photos.id
INNER JOIN users
	ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;

-- 5. Average posts per user

SELECT (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS avg;

-- 6. 5 most popular hashtags

SELECT 
	tags.tag_name,
	COUNT(*) as total
FROM photo_tags
JOIN tags
	ON photo_tags.tag_id = tags.id
GROUP BY tags.id
ORDER BY total DESC
LIMIT 5;

-- 7. BOTS (Users that have liked every photo)

SELECT 
	username,
	user_id,
	COUNT(*) AS num_likes
FROM users
INNER JOIN likes
	ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING num_likes = (SELECT COUNT(*) FROM photos);