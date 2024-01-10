-- Selects from the combined table below
-- Allows sorting by both date and a custom sort order
SELECT 
    course_id, 
    course,
    username,
    date_enrolled

FROM (
    
    -- Counts up all enrolled students and displays at the top of the query
    SELECT
         NULL AS course_id, 
         CONCAT( CONCAT('| Total Enrolled: ', COUNT(user_enrolments.userid)), ' |' ) AS course, 
         NULL AS username,
         NULL AS date_enrolled,
         0 AS sort_order
    FROM
        {user_enrolments} user_enrolments
    LEFT JOIN
        {enrol} enrol ON enrol.id = user_enrolments.enrolid

    -- Blank line to seperate the total enrolled line
    UNION ALL
    SELECT 
         NULL AS course_id, 
         NULL AS course, 
         NULL AS username,
         NULL AS date_enrolled,
         1 AS sort_order
    UNION ALL
    
    -- Enrolled students
    SELECT 
        course.id AS course_id,
        course.fullname AS course,
        user.username AS username, 
        DATE_FORMAT(FROM_UNIXTIME(user_enrolments.timecreated), '%Y-%m-%d') AS date_enrolled,
        2 AS sort_order
    
    -- enrol contains course information
    FROM
        {user_enrolments} user_enrolments
    LEFT JOIN
        {enrol} enrol ON enrol.id = user_enrolments.enrolid
    LEFT JOIN 
        {user} user ON user.id = user_enrolments.userid
    LEFT JOIN
        {course} course ON course.id = enrol.courseid

) AS combined_table

ORDER BY 
    sort_order,
    date_enrolled DESC
