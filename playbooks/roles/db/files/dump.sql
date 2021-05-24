CREATE TABLE IF NOT EXISTS `user_details`(
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(255) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `status` int(10) DEFAULT NULL,
  PRIMARY KEY  (`id`)
)ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=10001 ;

--
-- Dumping data for table `domains`
--

INSERT INTO `user_details` (`id`,`username`,`first_name`,`last_name`,`gender`,`password`,`status`) VALUES 
(1,'roger63','david','john','female','halooedensodk',1),
(2,'miike','rgoers','dit','female','halooewerdinsodk',1),
(3,'river','daved','joishn','male','halodsfiekensodk',1),
(4,'ross','maria','puur','male','halooedieerekensodk',1),
(5,'paul','Fred','wat','male','ererwrew',1),
(6,'m=smith','mark','test','female','df',1),
(7,'james','Geert','data','female','halooeddfsfdik',1),
(8,'daniel','en','voor','female','dd',1),
(10,'mroga','voort','demo','female','halooiekensodk',1);

