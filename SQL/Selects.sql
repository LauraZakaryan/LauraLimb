# Task 1 Select all the users who's names ( f name or l name ) contains letter "a"
SELECT `first_name`, `last_name`
FROM `users`
WHERE `first_name`  LIKE '%a%' OR `last_name` LIKE '%a%';


# Task 2 Select all the groups which studies "English"
SELECT 
     `groups`.`id`, 
	  `groups`.`name`
FROM `schedule`
INNER JOIN `groups` ON `groups`.id =`schedule`.group_id
INNER JOIN `subjects`ON `subjects`.`id` = `schedule`.`subject_id`
WHERE `subjects`.`name`='English'
GROUP BY `groups`.`id`;


# Task 3 Select groups . Columns: group's id, group's name and student count. Each row should be like this, ex: ->12, "Xumb 1", "24"
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
   
   
/* Task 4 Select courses. Those courses which have groups which have studies that are taught by Navasardyan and the days of classes are at Monday and Friday.
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
     
     
# Task 5 Select all the lecturers who has classes more then 5 times a week, but less then 8. Order the list by their Salary.
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
    

/* Task 6 Select all the female lecturers who has more then 20 hours of classes per quarter and whos total salary per year is in between 1m and 4m. 
Order them by salary and age. */
 
SELECT 
    `users`.`id` AS `User id`,
    `users`.`first_name` AS `First name`,
    `users`.`last_name` AS `Last name`,
    12 * `salary`.`amount` AS `Total salary per year`,
    12 * COUNT(`schedule`.`class_id`) AS `Classes per quarter`
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
	  
	  
	  
# Task 7 Determine by single query weather female or male lecturers have more appearances per quarter.

SELECT
    `users`.`id`,
    `total_appearances`,
    (CASE WHEN `female_count` > `male_count` THEN 'Female' ELSE 'Male' END) AS `More_Appearances_Gender`
FROM
    `users`
INNER JOIN (
    SELECT
        `user_id`,
        12 * COUNT(`user_id`) AS `total_appearances`
    FROM `schedule`
    WHERE `user_id` IN (SELECT `id` FROM `users` WHERE `position` = 'lecturer')
    GROUP BY `user_id`
) AS `appearances` ON `users`.`id` = `appearances`.`user_id`
LEFT JOIN (
    SELECT
        `user_id`,
        12 * COUNT(`user_id`) AS `female_count`
    FROM `user_metadata`
    WHERE `meta_key` = 'gender' AND `meta_value` = 'Female'
    GROUP BY `user_id`
) AS `female_counts` ON `users`.`id` = `female_counts`.`user_id`
LEFT JOIN (
    SELECT
        `user_id`,
        12 * COUNT(`user_id`) AS `male_count`
    FROM  `user_metadata`
    WHERE  `meta_key` = 'gender' AND `meta_value` = 'Male'
    GROUP BY `user_id`
) AS `male_counts` ON `users`.`id` = `male_counts`.`user_id`
WHERE  `users`.`position` = 'lecturer'

ORDER BY
    `More_Appearances_Gender`;
    
    
# Task 8 Determine by single query weather female or male lecturers get more salary per month in total.
SELECT
    SUM(`salary`.`amount`) AS total_salary,
    CASE WHEN SUM(CASE WHEN `user_metadata`.`meta_value` = 'female' THEN `salary`.`amount` ELSE 0 END) > 
                   SUM(CASE WHEN `user_metadata`.`meta_value` = 'male' THEN `salary`.`amount` ELSE 0 END)
         THEN 'female'
         ELSE 'male'
    END AS higher_salary_gender
FROM
    `users`
INNER JOIN 
    `user_metadata` ON `users`.`id` = `user_metadata`.`user_id`
INNER JOIN
    `user_salary`  ON `users`.`id` = `user_salary`.`user_id`
INNER JOIN
    `salary`  ON `user_salary`.`salary_id` = `salary`.`id`
WHERE
    `users`.`position` = 'lecturer'
    AND `user_metadata`.`meta_value` IN ('female', 'male')
GROUP BY
    `user_metadata`.`meta_value`
ORDER BY
     higher_salary_gender DESC;

