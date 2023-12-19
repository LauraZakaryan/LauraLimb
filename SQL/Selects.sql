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
    `semesters`.`start_date`,
    `semesters`.`end_date`,
    `semesters`.`name` AS `semester`,
    `courses`.`id` AS `course_id`,
    `courses`.`name` AS `course_name`,
    `schedule`.`group_id` AS `group_id`,
    `groups`.`name`AS `group_name`,
    `schedule`.`day_of_week` AS `the_date_of_the_class`,
    `schedule`.`class_id` AS `the_time_of_the_class`
FROM `schedule`
INNER JOIN 
     `groups` ON `groups`.`id` = `schedule`.`group_id` 
INNER JOIN 
     `users` ON `users`.`id` = `schedule`.`user_id`
INNER JOIN 
     `course_groups` ON `groups`.`id` = `course_groups`.`group_id` 
INNER JOIN
     `courses` ON `courses`.`id` = `course_groups`.`course_id`
INNER JOIN 
      `semesters` ON `semesters`.`id` = `schedule`.`semester_id`
WHERE `users`.`last_name` = 'Navasardyan' AND  `schedule`.`day_of_week` IN ('Monday', 'Friday');

# keep_property_names_lowercase_with_underscore
# keepPropertyNamesLowercaseWithoutUnderscore
     
# Task 5 Select all the lecturers who has classes more then 5 times a week, but less then 10. Order the list by their Salary.
SELECT 
    `users`.`id` AS `user_id`,
    `users`.`first_name` AS `first_name`,
    `users`.`last_name` AS `last_name`,
    `salary`.`amount` AS `monthly_salary`,
    `semesters`.`start_date`,
    `semesters`.`end_date`,
    `semesters`.`name` AS `semester`
FROM 
    `users`
INNER JOIN 
    `user_salary` ON `user_salary`.`user_id` = `users`.`id`
INNER JOIN 
    `salary` ON `user_salary`.`salary_id` = `salary`.`id`
INNER JOIN 
    `schedule` ON `schedule`.`user_id` = `users`.`id` AND `users`.`position` = 'lecturer'
INNER JOIN
    `semesters` ON `semesters`.`id` = `schedule`.`semester_id` 
WHERE `semesters`.`id` = 1
GROUP BY 
    `schedule`.`user_id`
HAVING
    COUNT(`schedule`.`user_id`) > 5 AND COUNT(`schedule`.`user_id`) < 10
ORDER BY 
    `salary`.`amount`;
    

/* Task 6 Select all the female lecturers who has more then 20 hours of classes per quarter and whos total salary per year is in between 1m and 4m. 
Order them by salary and age. */
 
SELECT 
    `semesters`.`name` AS `semester`,
    `semesters`.`start_date`,
    `semesters`.`end_date`,
    `users`.`id` AS `user_id`,
    `users`.`first_name` AS `first_name`,
    `users`.`last_name` AS `last_name`,
    12 * `salary`.`amount` AS `total_salary_per_year`,
    12 * COUNT(`schedule`.`class_id`) AS `classes_per_quarter`
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
INNER JOIN 
    `semesters` ON `semesters`.`id` = `schedule`.`semester_id` AND `semesters`.`id` = 1
GROUP BY 
    `users`.`id`
HAVING 
    `total_salary_per_year` >= 1000000 AND `total_salary_per_year` <= 4000000 AND `classes_per_quarter` >= 20
ORDER BY 
    `total_salary_per_year`, 
	  (CASE WHEN `user_metadata`.`meta_key` = 'age' THEN `user_metadata`.`meta_value` END);
	  
	                                 
# Task 7  Determine by single query weather female or male lecturers have more appearances per quarter.

SELECT
    `semesters`.`start_date`,
    `semesters`.`end_date`,
    `semesters`.`name` AS `semester`,
    `users`.`id`,
    `appearances`.`total_appearances`,
    (CASE WHEN COALESCE(`female_counts`.`total_appearances`,0) > COALESCE(`male_counts`.`total_appearances`,0) THEN 'female' ELSE 'male' END) AS `more_appearances_gender`
FROM
    `users`
INNER JOIN 
    `user_metadata` ON `user_metadata`.`user_id` = `users`.`id` 
INNER JOIN 
    `schedule` ON `schedule`.`user_id` = `users`.`id` AND `schedule`.`semester_id` = 1
INNER JOIN 
    `semesters` ON `semesters`.`id` = `schedule`.`semester_id`
INNER JOIN (
    SELECT
        `user_id`,
        12 * COUNT(`user_id`) AS `total_appearances`
    FROM `schedule`
    WHERE `semester_id` = 1
    GROUP BY `user_id`
) AS `appearances` ON `users`.`id` = `appearances`.`user_id`
LEFT JOIN (
    SELECT
        `schedule`.`user_id`,
        COUNT(`schedule`.`user_id`) AS `total_appearances`
    FROM `schedule`
    INNER JOIN 
         `user_metadata` ON `user_metadata`.`user_id` = `schedule`.`user_id`
    WHERE `meta_key` = 'gender' AND `meta_value` = 'female' 
    GROUP BY `schedule`.`user_id`
) AS `female_counts` ON `users`.`id` = `female_counts`.`user_id`
LEFT JOIN (
    SELECT
        `schedule`.`user_id`,
        COUNT(`schedule`.`user_id`) AS `total_appearances`
    FROM  `schedule`
    INNER JOIN 
          `user_metadata` ON `user_metadata`.`user_id` = `schedule`.`user_id`
    WHERE  `meta_key` = 'gender' AND `meta_value` = 'male'
    GROUP BY `schedule`.`user_id`
) AS `male_counts` ON `users`.`id` = `male_counts`.`user_id`
GROUP BY 
    `users`.`id`
ORDER BY 
    `more_appearances_gender`;


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
    `users`.`position` = 'lecturer' AND `user_metadata`.`meta_value` IN ('female', 'male')
GROUP BY
    `user_metadata`.`meta_value`
ORDER BY
     higher_salary_gender DESC;