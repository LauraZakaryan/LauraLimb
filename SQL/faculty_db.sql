CREATE TABLE `users` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `position` VARCHAR(255),
    `first_name` VARCHAR(255),
    `last_name` VARCHAR(255),
    `date_of_birth` DATE,
    `email` VARCHAR(255),
    `phone` VARCHAR(255),
    `address` VARCHAR(255),
    INDEX `idx_user`(`first_name`, `last_name`, `position`)
) ENGINE = INNODB;

CREATE TABLE `user_metadata`(
    `id` INT,
    `user_id` INT,
    `meta_key` VARCHAR(255),
    `meta_value` VARCHAR(255),
    PRIMARY KEY(`user_id`, `meta_key`),
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE = INNODB;

CREATE TABLE `courses` (
    `id` INT PRIMARY KEY,
    `name` VARCHAR(255)
) ENGINE = INNODB;

CREATE TABLE `groups` (
    `id` INT PRIMARY KEY,
    `name` VARCHAR(255),
    INDEX `idx_group`(`name`)
) ENGINE = INNODB;

CREATE TABLE `salary` (
    `id` INT PRIMARY KEY,
    `amount` FLOAT 
) ENGINE = INNODB;

CREATE TABLE `mog` (
    `id` INT PRIMARY KEY,
    `name` VARCHAR(255)
) ENGINE = INNODB;

CREATE TABLE `user_groups` (
    `user_id` INT,
    `group_id` INT,
    PRIMARY KEY (`user_id`, `group_id`),
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY (`group_id`) REFERENCES `groups`(`id`)
) ENGINE = INNODB;

CREATE TABLE `user_salary` (
    `user_id` INT,
    `salary_id` INT,
    PRIMARY KEY (`user_id`, `salary_id`),
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY (`salary_id`) REFERENCES `salary`(`id`)
) ENGINE = INNODB;

CREATE TABLE `user_mog` (
    `user_id` INT,
    `mog_id` INT,
    PRIMARY KEY (`user_id`, `mog_id`),
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY (`mog_id`) REFERENCES `mog`(`id`)
) ENGINE = INNODB;

CREATE TABLE `subjects` (
    `id` INT PRIMARY KEY,
    `name` VARCHAR(255)
) ENGINE = INNODB;

CREATE TABLE `class` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `start_time` TIME,
    `end_time` TIME
) ENGINE = INNODB;

CREATE TABLE `semesters` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255),
    `start_date` DATE,
    `end_date` DATE
) ENGINE = INNODB;

CREATE TABLE `course_groups` (
    `course_id` INT,
    `group_id` INT,
    `semester_id` INT,
    PRIMARY KEY (`semester_id`, `group_id`,`course_id`),
    FOREIGN KEY (`course_id`) REFERENCES `courses`(`id`),
    FOREIGN KEY (`group_id`) REFERENCES `groups`(`id`),
    FOREIGN KEY (`semester_id`) REFERENCES `semesters`(`id`)
) ENGINE = INNODB;

CREATE TABLE `schedule` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `day_of_week` VARCHAR(255),
    `class_id` INT,
    `group_id` INT,
    `subject_id` INT,
    `user_id` INT,
    `room_number` VARCHAR(255),
    `semester_id` INT, 
    FOREIGN KEY (`class_id`) REFERENCES `class`(`id`),
    FOREIGN KEY (`group_id`) REFERENCES `groups`(`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY (`subject_id`) REFERENCES `subjects`(`id`),
    FOREIGN KEY (`semester_id`) REFERENCES `semesters`(`id`),
    UNIQUE INDEX (`semester_id`,`day_of_week`,`class_id`,`room_number`),
    INDEX (`user_id`,`subject_id`,`group_id`)
) ENGINE = INNODB;


