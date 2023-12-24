SELECT
  c.fullname AS course_name, 
  CONCAT(u.firstname, ' ', u.lastname) as name, 
  u.email as email,
  DATE_FORMAT(FROM_UNIXTIME(ci.timecreated), '%Y-%m-%d') AS date_completed

FROM {customcert_issues} ci
JOIN {customcert} cc ON cc.id = ci.customcertid
JOIN {course} c ON c.id = cc.course
JOIN {user} u ON u.id = ci.userid
ORDER BY date_completed DESC
