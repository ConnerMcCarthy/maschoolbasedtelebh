SELECT 
    c.fullname AS course,
    DATE_FORMAT(FROM_UNIXTIME(fc.timemodified), '%Y-%m-%d') AS "date",
    MAX(CASE WHEN fi.position = 4 THEN fv.value END) AS "job/role",
    MAX(CASE WHEN fi.position = 5 THEN fv.value END) AS license,
       
    GROUP_CONCAT(CASE WHEN fi.position = 6 THEN fv.value END) AS Q1,
    
    MAX(
    CASE WHEN fi.position = 7 THEN 
        CASE fv.value
            WHEN '1' THEN 'Strongly Agree'
            WHEN '2' THEN 'Agree'
            WHEN '3' THEN 'Neutral'
            WHEN '4' THEN 'Disagree'
            WHEN '5' THEN 'Strongly Disagree'
        END
    END
    ) AS Q2,       

    MAX(
    CASE WHEN fi.position = 8 THEN 
        CASE fv.value
            WHEN '1' THEN 'None'
            WHEN '2' THEN 'A Little'
            WHEN '3' THEN 'Some'
            WHEN '4' THEN 'Quite a Bit'
            WHEN '5' THEN 'A Great Deal'
        END
    END
    ) AS Q3,

    MAX(
    CASE WHEN fi.position = 9 THEN 
        CASE fv.value
            WHEN '1' THEN 'None'
            WHEN '2' THEN 'A Little'
            WHEN '3' THEN 'Some'
            WHEN '4' THEN 'Quite a Bit'
            WHEN '5' THEN 'A Great Deal'
        END
    END
    ) AS Q4,

    MAX(CASE WHEN fi.position = 10 THEN fv.value END) AS Q5,
    MAX(CASE WHEN fi.position = 11 THEN fv.value END) AS Q6,

    MAX(
    CASE WHEN fi.position = 12 THEN 
        CASE fv.value
            WHEN '1' THEN 'Strongly Agree'
            WHEN '2' THEN 'Agree'
            WHEN '3' THEN 'Neutral'
            WHEN '4' THEN 'Disagree'
            WHEN '5' THEN 'Strongly Disagree'
        END
    END
    ) AS Q7,  

     MAX(CASE WHEN fi.position = 13 THEN fv.value END) AS Q8,
     MAX(CASE WHEN fi.position = 14 THEN fv.value END) AS Q9,
     MAX(CASE WHEN fi.position = 15 THEN fv.value END) AS Q10

FROM {feedback_completed} fc
JOIN {feedback} f ON fc.feedback = f.id
JOIN {course} c ON f.course = c.id
JOIN {feedback_item} fi ON fi.feedback = f.id
LEFT JOIN {feedback_value} fv ON fv.item = fi.id AND fv.completed = fc.id

WHERE fc.id > 17
GROUP BY c.fullname, fc.id
ORDER BY fc.id DESC
