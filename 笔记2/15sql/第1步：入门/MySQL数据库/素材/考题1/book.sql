/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50561
Source Host           : localhost:3306
Source Database       : mysql_exam

Target Server Type    : MYSQL
Target Server Version : 50561
File Encoding         : 65001

Date: 2019-02-16 00:39:48
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book` (
  `bookid` varchar(32) NOT NULL COMMENT '图书ID',
  `bookname` varchar(50) DEFAULT NULL COMMENT '图书名称',
  PRIMARY KEY (`bookid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES ('1001', 'java');
INSERT INTO `book` VALUES ('1002', 'HTML高级');
INSERT INTO `book` VALUES ('1003', 'javaWeb');
INSERT INTO `book` VALUES ('1004', 'Linux内核设计与实现');
INSERT INTO `book` VALUES ('1005', 'Linux系统编程');
INSERT INTO `book` VALUES ('1006', '性能之巅');
INSERT INTO `book` VALUES ('1007', 'TCP/IP详解 卷1:协议');
INSERT INTO `book` VALUES ('1008', 'WireShark网络分析就这么简单');
INSERT INTO `book` VALUES ('1009', '数据结构与算法分析-java语言描述');
INSERT INTO `book` VALUES ('1010', '大型网站技术架构:核心原理与案例分析');
INSERT INTO `book` VALUES ('1011', '微服务设计');
INSERT INTO `book` VALUES ('1012', 'Head First 设计模式');
INSERT INTO `book` VALUES ('1013', 'java并发编程实战');
INSERT INTO `book` VALUES ('1014', '实战Java高并发程序设计');
INSERT INTO `book` VALUES ('1015', 'java8 实战');
INSERT INTO `book` VALUES ('1016', 'java性能权威指南');
INSERT INTO `book` VALUES ('1017', '有效的单元测试');
INSERT INTO `book` VALUES ('1018', '程序员修炼之道-从小工到专家');
INSERT INTO `book` VALUES ('1019', '代码整洁之道');
INSERT INTO `book` VALUES ('1020', '程序员的职业素养');
INSERT INTO `book` VALUES ('1021', '重构');
INSERT INTO `book` VALUES ('1022', '布道之道');
INSERT INTO `book` VALUES ('1023', 'Redis设计与实现分析');
INSERT INTO `book` VALUES ('1024', '分布式服务框架：原理与实践');
