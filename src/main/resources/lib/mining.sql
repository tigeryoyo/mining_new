/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50633
Source Host           : localhost:3306
Source Database       : mining

Target Server Type    : MYSQL
Target Server Version : 50633
File Encoding         : 65001

Date: 2017-06-08 18:16:41
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for core_result
-- ----------------------------
DROP TABLE IF EXISTS `core_result`;
CREATE TABLE `core_result` (
  `core_rid` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `res_name` varchar(512) NOT NULL,
  `std_rid` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '准数据任务的结果id',
  `issue_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `create_time` datetime NOT NULL,
  `creator` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`core_rid`),
  KEY `core_fk_issue_id` (`issue_id`) USING BTREE,
  CONSTRAINT `core_fk_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `issue` (`issue_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of core_result
-- ----------------------------

-- ----------------------------
-- Table structure for file
-- ----------------------------
DROP TABLE IF EXISTS `file`;
CREATE TABLE `file` (
  `file_id` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '文件id',
  `file_name` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '文件名称',
  `source_type` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '数据类型：新闻，微博',
  `size` int(11) NOT NULL COMMENT '文件大小',
  `line_number` int(11) NOT NULL COMMENT '内容行数',
  `issue_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '事件的id',
  `upload_time` datetime NOT NULL COMMENT '上传时间',
  `creator` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '上传人',
  PRIMARY KEY (`file_id`),
  KEY `file_fk_issue_id` (`issue_id`),
  CONSTRAINT `file_fk_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `issue` (`issue_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of file
-- ----------------------------

-- ----------------------------
-- Table structure for issue
-- ----------------------------
DROP TABLE IF EXISTS `issue`;
CREATE TABLE `issue` (
  `issue_id` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '''''' COMMENT '事件id',
  `issue_name` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '''''' COMMENT '事件名称',
  `issue_hold` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '由该任务生成的任务。（eg:泛 hold 准，准 hold 核心）',
  `issue_belong_to` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '该issue属于的issue（eg：准 belong to 泛、核心 belong to 准）',
  `issue_type` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '''''' COMMENT '创建者',
  `last_operator` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '''''' COMMENT '最近一次操作人',
  `last_update_time` datetime NOT NULL COMMENT '最近一次更新时间',
  PRIMARY KEY (`issue_id`),
  KEY `index_name` (`issue_name`),
  KEY `index_creator` (`creator`),
  KEY `index_last_operator` (`last_operator`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of issue
-- ----------------------------

-- ----------------------------
-- Table structure for power
-- ----------------------------
DROP TABLE IF EXISTS `power`;
CREATE TABLE `power` (
  `power_id` int(11) NOT NULL AUTO_INCREMENT,
  `power_name` varchar(255) NOT NULL,
  `power_url` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`power_id`),
  UNIQUE KEY `unique_name` (`power_name`),
  KEY `unique_url` (`power_url`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of power
-- ----------------------------
INSERT INTO `power` VALUES ('1', '查询所有用户', '/user/selectAllUser');
INSERT INTO `power` VALUES ('2', '查询单个用户', '/user/selectOneUserInfo');
INSERT INTO `power` VALUES ('3', '删除用户', '/user/deleteUserInfoById');
INSERT INTO `power` VALUES ('4', '更新用户', '/user/updateUserInfo');
INSERT INTO `power` VALUES ('5', '添加用户', '/user/insertUserInfo');
INSERT INTO `power` VALUES ('6', '统计用户数量', '/user/count');
INSERT INTO `power` VALUES ('7', '查询所有角色', '/role/selectAllRole');
INSERT INTO `power` VALUES ('8', '查询单个角色', '/role/selectOneRoleInfo');
INSERT INTO `power` VALUES ('9', '添加角色', '/role/insertRoleInfo');
INSERT INTO `power` VALUES ('15', '查询单条权限', '/power/selectOnePowerInfo');
INSERT INTO `power` VALUES ('16', '添加权限', '/power/insertPowerInfo');
INSERT INTO `power` VALUES ('17', '删除权限', '/power/deletePowerById');
INSERT INTO `power` VALUES ('18', '更新权限', '/power/updatePowerInfo');
INSERT INTO `power` VALUES ('19', '登录页面跳转', '/topic_list.html');
INSERT INTO `power` VALUES ('20', '错误页面', '/error.html');
INSERT INTO `power` VALUES ('21', '话题页面', '/page/issues.html');
INSERT INTO `power` VALUES ('22', '显示数据页面', '/page/show.jsp');
INSERT INTO `power` VALUES ('23', '下载页面', '/page/upload.html');
INSERT INTO `power` VALUES ('24', '查询自有话题', '/issue/queryOwnIssue');
INSERT INTO `power` VALUES ('25', '查询话题包含的文件', '/file/queryIssueFiles');
INSERT INTO `power` VALUES ('26', '查询修改后统计结果', '/issue/queryModifiedOrigAndCountResult');
INSERT INTO `power` VALUES ('27', '查看修改后的聚类结果', '/issue/queryModifiedClusterResult');
INSERT INTO `power` VALUES ('28', '查看原始统计结果', '/issue/queryOrigAndCountResult');
INSERT INTO `power` VALUES ('29', '查看原始聚类结果', '/issue/queryClusterResult');
INSERT INTO `power` VALUES ('30', '对某个类中的数据进行统计', '/result/statisticSingleSet');
INSERT INTO `power` VALUES ('31', '删除文件', '/file/deleteFileById');
INSERT INTO `power` VALUES ('32', '从聚类结果中删除类', '/result/deleteSets');
INSERT INTO `power` VALUES ('33', '对单文件进行聚类', '/issue/miningSingleFile');
INSERT INTO `power` VALUES ('34', '对文件集合进行聚类', '/issue/miningByFile');
INSERT INTO `power` VALUES ('35', '获取统计结果', '/result/getCountResult');
INSERT INTO `power` VALUES ('36', '合并类', '/result/combineSets');
INSERT INTO `power` VALUES ('37', '获取历史操作结果', '/result/queryResultList');
INSERT INTO `power` VALUES ('38', '重置聚类结果', '/result/resetResultById');
INSERT INTO `power` VALUES ('39', '创建话题', '/issue/create');
INSERT INTO `power` VALUES ('40', '预览文件', '/file/getColumnTitle');
INSERT INTO `power` VALUES ('41', '上传文件', '/file/upload');
INSERT INTO `power` VALUES ('42', '删除话题', '/issue/delete');
INSERT INTO `power` VALUES ('43', '下载结果', '/file/download');
INSERT INTO `power` VALUES ('45', '搜索文件', '/file/searchFileByCon');
INSERT INTO `power` VALUES ('46', '根据时间聚类', '/issue/miningByTime');
INSERT INTO `power` VALUES ('47', '查询所有任务表', '/issue/queryAllIssue');
INSERT INTO `power` VALUES ('48', '话题列表页', '/topic_list.html');
INSERT INTO `power` VALUES ('49', '话题详情页', '/topic_details.html');
INSERT INTO `power` VALUES ('50', '所有话题列表页', '/topic_list_all.html');
INSERT INTO `power` VALUES ('52', '创建话题页', '/create_topic.html');
INSERT INTO `power` VALUES ('54', '数据汇总页', '/summary.html');
INSERT INTO `power` VALUES ('55', '页足', '/g_footer.html');
INSERT INTO `power` VALUES ('56', '页眉', '/g_header.html');
INSERT INTO `power` VALUES ('57', '导航页', '/g_left.html');
INSERT INTO `power` VALUES ('58', '历史记录页', '/history.html');
INSERT INTO `power` VALUES ('59', '添加权限页', '/power_add.html');
INSERT INTO `power` VALUES ('60', '修改权限页', '/power_change.html');
INSERT INTO `power` VALUES ('61', '权限信息页', '/power_infor.html');
INSERT INTO `power` VALUES ('62', '添加角色页', '/role_add.html');
INSERT INTO `power` VALUES ('63', '修改角色页', '/role_change.html');
INSERT INTO `power` VALUES ('64', '角色信息页', '/role_infor.html');
INSERT INTO `power` VALUES ('65', '类型添加页', '/type_add.html');
INSERT INTO `power` VALUES ('66', '类型修改页', '/type_change.html');
INSERT INTO `power` VALUES ('67', '类型信息页', '/type_info.html');
INSERT INTO `power` VALUES ('68', '位置网址页', '/unknow_website_infor.html');
INSERT INTO `power` VALUES ('69', '添加用户页', '/user_add.html');
INSERT INTO `power` VALUES ('70', '修改用户信息页', '/user_change.html');
INSERT INTO `power` VALUES ('71', '用户信息页', '/user_infor.html');
INSERT INTO `power` VALUES ('72', '添加网址页', '/website_add.html');
INSERT INTO `power` VALUES ('73', '修改网址页', '/website_change.html');
INSERT INTO `power` VALUES ('74', '网址信息页', '/website_infor.html');
INSERT INTO `power` VALUES ('75', '添加权重页', '/weight_add.html');
INSERT INTO `power` VALUES ('76', '修改权重页', '/weight_change.html');
INSERT INTO `power` VALUES ('77', '权重信息页', '/weight_infor.html');
INSERT INTO `power` VALUES ('78', '单文件聚类', '/result/miningSingleFile');
INSERT INTO `power` VALUES ('79', '获取当前用户的名称', '/getCurrentUser');
INSERT INTO `power` VALUES ('80', '查询所有任务', '/issue/queryAllIssue');
INSERT INTO `power` VALUES ('81', '查询用户列表', '/user/getUserInfoByPageLimit');
INSERT INTO `power` VALUES ('82', '添加角色权限映射', '/role/insertPowerOfRole');
INSERT INTO `power` VALUES ('83', '删除角色权限映射', '/role/deletePowerOfRole');
INSERT INTO `power` VALUES ('84', '查询角色包含的权限', '/role/includePowersOfRole');
INSERT INTO `power` VALUES ('85', '查询角色不包含的权限', '/role/notIncludePowersOfRole');
INSERT INTO `power` VALUES ('86', '查询用户不包含的角色', '/role/selectNotIncluedRole');
INSERT INTO `power` VALUES ('87', '删除一条历史记录', '/result/delResultById');
INSERT INTO `power` VALUES ('88', '查询所有来源类型', '/sourceType/selectAllSourceType');
INSERT INTO `power` VALUES ('89', '根据来源名称查询', '/sourceType/selectSourceTypeByName');
INSERT INTO `power` VALUES ('90', '删除来源类型', '/sourceType/deleteSourceTypeById');
INSERT INTO `power` VALUES ('91', '添加来源类型', '/sourceType/insertSourceType');
INSERT INTO `power` VALUES ('92', '更新来源类型', '/sourceType/updateSourceType');
INSERT INTO `power` VALUES ('93', '查询所有网址', '/website/selectAllWebsite');
INSERT INTO `power` VALUES ('94', '查询所有未知网址', '/website/selectAllWebsiteUnknow');
INSERT INTO `power` VALUES ('95', '添加网址', '/website/insertWebsite');
INSERT INTO `power` VALUES ('96', '删除网址', '/website/deleteWebsite');
INSERT INTO `power` VALUES ('97', '修改网址信息', '/website/updateWebsite');
INSERT INTO `power` VALUES ('98', '根据条件查询网址', '/website/selectByCondition');
INSERT INTO `power` VALUES ('99', '查询所有权重信息', '/weight/selectAllWeight');
INSERT INTO `power` VALUES ('100', '根据条件查询权重信息', '/weight/selectByCondition');
INSERT INTO `power` VALUES ('101', '添加权重信息', '/weight/insertWeight');
INSERT INTO `power` VALUES ('102', '删除权重信息', '/weight/deleteWeight');
INSERT INTO `power` VALUES ('103', '更新权重信息', '/weight/updateWeight');
INSERT INTO `power` VALUES ('104', '登录', '/login');
INSERT INTO `power` VALUES ('105', '登出', '/logout');
INSERT INTO `power` VALUES ('107', '统计结果页', '/data_results.html');
INSERT INTO `power` VALUES ('108', '类型页', '/type_infor.html');
INSERT INTO `power` VALUES ('109', '查看个人信息', '/personal/getPersonalInfo');
INSERT INTO `power` VALUES ('110', '修改个人信息', '/personal/updatePersonalInfo');
INSERT INTO `power` VALUES ('111', '修改密码', '/personal/updatePassword');
INSERT INTO `power` VALUES ('112', '个人信息页面', '/personal_infor.html');
INSERT INTO `power` VALUES ('113', '修改密码页面', '/password_change.html');
INSERT INTO `power` VALUES ('114', '查询所有权限', '/power/selectAllPower');
INSERT INTO `power` VALUES ('115', '修改角色的权限', '/role/updateRoleInfo');
INSERT INTO `power` VALUES ('116', '删除角色', '/role/deleteRoleInfoById');
INSERT INTO `power` VALUES ('117', '导入映射表', '/website/importMapUrl');
INSERT INTO `power` VALUES ('118', '导出已知url', '/file/downloadKnownUrl');
INSERT INTO `power` VALUES ('120', '导出未知url', '/file/downloadUnKnownUrl');

-- ----------------------------
-- Table structure for result
-- ----------------------------
DROP TABLE IF EXISTS `result`;
CREATE TABLE `result` (
  `rid` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `issue_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `creator` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `create_time` datetime NOT NULL,
  `comment` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`rid`),
  KEY `re_fk_issue_id` (`issue_id`),
  CONSTRAINT `re_fk_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `issue` (`issue_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of result
-- ----------------------------

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `unique_name` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('3', '普通用户');
INSERT INTO `role` VALUES ('2', '管理员');
INSERT INTO `role` VALUES ('1', '超级管理员');

-- ----------------------------
-- Table structure for role_power
-- ----------------------------
DROP TABLE IF EXISTS `role_power`;
CREATE TABLE `role_power` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `power_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_role_id` (`role_id`),
  KEY `index_power_id` (`power_id`),
  CONSTRAINT `rp_fk_power_id` FOREIGN KEY (`power_id`) REFERENCES `power` (`power_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rp_fk_role_id` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=885 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_power
-- ----------------------------
INSERT INTO `role_power` VALUES ('766', '1', '1');
INSERT INTO `role_power` VALUES ('767', '1', '2');
INSERT INTO `role_power` VALUES ('768', '1', '3');
INSERT INTO `role_power` VALUES ('769', '1', '4');
INSERT INTO `role_power` VALUES ('770', '1', '5');
INSERT INTO `role_power` VALUES ('771', '1', '6');
INSERT INTO `role_power` VALUES ('772', '1', '7');
INSERT INTO `role_power` VALUES ('773', '1', '8');
INSERT INTO `role_power` VALUES ('774', '1', '9');
INSERT INTO `role_power` VALUES ('775', '1', '15');
INSERT INTO `role_power` VALUES ('776', '1', '16');
INSERT INTO `role_power` VALUES ('777', '1', '17');
INSERT INTO `role_power` VALUES ('778', '1', '18');
INSERT INTO `role_power` VALUES ('779', '1', '19');
INSERT INTO `role_power` VALUES ('780', '1', '20');
INSERT INTO `role_power` VALUES ('781', '1', '21');
INSERT INTO `role_power` VALUES ('782', '1', '22');
INSERT INTO `role_power` VALUES ('783', '1', '23');
INSERT INTO `role_power` VALUES ('784', '1', '24');
INSERT INTO `role_power` VALUES ('785', '1', '25');
INSERT INTO `role_power` VALUES ('786', '1', '26');
INSERT INTO `role_power` VALUES ('787', '1', '27');
INSERT INTO `role_power` VALUES ('788', '1', '28');
INSERT INTO `role_power` VALUES ('789', '1', '29');
INSERT INTO `role_power` VALUES ('790', '1', '30');
INSERT INTO `role_power` VALUES ('791', '1', '31');
INSERT INTO `role_power` VALUES ('792', '1', '32');
INSERT INTO `role_power` VALUES ('793', '1', '33');
INSERT INTO `role_power` VALUES ('794', '1', '34');
INSERT INTO `role_power` VALUES ('795', '1', '35');
INSERT INTO `role_power` VALUES ('796', '1', '36');
INSERT INTO `role_power` VALUES ('797', '1', '37');
INSERT INTO `role_power` VALUES ('798', '1', '38');
INSERT INTO `role_power` VALUES ('799', '1', '39');
INSERT INTO `role_power` VALUES ('800', '1', '40');
INSERT INTO `role_power` VALUES ('801', '1', '41');
INSERT INTO `role_power` VALUES ('802', '1', '42');
INSERT INTO `role_power` VALUES ('803', '1', '43');
INSERT INTO `role_power` VALUES ('804', '1', '45');
INSERT INTO `role_power` VALUES ('805', '1', '46');
INSERT INTO `role_power` VALUES ('806', '1', '47');
INSERT INTO `role_power` VALUES ('807', '1', '48');
INSERT INTO `role_power` VALUES ('808', '1', '49');
INSERT INTO `role_power` VALUES ('809', '1', '50');
INSERT INTO `role_power` VALUES ('810', '1', '52');
INSERT INTO `role_power` VALUES ('811', '1', '52');
INSERT INTO `role_power` VALUES ('812', '1', '54');
INSERT INTO `role_power` VALUES ('813', '1', '55');
INSERT INTO `role_power` VALUES ('814', '1', '56');
INSERT INTO `role_power` VALUES ('815', '1', '57');
INSERT INTO `role_power` VALUES ('816', '1', '58');
INSERT INTO `role_power` VALUES ('817', '1', '59');
INSERT INTO `role_power` VALUES ('818', '1', '60');
INSERT INTO `role_power` VALUES ('819', '1', '61');
INSERT INTO `role_power` VALUES ('820', '1', '62');
INSERT INTO `role_power` VALUES ('821', '1', '63');
INSERT INTO `role_power` VALUES ('822', '1', '64');
INSERT INTO `role_power` VALUES ('823', '1', '65');
INSERT INTO `role_power` VALUES ('824', '1', '66');
INSERT INTO `role_power` VALUES ('825', '1', '67');
INSERT INTO `role_power` VALUES ('826', '1', '68');
INSERT INTO `role_power` VALUES ('827', '1', '69');
INSERT INTO `role_power` VALUES ('828', '1', '70');
INSERT INTO `role_power` VALUES ('829', '1', '71');
INSERT INTO `role_power` VALUES ('830', '1', '72');
INSERT INTO `role_power` VALUES ('831', '1', '73');
INSERT INTO `role_power` VALUES ('832', '1', '74');
INSERT INTO `role_power` VALUES ('833', '1', '75');
INSERT INTO `role_power` VALUES ('834', '1', '76');
INSERT INTO `role_power` VALUES ('835', '1', '77');
INSERT INTO `role_power` VALUES ('836', '1', '78');
INSERT INTO `role_power` VALUES ('837', '1', '79');
INSERT INTO `role_power` VALUES ('838', '1', '80');
INSERT INTO `role_power` VALUES ('839', '1', '81');
INSERT INTO `role_power` VALUES ('840', '1', '82');
INSERT INTO `role_power` VALUES ('841', '1', '83');
INSERT INTO `role_power` VALUES ('842', '1', '84');
INSERT INTO `role_power` VALUES ('843', '1', '85');
INSERT INTO `role_power` VALUES ('844', '1', '86');
INSERT INTO `role_power` VALUES ('845', '1', '87');
INSERT INTO `role_power` VALUES ('846', '1', '88');
INSERT INTO `role_power` VALUES ('847', '1', '89');
INSERT INTO `role_power` VALUES ('848', '1', '90');
INSERT INTO `role_power` VALUES ('849', '1', '91');
INSERT INTO `role_power` VALUES ('850', '1', '92');
INSERT INTO `role_power` VALUES ('851', '1', '93');
INSERT INTO `role_power` VALUES ('852', '1', '94');
INSERT INTO `role_power` VALUES ('853', '1', '95');
INSERT INTO `role_power` VALUES ('854', '1', '96');
INSERT INTO `role_power` VALUES ('855', '1', '97');
INSERT INTO `role_power` VALUES ('856', '1', '98');
INSERT INTO `role_power` VALUES ('857', '1', '99');
INSERT INTO `role_power` VALUES ('858', '1', '100');
INSERT INTO `role_power` VALUES ('859', '1', '101');
INSERT INTO `role_power` VALUES ('860', '1', '102');
INSERT INTO `role_power` VALUES ('861', '1', '103');
INSERT INTO `role_power` VALUES ('862', '1', '104');
INSERT INTO `role_power` VALUES ('863', '1', '105');
INSERT INTO `role_power` VALUES ('864', '1', '107');
INSERT INTO `role_power` VALUES ('865', '1', '108');
INSERT INTO `role_power` VALUES ('866', '1', '109');
INSERT INTO `role_power` VALUES ('867', '1', '110');
INSERT INTO `role_power` VALUES ('868', '1', '111');
INSERT INTO `role_power` VALUES ('869', '1', '112');
INSERT INTO `role_power` VALUES ('870', '1', '113');
INSERT INTO `role_power` VALUES ('871', '1', '114');
INSERT INTO `role_power` VALUES ('872', '1', '115');
INSERT INTO `role_power` VALUES ('873', '1', '116');
INSERT INTO `role_power` VALUES ('874', '1', '117');
INSERT INTO `role_power` VALUES ('875', '1', '118');
INSERT INTO `role_power` VALUES ('876', '1', '120');
INSERT INTO `role_power` VALUES ('881', '2', '55');
INSERT INTO `role_power` VALUES ('882', '2', '56');
INSERT INTO `role_power` VALUES ('883', '2', '104');
INSERT INTO `role_power` VALUES ('884', '2', '105');

-- ----------------------------
-- Table structure for source_type
-- ----------------------------
DROP TABLE IF EXISTS `source_type`;
CREATE TABLE `source_type` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_bin DEFAULT '''''' COMMENT '类型名称',
  PRIMARY KEY (`id`),
  KEY `index_source_type` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of source_type
-- ----------------------------
INSERT INTO `source_type` VALUES ('1', '微博');
INSERT INTO `source_type` VALUES ('7', '新闻');

-- ----------------------------
-- Table structure for standard_result
-- ----------------------------
DROP TABLE IF EXISTS `standard_result`;
CREATE TABLE `standard_result` (
  `std_rid` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '准数据任务的结果id',
  `res_name` varchar(512) NOT NULL,
  `date_count` varchar(1024) DEFAULT NULL,
  `source_count` varchar(1024) DEFAULT NULL,
  `content_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `issue_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '事件的id',
  `create_time` datetime NOT NULL COMMENT '生成该准数据的时间',
  `creator` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '上传人',
  PRIMARY KEY (`std_rid`),
  KEY `std_fk_issue_id` (`issue_id`) USING BTREE,
  CONSTRAINT `std_fk_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `issue` (`issue_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of standard_result
-- ----------------------------

-- ----------------------------
-- Table structure for stopword
-- ----------------------------
DROP TABLE IF EXISTS `stopword`;
CREATE TABLE `stopword` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(40) NOT NULL DEFAULT '',
  `creator` varchar(32) NOT NULL DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `word` (`word`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of stopword
-- ----------------------------
INSERT INTO `stopword` VALUES ('1', '.', 'chenghu', '2017-06-02 14:40:37');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `email` varchar(32) DEFAULT NULL,
  `telphone` varchar(16) DEFAULT NULL,
  `true_name` varchar(32) NOT NULL,
  `create_date` date NOT NULL,
  `algorithm` int(11) NOT NULL DEFAULT '1',
  `granularity` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `unique_username` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'niannian', 'niannian', 'niannian@qq.com', '18202757049', '念念', '2017-05-12', '1', '1');
INSERT INTO `user` VALUES ('2', 'chenghu', 'chenghu', 'tigeryoyo@qq.com', '15012345678', '程虎', '2017-05-06', '1', '1');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_user_id` (`user_id`),
  KEY `index_role_id` (`role_id`),
  CONSTRAINT `ur_fk_role_id` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ur_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('1', '1', '1');
INSERT INTO `user_role` VALUES ('2', '2', '2');

-- ----------------------------
-- Table structure for website
-- ----------------------------
DROP TABLE IF EXISTS `website`;
CREATE TABLE `website` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '网站URL',
  `name` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '网站名称',
  `level` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '网站级别',
  `type` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '网站类型',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_url` (`url`) USING HASH,
  KEY `index_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='网站信息表';

-- ----------------------------
-- Records of website
-- ----------------------------
INSERT INTO `website` VALUES ('82', 'www.sina.com.cn', '新浪', '其他', '其他');
INSERT INTO `website` VALUES ('84', 'www.nab.com.cn', 'nba中文网', '其他', '省级');
INSERT INTO `website` VALUES ('87', 'www.baidu.com', '其他', '其他', '其他');

-- ----------------------------
-- Table structure for weight
-- ----------------------------
DROP TABLE IF EXISTS `weight`;
CREATE TABLE `weight` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '类型名称',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT '网站权重',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='权重表';

-- ----------------------------
-- Records of weight
-- ----------------------------
INSERT INTO `weight` VALUES ('1', '新闻', '1');
INSERT INTO `weight` VALUES ('2', '报纸', '1');
INSERT INTO `weight` VALUES ('3', '论坛', '20');
INSERT INTO `weight` VALUES ('4', '问答', '1');
INSERT INTO `weight` VALUES ('5', '博客', '5');
INSERT INTO `weight` VALUES ('6', '中央', '100');
INSERT INTO `weight` VALUES ('7', '省级', '20');
INSERT INTO `weight` VALUES ('8', '其他', '1');
INSERT INTO `weight` VALUES ('9', '视频', '4');
INSERT INTO `weight` VALUES ('10', '微博', '1');
INSERT INTO `weight` VALUES ('11', '微信', '5');
INSERT INTO `weight` VALUES ('12', '贴吧', '1');
INSERT INTO `weight` VALUES ('14', '手机', '5');
