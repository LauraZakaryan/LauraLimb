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

CREATE TABLE `courses` (
    `id` INT PRIMARY KEY,
    `name` VARCHAR(255)
) ENGINE = INNODB;

CREATE TABLE `streams` (
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

CREATE TABLE `user_courses` (
    `user_id` INT,
    `course_id` INT,
    PRIMARY KEY (`user_id`, `course_id`),
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY (`course_id`) REFERENCES `courses`(`id`)
) ENGINE = INNODB;

CREATE TABLE `user_streams` (
    `user_id` INT,
    `stream_id` INT,
    PRIMARY KEY (`user_id`, `stream_id`),
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY (`stream_id`) REFERENCES `streams`(`id`)
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

# Inserting data into the `users` table
INSERT INTO `users`(`position`, `first_name`, `last_name`, `date_of_birth`, `email`, `phone`, `address`)
VALUES 
  ('student', 'Zhanna', 'Margaryan', '2003-07-19', 'zhannamargaryan@gmail.com', '077225566','Minasyan 19'),
  ('student', 'Anush', 'Arustamyan', '2003-04-01', 'anush.arustamyan@gmail.com', '094949494','Nar-Dos 2'),
  ('lecturer', 'Karen', 'Navasardyan', '1965-07-16', 'karen.navasardyan@gmail.com', '055636363','Baghramyan 18'),
  ('lecturer', 'Petros', 'Petrosyan', '1978-06-17', 'petros.petrosyan@gmail.com', '077273747','Koryun 6'),
  ('student', 'Ani', 'Arzumanyan', '2003-02-10', 'ani.arzumanyan@gmail.com', '055556565','Minasyan 9'),
  ('student', 'Anahit', 'Sahakyan', '2003-03-03', 'anahit.sahakyan@gmail.com', '098989868','Saryan 20'),
  ('lecturer', 'Siranush', 'Sargsyan', '1953-06-14', 'siranush.sargsyan@gmail.com', '093232343','Arshakunyats 28'),
  ('dean_office_worker', 'Eranuhi', 'Davtyan', '1989-07-07', 'eranuhi.davtyan@gmail.com', '098489848','Isakov 24'),
  ('student', 'Narine', 'Poghosyan', '2003-04-14', 'narine.poghosyan@gmail.com', '055454545','Isakov 18'),
  ('student', 'Zarine', 'Grigoryan', '2003-06-15', 'zarine,grigoryan@gmail,com', '077171777', 'Saryan 4'),
  ('student', 'Srbuhi', 'Khachatryan' , '2003-08-01', 'srbuhi.khachatryan@gmail.com', '093636393', 'Garegin Njdeh 8'),
  ('lecturer', 'Hrant', 'Khachatryan', '1986-10-06', 'hrant.khachatryan@gmail.com', '094546444','Baghramyan 16');
  
# Inserting data into the `courses` table
INSERT INTO `courses` (`id`,`name`)
VALUES 
   (1, 'first'),
   (2, 'second'),
   (3, 'third'),
   (4, 'fourth');
 
# Inserting data into the `streams` table
INSERT INTO `streams` (`id`,`name`)
VALUES 
   (1, 'first'),
   (2, 'second');
   
# Inserting data into the `groups` table
INSERT INTO `groups` (`id`, `name`)
VALUES    
   (1, '101'),
   (2, '102'),
   (3, '201'),
   (4, '202'),
   (5, '301'),
   (6, '302'),
   (7, '401'),
   (8, '402');
   
# Inserting data into the `salary` table
INSERT INTO `salary` (`id`, `amount`)
VALUES 
   (1, 100000),
   (2, 150000),
   (3, 200000),
   (4, 250000),
   (5, 300000),
	(6, 350000);
   
# Inserting data into the `mog` table
INSERT INTO `mog` (`id`, `name`)
VALUES
   (1, '16,5'),
   (2, '17,75'),
   (3, '19,5'),
   (4, '20'),
   (5, '13,9');
   
# Inserting data into the `subjects` table
INSERT INTO `subjects` (`id`, `name`)
VALUES 
   (1, 'Mathematical analysis'),
   (2, 'Discrete mathematics'),
   (3, 'Basics of C++'),
   (4, 'Data structure'),
   (5, 'ML'),
   (6, 'Numerical methods'),
   (7, 'Linear algebra'),
   (8, 'GUI'),
   (9, 'Operating systems'),
   (10, 'Theory of algorithms'),
   (11, 'Graph theory'),
   (12, 'Web programming');  
   
# Inserting data into the `class` table
INSERT INTO `class` (`start_time`, `end_time`)
VALUES 
   ('9:30', '10:55'),
   ('11:05', '12:30'),
   ('13:00', '14:25'),
   ('14:30', '15:55');
   
# Inserting data into the `semesters` table
INSERT INTO `semesters` (`name`, `start_date`, `end_date`)
VALUES 
   ('first semester', '2023-09-01', '2024-01-31'),
   ('second semester', '2024-02-05', '2024-06-30');
   
# Inserting data into the `user_courses`
INSERT INTO `user_courses`(`user_id`, `course_id`)
VALUES 
   (1,2),
   (2,3),
   (5,3),
   (6,1),
   (9,4),
   (10,1),
   (11,2);   
   
# Inserting data into the `schedule` table
# Schedule for the first semester, group 101
INSERT INTO `schedule` (
    `day_of_week`,
    `class_id`,
    `group_id`,
    `subject_id`,
    `user_id`,
    `room_number`,
    `semester_id`
)
VALUES
    ('Monday', 1, 1, 1, 3, 'Room 101', 1),
    ('Monday', 2, 1, 4, 7, 'Room 102', 1),
    ('Friday', 3, 1, 2, 4, 'Room 103', 1);

# Schedule for the first semester, group 102
INSERT INTO `schedule` (
    `day_of_week`,
    `class_id`,
    `group_id`,
    `subject_id`,
    `user_id`,
    `room_number`,
    `semester_id`
)
VALUES
    ('Monday', 1, 2, 2, 4, 'Room 201', 1),
    ('Wednesday', 2, 2, 5, 7, 'Room 202', 1),
    ('Friday', 3, 2, 1, 3, 'Room 203', 1);

# Schedule for the second semester, group 201
INSERT INTO `schedule` (
    `day_of_week`,
    `class_id`,
    `group_id`,
    `subject_id`,
    `user_id`,
    `room_number`,
    `semester_id`
)
VALUES
    ('Monday', 1, 3, 12, 7, 'Room 301', 2),
    ('Wednesday', 2, 3, 11, 12, 'Room 302', 2),
    ('Friday', 3, 3, 1, 3, 'Room 303', 2);

# Schedule for the second semester, group 202
INSERT INTO `schedule` (
    `day_of_week`,
    `class_id`,
    `group_id`,
    `subject_id`,
    `user_id`,
    `room_number`,
    `semester_id`
)
VALUES
    ('Monday', 1, 4, 11, 4, 'Room 401', 2),
    ('Wednesday', 2, 4, 1, 3, 'Room 402', 2),
    ('Friday', 3, 4, 10,12, 'Room 403', 2);
