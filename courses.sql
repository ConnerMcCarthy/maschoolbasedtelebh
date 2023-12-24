SELECT id, fullname AS course_name
FROM {course}
/* Does not include removed or unavailable courses */
WHERE id NOT IN (1, 18, 19, 20, 21, 22, 23, 24, 25, 26)
