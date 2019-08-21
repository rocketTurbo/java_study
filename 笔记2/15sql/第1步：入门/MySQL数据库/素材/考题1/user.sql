/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50561
Source Host           : localhost:3306
Source Database       : mysql_exam

Target Server Type    : MYSQL
Target Server Version : 50561
File Encoding         : 65001

Date: 2019-02-16 00:40:02
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(20) DEFAULT NULL COMMENT '用户名',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `sex` varchar(2) DEFAULT NULL COMMENT '性别',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '周瑜', '20', '男');
INSERT INTO `user` VALUES ('2', '夏侯渊', '18', '男');
INSERT INTO `user` VALUES ('3', '曹仁', '22', '男');
INSERT INTO `user` VALUES ('4', '诸葛亮', '25', '男');
INSERT INTO `user` VALUES ('5', '麋夫人', '19', '女');
INSERT INTO `user` VALUES ('6', '张辽', '23', '男');
INSERT INTO `user` VALUES ('7', '乐进', '24', '男');
INSERT INTO `user` VALUES ('8', '庞德', '26', '男');
INSERT INTO `user` VALUES ('9', '李贵人', '21', '女');
INSERT INTO `user` VALUES ('10', '司马懿', '17', '男');
INSERT INTO `user` VALUES ('11', '赵云', '18', '男');
INSERT INTO `user` VALUES ('12', '黄忠', '26', '男');
INSERT INTO `user` VALUES ('13', '魏延', '27', '男');
INSERT INTO `user` VALUES ('14', '大乔', '26', '女');
INSERT INTO `user` VALUES ('15', '小乔', '23', '女');
INSERT INTO `user` VALUES ('16', '诸葛瞻 ', '22', '男');
INSERT INTO `user` VALUES ('17', '姜维', '21', '男');
INSERT INTO `user` VALUES ('18', '陆逊', '20', '男');
INSERT INTO `user` VALUES ('19', '太史慈', '28', '男');
INSERT INTO `user` VALUES ('20', '黄月英', '24', '女');
INSERT INTO `user` VALUES ('21', '曹操', '26', '男');
