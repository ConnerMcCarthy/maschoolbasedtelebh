SELECT 
    user_info.Role AS "Role",
    u.firstname AS "First Name",
    u.lastname AS "Last Name",
    user_info.LicensingAgency AS "Licensing Agency",
    user_info.LicenseNumber AS "License Number",
    user_info.Phone AS "Phone Number",
    u.email AS "Email Address",
    user_info.HomeAddress AS "Home Address",
    user_info.Cityandstate AS "City, State", 
    user_info.County AS "County",
    user_info.ZIPCode AS "ZIP Code",
    DATE_FORMAT(FROM_UNIXTIME(certificate.timecreated), '%Y-%m-%d %H:%i:%s') AS "Date Completed"

FROM 
    {customcert_issues} AS certificate
    LEFT JOIN {user} AS u ON certificate.userid = u.id
    LEFT JOIN ( 
        SELECT 
            userid,
            MAX(CASE WHEN fieldid = 3 THEN data ELSE NULL END) AS 'County',
            MAX(CASE WHEN fieldid = 4 THEN data ELSE NULL END) AS 'Role',
            MAX(CASE WHEN fieldid = 5 THEN data ELSE NULL END) AS 'LicensingAgency',
            MAX(CASE WHEN fieldid = 6 THEN data ELSE NULL END) AS 'Cityandstate',
            MAX(CASE WHEN fieldid = 7 THEN data ELSE NULL END) AS 'Phone',
            MAX(CASE WHEN fieldid = 8 THEN data ELSE NULL END) AS 'ZIPCode',
            MAX(CASE WHEN fieldid = 10 THEN data ELSE NULL END) AS 'LicenseNumber',
            MAX(CASE WHEN fieldid = 11 THEN data ELSE NULL END) AS 'HomeAddress'
        FROM 
            {user_info_data}
        GROUP BY 
            userid
    ) AS user_info ON user_info.userid = u.id

WHERE
    certificate.customcertid IN (119, 132, 38) -- ID's of certificate to retrive
    AND certificate.timecreated IS NOT NULL 
    AND certificate.userid NOT IN (5499, 5) -- Admin users are removed

    /* On the SQL plugin used, ":" is used to create a custom parameter enetered before the query runs */
    AND certificate.timecreated > :after_this_date 
    AND certificate.timecreated < :before_this_date 
    AND CONCAT(CONCAT(u.firstname," "), u.lastname) LIKE CONCAT( CONCAT('%', :name), '%' )

ORDER BY 
    certificate.timecreated DESC
