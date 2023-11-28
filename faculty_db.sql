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
  ('lecturer', 'Hrant', 'Khachatryan', '1986-10-06', 'hrant.khachatryan@gmail.com', '094546444','Baghramyan 16'),
  ('student', 'Arusyak', 'Nakhshkaryan', '2003-06-23', 'arusyak.nakhshkaryan@gmail.com', '093556783', 'Komitas 23'),
  ('student', 'Vardan', 'Petrosyan', '2001-03-12', 'vardan.petrosyan@gmail.com', '094648732', 'Komitas 12'),
  ('student', 'Nune', 'Haroyan', '2003-11-05', 'nune.haroyan@gmail.com', '093645678', 'Baghramyan 3'),
  ('student', 'Gor', 'Garanyan', '2003-04-25', 'gor.garanyan@gmail.com', '055464646', 'Saryan 12'),
  ('student', 'Arzhanik', 'Zaqoyan', '2003-05-15', 'arzhanik.zaqoyan@gmail.com', '098989868', 'Avan 2'),
  ('student', 'Anush', 'Khachatryan', '2003-02-22', 'anush.khachatryan@gmail.com', '093939393', 'Avan 7'),
  ('student', 'Lyova', 'Azaryan', '2003-04-08', 'lyova.azaryan@gmail.com', '055657565', 'Isakov 5'),
  ('student', 'Narek', 'Avoyan', '2003-12-28', 'narek.avoyan@gmail.com', '093657845', 'Isakov 10'),
  ('lecturer', 'Karine', 'Galstyan, '1959-06-16','karine.galstyan@gmail.com', '093354675', 'Avan 25'),  
  ('student', 'Saten', 'Ishkhanyan', '2003-08-15', 'saten.ishkhanyan@gmail.com', '094442434', 'Bangladesh 23'),
  ('student', 'Ani', 'Avagyan', '2003-09-18', 'ani.avagyan@gmail.com', '055657565', 'Avan 16'),
  ('student', 'Julya', 'Zilabyan','2003-01-15', 'julya.zilabyan@gmail.com', '093535363', 'Bangladesh 14'),
  ('student', 'Arman', 'Petrosyan', '2003-05-24', 'arman.petrosyan@gmail.com', '055959595', 'Saryan 31'),
  ('student', 'Lilith', 'Gabrielyan', '2003-07-27', 'lilith.gabrielyan@gmail.com', '094545454', 'Avan 1'),
  ('student', 'Vika', 'Hovelyan', '2003-08-21', 'vika.hovelyan@gmail.com', '055857585', 'Zoravar Andranik 13'),
  ('student', 'Harutyun', 'Maranjyan', '2003-07-17', 'harutyun.maranjyan@gmail.com', '098686868', 'Garegin Njdeh 12'),
  ('student', 'Luiza', 'Tevanyan', '2003-05-23', 'luiza.tevanyan@gmail.com', '077878787', 'Monument 23'),
  ('lecturer', 'Sofik', 'Toroyan', '1990-09-23', 'sofik.toroyan@gmail.com', '055453545', 'Saryan 17'),
  ('student', 'Nana', 'Virabyan', '2002-02-12', 'nana.virabyan@gmail.com', '098786878', 'Abovyan 12'),
  ('student', 'Arsen', 'Safaryan', '2001-05-25', 'arsen.safaryan@gmail.com', '055453545', 'Avan 28'),
  ('lecturer', 'Kamo', 'Harutyunyan', '1950-08-29', 'kamo.harutyunyan@gmail.com', '055253545', 'Bangladesh 33'),
  ('lecturer', 'Sahak', 'Sahakyan', '1950-03-23', 'sahak.sahakyan@gmail.com', '094444494', 'Saryan 5'),
  ('lecturer', 'Zohrab', 'Hovhannisyan', '1949-06-27', 'zohrab.hovhannisyan@gmail.com', '055253525', 'Zoravar Andranik 14'),
  ('lecturer', 'Armen', 'Andreasyan', ''1955-09-16', 'armen.andreasyan@gmail.com', '093435363', 'Abovyan 3'),
  ('lecturer', 'Zaven', 'Nazaryan', '1945-07-09', 'zaven.nazaryan@gmail.com', '093332333', 'Nar-Dos 24')
  ('lecturer', 'Varujan', 'Gabrielyan', '1980-04-14', 'varuj.gabrielyan@gmail.com', '094244454', 'Nar-Dos 20');
	
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
   (6, '401');
   
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
   (1, '9,5'),
   (2, '10,45'),
   (3, '11,2'),
   (4, '11,95'),
   (5, '12,34'),
   (6, '12,83'),
   (7, '13,1'),
   (8, '13,67'),
   (9, '14,11'),
   (10, '14,26'),
   (11, '14,5'),
   (12, '14.54'),
   (13, '14,89'),
   (14, '15'),
   (15, '15,41'),
   (16, '15,79'),
   (17, '16,23'),
   (18, '16,56'),
   (19, '17,1'),
   (20, '17,18'),
   (21, '17,39'),
   (22, '18,04'),
   (23, '18,42'),
   (24, '19,5'),
   (25, '20');
   
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
   (12, 'Web programming'),
   (13, 'Assembler'),
   (14, 'Complex analysis'),
   (15, 'Analitic geometry and algebra')
   (16, 'Theory of translations'),
   (17, 'Functional analysis'),
   (18, 'Differential equations'),
   (19, 'Probability theory'),
   (20, 'Physics'),
   (21, 'Computer networks');

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

# Inserting data into the `courses` table
INSERT INTO `courses`(`user_id`, `course_id`)
VALUES 
    #students	
    (1,1),
    (2,1),
    (5,1),
    (6,1),
    (9,1),
    (10,1),
    (11,2),
    (13,2),
    (14,2),
    (15,2),
    (16,2),
    (17,2),
    (18,3),
    (19,3),
    (20,3),
    (22,3),
    (23,3),
    (24,3),
    (25,3),
    (26,4),
    (27,4),
    (28,4),
    (29,4),
    (31,4),
    (32,4),
    #lecturers
    (3,1),
    (3,2),
    (3,3),
    (4,1),
    (4,2),
    (4,4),
    (7,2),
    (12,1),
    (12,2),
    (21,2),
    (21,3),
    (30,3),
    (33,2),
    (34,3),
    (35,1),
    (35,3),
    (35,4),
    (36,1),
    (36,2),
    (36,4),
    (37,2),
    (37,3),
    (38,1),
    (38,2);
	
# Inserting data into the `user_salary`
INSERT INTO `user_salary`(`user_id`, `salary_id`)
VALUES 
    (3,6),
    (4,6),
    (7,5),
    (8,2),
    (12,4),
    (21,2),
    (30,1),
    (33,1),
    (34,4),
    (35,5),
    (36,6),
    (37,3),
    (38,3);

# Inserting data into the `user_mog` table
INSERT INTO `user_mog`(`user_id`, `mog_id`)
VALUES 
    (1,22),
    (2,23),
    (5,7),
    (6,2),
    (9,21),
    (10,3),
    (11,4),
    (13,18),
    (14,1),
    (15,5),
    (16,6),
    (17,9),
    (18,24),
    (19,17),
    (20,19),
    (22,16),
    (23,14),
    (24,13),
    (25,12),
    (26,11),
    (27,8),
    (28,10),
    (29,15),
    (31,25),
    (32,20);
	
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
