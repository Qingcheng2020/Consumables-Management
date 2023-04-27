drop database if exists reagentdb;
drop user if exists 'admin'@'%';
-- 支持emoji:需要mysql数据库参数: character_set_server=utf8mb4
create database reagentdb default character set utf8mb4 collate utf8mb4_unicode_ci;
use reagentdb;
create user 'admin'@'%' identified by 'admin';
grant all privileges on reagentdb.* to 'admin'@'%';
flush privileges;