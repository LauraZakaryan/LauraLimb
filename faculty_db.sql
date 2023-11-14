CREATE TABLE `users` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `position` VARCHAR(255),
    `first_name` VARCHAR(255),
    `last_name` VARCHAR(255),
    `date_of_birth` DATE,
    `email` VARCHAR(255),
    `phone` VARCHAR(255),
    `address` VARCHAR(255)
) ENGINE = INNODB;

CREATE TABLE `courses` (
    `id` INT PRIMARY KEY,
    `course` VARCHAR(255)
) ENGINE = INNODB;

CREATE TABLE `streams` (
    `id` INT PRIMARY KEY,
    `stream` VARCHAR(255)
) ENGINE = INNODB;

CREATE TABLE `groups` (
    `id` INT PRIMARY KEY,
    `group` VARCHAR(255)
) ENGINE = INNODB;

CREATE TABLE `salary` (
    `id` INT PRIMARY KEY,
    `salary` INT
) ENGINE = INNODB;

CREATE TABLE `mog` (
    `id` INT PRIMARY KEY,
    `mog` VARCHAR(255)
) ENGINE = INNODB;

CREATE TABLE `user_courses` (
    `id` INT,
    `course_id` INT,
    PRIMARY KEY (`id`, `course_id`),
    FOREIGN KEY (`id`) REFERENCES `users`(`id`),
    FOREIGN KEY (`course_id`) REFERENCES `courses`(`id`)
) ENGINE = INNODB;

CREATE TABLE `user_streams` (
    `id` INT,
    `stream_id` INT,
    PRIMARY KEY (`id`, `stream_id`),
    FOREIGN KEY (`id`) REFERENCES `users`(`id`),
    FOREIGN KEY (`stream_id`) REFERENCES `streams`(`id`)
) ENGINE = INNODB;

CREATE TABLE `user_groups` (
    `id` INT,
    `group_id` INT,
    PRIMARY KEY (`id`, `group_id`),
    FOREIGN KEY (`id`) REFERENCES `users`(`id`),
    FOREIGN KEY (`group_id`) REFERENCES `groups`(`id`)
) ENGINE = INNODB;

CREATE TABLE `user_salary` (
    `id` INT,
    `salary_id` INT,
    PRIMARY KEY (`id`, `salary_id`),
    FOREIGN KEY (`id`) REFERENCES `users`(`id`),
    FOREIGN KEY (`salary_id`) REFERENCES `salary`(`id`)
) ENGINE = INNODB;

CREATE TABLE `user_mog` (
    `id` INT,
    `mog_id` INT,
    PRIMARY KEY (`id`, `mog_id`),
    FOREIGN KEY (`id`) REFERENCES `users`(`id`),
    FOREIGN KEY (`mog_id`) REFERENCES `mog`(`id`)
) ENGINE = INNODB;
