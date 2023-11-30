# Select all the users who's names ( f name or l name ) contains letter "a"
SELECT `first_name`, `last_name`
FROM `users`
WHERE `first_name`  LIKE '%a%' OR `last_name` LIKE '%a%';;

# Select all the groups which studies "English"
SELECT `groups`.`name`, `schedule`.`group_id`
FROM `groups`
LEFT JOIN `schedule` ON `groups`.id =`schedule`.group_id
WHERE `subject_id`='22';

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
   `groups`.`id`, `groups`.`name`;
   
/*Select courses. Those courses which have groups which have studies that are taught by Navasardyan and the days of classes are at Monday and Friday.
 Columns to show: Kurs id , kurs name, group name,  group id, the date of the class, and the time of the class*/
SELECT 
    `courses`.`id` AS `course id`,
    `courses`.`name` AS `course name`,
    `groups`.`name`AS `group name`,
    `schedule`.`group_id` AS `group id`,
    `schedule`.`day_of_week` AS `the date of the class`,
    `schedule`.`class_id` AS `the time of the class`
FROM `schedule`
JOIN 
     `courses` ON `courses`.`id` = `schedule`.`course_id` 
JOIN 
     `groups` ON `groups`.`id` = `schedule`.`group_id` 
WHERE `schedule`.`user_id` = '3' AND  `schedule`.`day_of_week` IN ('Monday', 'Friday');
