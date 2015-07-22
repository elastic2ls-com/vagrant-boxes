create database if not exists owncloud;
create user 'owncloud'@'localhost' identified by 'owncloud';
GRANT ALL ON owncloud.* to 'owncloud'@'localhost' IDENTIFIED BY 'owncloud';
flush privileges;

