SELECT
  username, first_name, last_name, email
FROM
  users
WHERE
  status = :status
