CREATE TABLE "user" (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

CREATE TABLE temperature (
    temperature_id SERIAL PRIMARY KEY,
    value DECIMAL(5, 2) CHECK (value BETWEEN -100 AND 100),
    timestamp TIMESTAMP NOT NULL,
    user_id INT NOT NULL REFERENCES "user"(user_id) ON DELETE CASCADE
);

CREATE TABLE sculpture (
    sculpture_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL CHECK (title ~ '^Sculpture-.*'),
    description VARCHAR(500),
    user_id INT NOT NULL REFERENCES "user"(user_id) ON DELETE CASCADE
);

CREATE TABLE platform (
    platform_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE "like" (
    like_id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP NOT NULL,
    sculpture_id INT NOT NULL REFERENCES sculpture(sculpture_id) ON DELETE CASCADE,
    user_id INT NOT NULL REFERENCES "user"(user_id) ON DELETE CASCADE
);

CREATE TABLE sculpture_platform (
    sculpture_id INT NOT NULL REFERENCES sculpture(sculpture_id) ON DELETE CASCADE,
    platform_id INT NOT NULL REFERENCES platform(platform_id) ON DELETE CASCADE,
    publish_date TIMESTAMP NOT NULL,
    PRIMARY KEY (sculpture_id, platform_id)
);