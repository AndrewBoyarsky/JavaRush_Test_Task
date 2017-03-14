USE test;
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `age` int(10) unsigned NOT NULL,
  `createdDate` datetime NOT NULL,
  `isAdmin` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
INSERT INTO `user` VALUES (1,'Jack',29,'2017-04-19 17:18:16',0),(2,'John',38,'2017-02-24 15:18:59',0),(4,'Jocker',45,'2017-02-24 15:18:59',0),(5,'Name',34,'2017-02-24 15:18:59',1),(9,'3',554,'2017-03-22 10:43:04',0),(11,'Admin',34,'2017-03-14 11:06:10',0),(12,'Cre',23,'2017-03-14 11:06:24',1),(13,'Searcher',20,'2017-03-14 11:30:58',1),(14,'New',43,'2017-03-14 11:09:32',1),(15,'NewMan',23,'2017-03-14 11:09:51',1),(16,'Name',32,'2017-03-14 11:18:35',0),(17,'Ader',21,'2017-03-14 11:18:50',0),(18,'Vorem',54,'2017-03-22 13:20:06',1),(19,'Joshua',34,'2017-03-14 11:23:09',1),(20,'New_User',30,'2017-03-18 16:54:49',0),(21,'J-dog',32,'2017-03-13 17:19:45',1),(22,'My_user',31,'2017-03-29 17:18:18',0),(23,'Uzwer',345,'2017-03-15 00:12:11',0),(24,'Ne',44,'2017-03-15 00:22:46',0);
