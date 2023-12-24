SELECT
  u.id AS user_id,
  u.firstname as first_name,
  u.lastname as last_name,
  u.email,
  DATE_FORMAT(FROM_UNIXTIME(u.timecreated), '%Y-%m-%d') AS date_joined
FROM
  {user} u
