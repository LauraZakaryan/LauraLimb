# Select all the users who's names ( f name or l name ) contains letter "a"
SELECT `first_name`, `last_name`
FROM `users`
WHERE `first_name`  LIKE '%a%' OR `last_name` LIKE '%a%';


# Select all the groups which studies "English"
SELECT 
     `groups`.`id`, 
	  `groups`.`name`
FROM `schedule`
INNER JOIN `groups` ON `groups`.id =`schedule`.group_id
INNER JOIN `subjects`ON `subjects`.`id` = `schedule`.`subject_id`
WHERE `subjects`.`name`='English'
GROUP BY `groups`.`id`;


# Select groups . Columns: group's id, group's name and student count. Each row should be like this, ex: ->12, "Xumb 1", "24"
SELECT
    `groups`.`id` AS group_id,
    `groups`.`name` AS group_name,
    COUNT(`user_groups`.`user_id`) AS student_count
FROM
    `groups` 
LEFT JOIN
    `user_groups`  ON `groups`.`id` = `user_groups`.`group_id`
GROUP BY
   `groups`.`id`;
   
   
/* Select courses. Those courses which have groups which have studies that are taught by Navasardyan and the days of classes are at Monday and Friday.
 Columns to show: Kurs id , kurs name, group name,  group id, the date of the class, and the time of the class */
SELECT 
    `courses`.`id` AS `course id`,
    `courses`.`name` AS `course name`,
    `schedule`.`group_id` AS `group id`,
    `groups`.`name`AS `group name`,
    `schedule`.`day_of_week` AS `the date of the class`,
    `schedule`.`class_id` AS `the time of the class`
FROM `schedule`
INNER JOIN 
     `courses` ON `courses`.`id` = `schedule`.`course_id` 
INNER JOIN 
     `groups` ON `groups`.`id` = `schedule`.`group_id` 
INNER JOIN 
     `users` ON `users`.`id` = `schedule`.`user_id`
WHERE `users`.`last_name` = 'Navasardyan' AND  `schedule`.`day_of_week` IN ('Monday', 'Friday')
GROUP BY 
     `groups`.`id`;
     
     
# Select all the lecturers who has classes more then 5 times a week, but less then 8. Order the list by their Salary.
SELECT 
    `users`.`id` AS `User id`,
    `users`.`first_name` AS `First name`,
    `users`.`last_name` AS `Last name`,
    `salary`.`amount` AS `Salary`
FROM 
    `users`
CROSS JOIN 
    `user_salary` ON `user_salary`.`user_id` = `users`.`id`
CROSS JOIN 
    `salary` ON `user_salary`.`salary_id` = `salary`.`id`
CROSS JOIN 
    `schedule` ON `schedule`.`user_id` = `users`.`id` AND `users`.`position` = 'lecturer'
WHERE
    `schedule`.`day_of_week` IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')
GROUP BY 
    `users`.`id`
HAVING 
    COUNT(`schedule`.`user_id`) > 5 AND COUNT(`schedule`.`user_id`) < 8
ORDER BY 
    `salary`.`amount`;
    

/* Select all the female lecturers who has more then 20 hours of classes per quarter and whos total salary per year is in between 1m and 4m. 
Order them by salary and age. */
 
SELECT 
    `users`.`id` AS `User id`,
    `users`.`first_name` AS `First name`,
    `users`.`last_name` AS `Last name`,
    12 * `salary`.`amount` AS `Total salary per year`,
    12 * COUNT(DISTINCT `schedule`.`class_id`) AS `Classes per quarter`
FROM 
    `users`
INNER JOIN 
    `user_metadata` ON `user_metadata`.`user_id` = `users`.`id` AND `meta_key` = 'gender' AND `meta_value` = 'female'
INNER JOIN 
    `schedule` ON `schedule`.`user_id` = `users`.`id`
INNER JOIN 
    `user_salary` ON `user_salary`.`user_id` = `users`.`id`
INNER JOIN 
    `salary` ON `user_salary`.`salary_id` = `salary`.`id`
WHERE 
   `schedule`.`day_of_week` IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')
GROUP BY 
    `users`.`id`
HAVING 
    `Total salary per year` >= 1000000 AND `Total salary per year` <= 4000000 AND `Classes per quarter` >= 20
ORDER BY 
    `Total salary per year`, 
	  (CASE WHEN `user_metadata`.`meta_key` = 'age' THEN `user_metadata`.`meta_value` END);
