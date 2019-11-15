/*
# Adding only one mode to sql_mode without removing existing ones:
SET sql_mode=(SELECT CONCAT(@@sql_mode, ',<mode_to_add>'));
# Example:
SET sql_mode=(SELECT CONCAT(@@sql_mode, ',ONLY_FULL_GROUP_BY'));

# Removing only a specific mode from sql_mode without removing others:
SET sql_mode=(SELECT REPLACE(@@sql_mode,'<mode_to_remove>',''));
# Example:
SET sql_mode=(SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));
*/
