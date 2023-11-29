# Select all the users who's names ( f name or l name ) contains letter "a"
SELECT `first_name`, `last_name`
FROM `users`
WHERE `first_name` OR `last_name` LIKE '%a%';

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
   