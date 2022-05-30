drop database if exists supplies;
drop user if exists 'admin'@'%';
-- 支持emoji：需要mysql数据库参数： character_set_server=utf8mb4
create database supplies default character set utf8mb4 collate utf8mb4_unicode_ci;
use supplies;
create user 'admin'@'%' identified by 'admin';
grant all privileges on supplies.* to 'admin'@'%';
flush privileges;