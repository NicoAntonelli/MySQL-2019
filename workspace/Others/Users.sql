CREATE USER 'nico'@'localhost'
  IDENTIFIED BY 'nico';
GRANT ALL
  ON net.*
  TO 'nico'@'localhost'
  WITH GRANT OPTION;

# CREATE USER 'nico' IDENTIFIED WITH mysql_native_password BY 'nico';
# DROP USER 'nico';
