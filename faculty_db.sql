CREATE TABLE `users` (
    `user_id` INT AUTO_INCREMENT PRIMARY KEY,
    `position` VARCHAR(255),
    `first_name` VARCHAR(255),
    `last_name` VARCHAR(255),
    `date_of_birth` DATE,
    `email` VARCHAR(255),
    `phone` VARCHAR(255),
    `address` VARCHAR(255),
    `course_id` INT,
    `stream_id` INT,
    `group_id` INT,
    `salary_id` INT,
    `mog_id` INT,
    INDEX (`course_id`),
    INDEX (`stream_id`),
    INDEX (`group_id`),
    INDEX (`salary_id`),
    INDEX (`mog_id`)
) ENGINE = INNODB;

CREATE TABLE `courses` (
    `course_id` INT PRIMARY KEY,
    `course` VARCHAR(255),
    FOREIGN KEY (`course_id`) REFERENCES `users`(`course_id`)
) ENGINE = INNODB;

CREATE TABLE `streams` (
    `stream_id` INT PRIMARY KEY,
    `stream` VARCHAR(255),
    FOREIGN KEY (`stream_id`) REFERENCES `users`(`stream_id`)
) ENGINE = INNODB;

CREATE TABLE `groups` (
    `group_id` INT PRIMARY KEY,
    `group` VARCHAR(255),
    FOREIGN KEY (`group_id`) REFERENCES `users`(`group_id`)
) ENGINE = INNODB;

CREATE TABLE `salary` (
    `salary_id` INT PRIMARY KEY,
    `salary` INT,
    FOREIGN KEY (`salary_id`) REFERENCES `users`(`salary_id`)
) ENGINE = INNODB;

CREATE TABLE `mog` (
    `mog_id` INT PRIMARY KEY,
    `mog` VARCHAR(255),
    FOREIGN KEY (`mog_id`) REFERENCES `users`(`mog_id`)
) ENGINE = INNODB;
