/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50633
Source Host           : localhost:3306
Source Database       : mining

Target Server Type    : MYSQL
Target Server Version : 50633
File Encoding         : 65001

Date: 2017-05-15 15:37:38
*/

SET FOREIGN_KEY_CHECKS=0;

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
INSERT INTO `file` VALUES ('8ffc1135-f2c8-4c1c-ba49-47ca4a59d1a0', '娱乐.xlsx', '新闻', '341', '1059', 'c6301655-5a0a-4f16-b446-96b000c82764', '2017-04-25 11:58:33', 'niannian');
INSERT INTO `file` VALUES ('f2142773-a93c-40dd-8cfe-82a3222a3547', '多悦小学 .xlsx', '新闻', '224', '439', 'b74f7111-e0b2-47c9-ac2b-02426781b1d9', '2017-05-13 19:35:45', 'chenghu');

-- ----------------------------
-- Table structure for issue
-- ----------------------------
DROP TABLE IF EXISTS `issue`;
CREATE TABLE `issue` (
  `issue_id` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '''''' COMMENT '事件id',
  `issue_name` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '''''' COMMENT '事件名称',
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
INSERT INTO `issue` VALUES ('b74f7111-e0b2-47c9-ac2b-02426781b1d9', 'ceshi', '2017-05-13 19:35:39', 'chenghu', 'chenghu', '2017-05-15 15:32:59');
INSERT INTO `issue` VALUES ('c6301655-5a0a-4f16-b446-96b000c82764', '娱乐事件', '2017-04-25 11:58:16', 'niannian', 'niannian', '2017-04-25 11:58:35');

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
  `comment` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`rid`),
  KEY `re_fk_issue_id` (`issue_id`),
  CONSTRAINT `re_fk_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `issue` (`issue_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of result
-- ----------------------------
INSERT INTO `result` VALUES ('08597ab5-bd71-40d3-a19e-6fbf4046ae6f', 'b74f7111-e0b2-47c9-ac2b-02426781b1d9', 'chenghu', '2017-05-15 15:32:09', '多悦小学 .xlsx');
INSERT INTO `result` VALUES ('7746dd56-ef0f-4074-b589-07edbf406e5b', 'b74f7111-e0b2-47c9-ac2b-02426781b1d9', 'chenghu', '2017-05-13 19:35:53', '多悦小学 .xlsx');
INSERT INTO `result` VALUES ('b2f8eb10-0fb2-4538-9a17-1b021094b364', 'c6301655-5a0a-4f16-b446-96b000c82764', 'niannian', '2017-04-25 11:58:35', '娱乐.xlsx');
INSERT INTO `result` VALUES ('dbd46bdf-1ba3-439d-b776-d8047f65ae41', 'b74f7111-e0b2-47c9-ac2b-02426781b1d9', 'chenghu', '2017-05-15 15:32:59', '多悦小学 .xlsx');

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
INSERT INTO `role` VALUES ('2', '普通用户');
INSERT INTO `role` VALUES ('3', '游客');
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
) ENGINE=InnoDB AUTO_INCREMENT=727 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_power
-- ----------------------------
INSERT INTO `role_power` VALUES ('385', '2', '19');
INSERT INTO `role_power` VALUES ('386', '2', '20');
INSERT INTO `role_power` VALUES ('387', '2', '55');
INSERT INTO `role_power` VALUES ('388', '2', '56');
INSERT INTO `role_power` VALUES ('389', '2', '57');
INSERT INTO `role_power` VALUES ('390', '2', '109');
INSERT INTO `role_power` VALUES ('391', '2', '110');
INSERT INTO `role_power` VALUES ('392', '2', '111');
INSERT INTO `role_power` VALUES ('393', '2', '112');
INSERT INTO `role_power` VALUES ('394', '2', '113');
INSERT INTO `role_power` VALUES ('395', '2', '79');
INSERT INTO `role_power` VALUES ('616', '1', '1');
INSERT INTO `role_power` VALUES ('617', '1', '2');
INSERT INTO `role_power` VALUES ('618', '1', '3');
INSERT INTO `role_power` VALUES ('619', '1', '4');
INSERT INTO `role_power` VALUES ('620', '1', '5');
INSERT INTO `role_power` VALUES ('621', '1', '6');
INSERT INTO `role_power` VALUES ('622', '1', '7');
INSERT INTO `role_power` VALUES ('623', '1', '8');
INSERT INTO `role_power` VALUES ('624', '1', '9');
INSERT INTO `role_power` VALUES ('625', '1', '15');
INSERT INTO `role_power` VALUES ('626', '1', '16');
INSERT INTO `role_power` VALUES ('627', '1', '17');
INSERT INTO `role_power` VALUES ('628', '1', '18');
INSERT INTO `role_power` VALUES ('629', '1', '19');
INSERT INTO `role_power` VALUES ('630', '1', '20');
INSERT INTO `role_power` VALUES ('631', '1', '21');
INSERT INTO `role_power` VALUES ('632', '1', '22');
INSERT INTO `role_power` VALUES ('633', '1', '23');
INSERT INTO `role_power` VALUES ('634', '1', '24');
INSERT INTO `role_power` VALUES ('635', '1', '25');
INSERT INTO `role_power` VALUES ('636', '1', '26');
INSERT INTO `role_power` VALUES ('637', '1', '27');
INSERT INTO `role_power` VALUES ('638', '1', '28');
INSERT INTO `role_power` VALUES ('639', '1', '29');
INSERT INTO `role_power` VALUES ('640', '1', '30');
INSERT INTO `role_power` VALUES ('641', '1', '31');
INSERT INTO `role_power` VALUES ('642', '1', '32');
INSERT INTO `role_power` VALUES ('643', '1', '33');
INSERT INTO `role_power` VALUES ('644', '1', '34');
INSERT INTO `role_power` VALUES ('645', '1', '35');
INSERT INTO `role_power` VALUES ('646', '1', '36');
INSERT INTO `role_power` VALUES ('647', '1', '37');
INSERT INTO `role_power` VALUES ('648', '1', '38');
INSERT INTO `role_power` VALUES ('649', '1', '39');
INSERT INTO `role_power` VALUES ('650', '1', '40');
INSERT INTO `role_power` VALUES ('651', '1', '41');
INSERT INTO `role_power` VALUES ('652', '1', '42');
INSERT INTO `role_power` VALUES ('653', '1', '43');
INSERT INTO `role_power` VALUES ('654', '1', '45');
INSERT INTO `role_power` VALUES ('655', '1', '46');
INSERT INTO `role_power` VALUES ('656', '1', '47');
INSERT INTO `role_power` VALUES ('657', '1', '48');
INSERT INTO `role_power` VALUES ('658', '1', '49');
INSERT INTO `role_power` VALUES ('659', '1', '50');
INSERT INTO `role_power` VALUES ('660', '1', '52');
INSERT INTO `role_power` VALUES ('661', '1', '52');
INSERT INTO `role_power` VALUES ('662', '1', '54');
INSERT INTO `role_power` VALUES ('663', '1', '55');
INSERT INTO `role_power` VALUES ('664', '1', '56');
INSERT INTO `role_power` VALUES ('665', '1', '57');
INSERT INTO `role_power` VALUES ('666', '1', '58');
INSERT INTO `role_power` VALUES ('667', '1', '59');
INSERT INTO `role_power` VALUES ('668', '1', '60');
INSERT INTO `role_power` VALUES ('669', '1', '61');
INSERT INTO `role_power` VALUES ('670', '1', '62');
INSERT INTO `role_power` VALUES ('671', '1', '63');
INSERT INTO `role_power` VALUES ('672', '1', '64');
INSERT INTO `role_power` VALUES ('673', '1', '65');
INSERT INTO `role_power` VALUES ('674', '1', '66');
INSERT INTO `role_power` VALUES ('675', '1', '67');
INSERT INTO `role_power` VALUES ('676', '1', '68');
INSERT INTO `role_power` VALUES ('677', '1', '69');
INSERT INTO `role_power` VALUES ('678', '1', '70');
INSERT INTO `role_power` VALUES ('679', '1', '71');
INSERT INTO `role_power` VALUES ('680', '1', '72');
INSERT INTO `role_power` VALUES ('681', '1', '73');
INSERT INTO `role_power` VALUES ('682', '1', '74');
INSERT INTO `role_power` VALUES ('683', '1', '75');
INSERT INTO `role_power` VALUES ('684', '1', '76');
INSERT INTO `role_power` VALUES ('685', '1', '77');
INSERT INTO `role_power` VALUES ('686', '1', '78');
INSERT INTO `role_power` VALUES ('687', '1', '79');
INSERT INTO `role_power` VALUES ('688', '1', '80');
INSERT INTO `role_power` VALUES ('689', '1', '81');
INSERT INTO `role_power` VALUES ('690', '1', '82');
INSERT INTO `role_power` VALUES ('691', '1', '83');
INSERT INTO `role_power` VALUES ('692', '1', '84');
INSERT INTO `role_power` VALUES ('693', '1', '85');
INSERT INTO `role_power` VALUES ('694', '1', '86');
INSERT INTO `role_power` VALUES ('695', '1', '87');
INSERT INTO `role_power` VALUES ('696', '1', '88');
INSERT INTO `role_power` VALUES ('697', '1', '89');
INSERT INTO `role_power` VALUES ('698', '1', '90');
INSERT INTO `role_power` VALUES ('699', '1', '91');
INSERT INTO `role_power` VALUES ('700', '1', '92');
INSERT INTO `role_power` VALUES ('701', '1', '93');
INSERT INTO `role_power` VALUES ('702', '1', '94');
INSERT INTO `role_power` VALUES ('703', '1', '95');
INSERT INTO `role_power` VALUES ('704', '1', '96');
INSERT INTO `role_power` VALUES ('705', '1', '97');
INSERT INTO `role_power` VALUES ('706', '1', '98');
INSERT INTO `role_power` VALUES ('707', '1', '99');
INSERT INTO `role_power` VALUES ('708', '1', '100');
INSERT INTO `role_power` VALUES ('709', '1', '101');
INSERT INTO `role_power` VALUES ('710', '1', '102');
INSERT INTO `role_power` VALUES ('711', '1', '103');
INSERT INTO `role_power` VALUES ('712', '1', '104');
INSERT INTO `role_power` VALUES ('713', '1', '105');
INSERT INTO `role_power` VALUES ('714', '1', '107');
INSERT INTO `role_power` VALUES ('715', '1', '108');
INSERT INTO `role_power` VALUES ('716', '1', '109');
INSERT INTO `role_power` VALUES ('717', '1', '110');
INSERT INTO `role_power` VALUES ('718', '1', '111');
INSERT INTO `role_power` VALUES ('719', '1', '112');
INSERT INTO `role_power` VALUES ('720', '1', '113');
INSERT INTO `role_power` VALUES ('721', '1', '114');
INSERT INTO `role_power` VALUES ('722', '1', '115');
INSERT INTO `role_power` VALUES ('723', '1', '116');
INSERT INTO `role_power` VALUES ('724', '1', '117');
INSERT INTO `role_power` VALUES ('725', '1', '118');
INSERT INTO `role_power` VALUES ('726', '1', '120');

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
-- Table structure for stopword
-- ----------------------------
DROP TABLE IF EXISTS `stopword`;
CREATE TABLE `stopword` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(40) NOT NULL DEFAULT '',
  `creator` varchar(32) NOT NULL DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`Id`),
  KEY `word` (`word`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of stopword
-- ----------------------------

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
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `unique_username` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'niannian', 'niannian', 'niannian@qq.com', '18202757049', '念念', '2017-05-12');
INSERT INTO `user` VALUES ('2', 'zhangzz', 'zhangzz', '1074915263@qq.com', '13226081147', '张志钊', '2017-04-25');
INSERT INTO `user` VALUES ('3', 'chenghu', 'chenghu', 'tigeryoyo@qq.com', '15012345678', '程虎', '2017-05-06');
INSERT INTO `user` VALUES ('4', 'tankai', 'aaaaaa', 'tan_kai@qq.com', '17762617656', '谈凯', '2017-05-10');
INSERT INTO `user` VALUES ('6', 'chenjie', 'cccccc', '466413559@qq.com', '18202795813', '陈杰', '2017-05-12');

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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('22', '4', '1');
INSERT INTO `user_role` VALUES ('23', '2', '2');
INSERT INTO `user_role` VALUES ('24', '3', '1');
INSERT INTO `user_role` VALUES ('29', '1', '2');
INSERT INTO `user_role` VALUES ('30', '6', '3');

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
  KEY `index_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=17259 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='网站信息表';

-- ----------------------------
-- Records of website
-- ----------------------------
INSERT INTO `website` VALUES ('16729', 'http://news.qingdaozaixian.com/', '青岛在线', '其他', '新闻');
INSERT INTO `website` VALUES ('16730', 'http://www.wanhoocar.com/', '万户论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16731', 'http://focus.stockstar.com/', '证券之星', '其他', '新闻');
INSERT INTO `website` VALUES ('16732', 'http://www.50902.com/', '邳州城乡论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16733', 'http://tieba.baidu.com/', '百度贴吧四川', '省级', '贴吧');
INSERT INTO `website` VALUES ('16734', 'http://www.wj001.com/', '武进新闻网', '其他', '新闻');
INSERT INTO `website` VALUES ('16735', 'http://finance.591hx.com/', '华讯财经', '其他', '新闻');
INSERT INTO `website` VALUES ('16736', 'http://www.cn1n.com/', '中国在线', '其他', '新闻');
INSERT INTO `website` VALUES ('16737', 'http://news.eastday.com/', '东方网', '其他', '新闻');
INSERT INTO `website` VALUES ('16738', 'http://www.312300.com/', '上虞人论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16739', 'http://bbs.seowhy.com/', '搜外SEO论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16740', 'http://www.x3cn.com/', '香山论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16741', 'http://www.hainei.org/', '海内社区', '中央', '论坛');
INSERT INTO `website` VALUES ('16742', 'http://news.xinmin.cn/', '新民网', '其他', '新闻');
INSERT INTO `website` VALUES ('16743', 'http://life.gmw.cn/', '光明网', '其他', '新闻');
INSERT INTO `website` VALUES ('16744', 'http://www.jmnews.com.cn/', '中国江门网', '其他', '新闻');
INSERT INTO `website` VALUES ('16745', 'http://dzb.jmrb.com:8080/', '江门日报', '其他', '报纸');
INSERT INTO `website` VALUES ('16746', 'http://www.zynews.cc/', '河南头条', '其他', '新闻');
INSERT INTO `website` VALUES ('16747', 'http://www.yn95.com/', '彩云南社区', '其他', '论坛');
INSERT INTO `website` VALUES ('16748', 'http://news.fjsen.com/', '东南网', '其他', '新闻');
INSERT INTO `website` VALUES ('16749', 'http://society.people.com.cn/', '人民网', '其他', '新闻');
INSERT INTO `website` VALUES ('16750', 'http://fj.china.com.cn/', '中国网福建频道', '其他', '新闻');
INSERT INTO `website` VALUES ('16751', 'http://www.yangguwang.com/', '阳谷网', '其他', '新闻');
INSERT INTO `website` VALUES ('16752', 'http://www.xici.net/', '西祠胡同北京', '其他', '论坛');
INSERT INTO `website` VALUES ('16753', 'http://www.hazs09.com/', '淮安之声网论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16754', 'http://www.dumeiwen.com/', '美文阅读网', '其他', '新闻');
INSERT INTO `website` VALUES ('16755', 'http://www.hncyfw.com/', '河南古都网', '其他', '新闻');
INSERT INTO `website` VALUES ('16756', 'http://www.360doc.com/', '360个人图书馆', '中央', '论坛');
INSERT INTO `website` VALUES ('16757', 'http://news.rzw.com.cn/', '日照网', '其他', '新闻');
INSERT INTO `website` VALUES ('16758', 'http://xian.qq.com/', '腾讯大秦网', '其他', '新闻');
INSERT INTO `website` VALUES ('16759', 'http://www.wjdaily.com/', '吴江新闻网', '其他', '新闻');
INSERT INTO `website` VALUES ('16760', 'http://mt.sohu.com/', '搜狐', '其他', '新闻');
INSERT INTO `website` VALUES ('16761', 'http://www.zyjjw.cn/', '中原经济网', '其他', '新闻');
INSERT INTO `website` VALUES ('16762', 'http://news.cutv.com/', '城市联合网络电视台', '其他', '新闻');
INSERT INTO `website` VALUES ('16763', 'http://yn.people.com.cn/', '人民网云南频道', '其他', '新闻');
INSERT INTO `website` VALUES ('16764', 'http://news.tom.com/', 'TOM', '其他', '新闻');
INSERT INTO `website` VALUES ('16765', 'http://news.2500sz.com/', '名城苏州', '其他', '新闻');
INSERT INTO `website` VALUES ('16766', 'http://society.nen.com.cn/', '东北新闻网', '其他', '新闻');
INSERT INTO `website` VALUES ('16767', 'http://bbs.wst.cn/', '二泉论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16768', 'http://www.sanjin.tv/', '三晋论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16769', 'http://www.xinwenshoufa.com/', '新闻首发网', '其他', '新闻');
INSERT INTO `website` VALUES ('16770', 'http://jl.sina.com.cn/', '新浪吉林', '其他', '新闻');
INSERT INTO `website` VALUES ('16771', 'http://www.tz365.cn/', '滕州生活网', '其他', '新闻');
INSERT INTO `website` VALUES ('16772', 'http://cz.sxgov.cn/', '黄河新闻网长治频道', '其他', '新闻');
INSERT INTO `website` VALUES ('16773', 'http://bbs.lohjs.com/', '南京论坛乐活社区', '其他', '论坛');
INSERT INTO `website` VALUES ('16774', 'http://news.gscn.com.cn/', '中国甘肃网', '其他', '新闻');
INSERT INTO `website` VALUES ('16775', 'http://jx.people.com.cn/', '人民网江西频道', '其他', '新闻');
INSERT INTO `website` VALUES ('16776', 'http://sh.people.com.cn/', '人民网上海频道', '其他', '新闻');
INSERT INTO `website` VALUES ('16777', 'http://www.0518.biz/', '连云港金融网', '其他', '新闻');
INSERT INTO `website` VALUES ('16778', 'http://media.china.com.cn/', '传媒经济', '其他', '新闻');
INSERT INTO `website` VALUES ('16779', 'http://jiangsu.china.com.cn/', '中国网江苏频道', '其他', '新闻');
INSERT INTO `website` VALUES ('16780', 'http://news.gmw.cn/', '光明网', '其他', '新闻');
INSERT INTO `website` VALUES ('16781', 'http://sd.china.com.cn/', '中国网山东频道', '其他', '新闻');
INSERT INTO `website` VALUES ('16782', 'http://news.enorth.com.cn/', '北方网', '其他', '新闻');
INSERT INTO `website` VALUES ('16783', 'http://news.xiangw.com/', '襄阳网', '其他', '新闻');
INSERT INTO `website` VALUES ('16784', 'http://www.laguaba.com/', '邳州啦呱社区', '其他', '论坛');
INSERT INTO `website` VALUES ('16785', 'http://zibo.dzwww.com/', '淄博大众网', '其他', '新闻');
INSERT INTO `website` VALUES ('16786', 'http://bbs.qianlong.com/', '京华论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16787', 'http://www.ijxxs.com/', '修水同城网', '其他', '新闻');
INSERT INTO `website` VALUES ('16788', 'http://bbs.sz.zj.cn/', '江南社区', '其他', '论坛');
INSERT INTO `website` VALUES ('16789', 'http://www.sctv.com/', '四川广播电视台', '其他', '新闻');
INSERT INTO `website` VALUES ('16790', 'http://ngdsb.hinews.cn/', '南国都市报', '其他', '报纸');
INSERT INTO `website` VALUES ('16791', 'http://wenda.bsuc.cc/', '红岸网', '其他', '新闻');
INSERT INTO `website` VALUES ('16792', 'http://news.bsuc.cc/', '红岸网', '其他', '新闻');
INSERT INTO `website` VALUES ('16793', 'http://roll.sohu.com/', '搜狐', '其他', '新闻');
INSERT INTO `website` VALUES ('16794', 'http://edu.163.com/', '网易', '其他', '新闻');
INSERT INTO `website` VALUES ('16795', 'http://news.qingdaonews.com/', '青岛新闻网', '其他', '新闻');
INSERT INTO `website` VALUES ('16796', 'http://news.cdyee.com/', '尚一网', '其他', '新闻');
INSERT INTO `website` VALUES ('16797', 'http://www.citygf.com/', '广佛都市网', '其他', '新闻');
INSERT INTO `website` VALUES ('16798', 'http://xy.ishaanxi.com/', '陕西综合门户网', '其他', '新闻');
INSERT INTO `website` VALUES ('16799', 'http://sinanews.sina.cn/', '新浪新闻客户端', '其他', '博客');
INSERT INTO `website` VALUES ('16800', 'http://jiangsu.sina.cn/', '手机新浪网', '其他', '手机');
INSERT INTO `website` VALUES ('16801', 'http://jiangsu.sina.com.cn/', '新浪江苏', '其他', '新闻');
INSERT INTO `website` VALUES ('16802', 'http://fj.people.com.cn/', '人民网福建频道', '其他', '新闻');
INSERT INTO `website` VALUES ('16803', 'http://linyi.dzwww.com/', '大众网', '其他', '新闻');
INSERT INTO `website` VALUES ('16804', 'http://bbs.bztdxxl.com/', '中国企业员工互动论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16805', 'http://www.jiaodong.net/', '胶东在线', '其他', '新闻');
INSERT INTO `website` VALUES ('16806', 'http://www.cnqiang.com/', 'CHN强国网', '其他', '新闻');
INSERT INTO `website` VALUES ('16807', 'http://health.jschina.com.cn/', '中国江苏网', '其他', '新闻');
INSERT INTO `website` VALUES ('16808', 'http://www.ahrtv.cn/', '安徽网络广播电台', '其他', '新闻');
INSERT INTO `website` VALUES ('16809', 'http://region.scdaily.cn/', '四川日报网', '其他', '报纸');
INSERT INTO `website` VALUES ('16810', 'http://m.people.cn/', '手机人民网', '其他', '手机');
INSERT INTO `website` VALUES ('16811', 'http://www.zibosky.com/', '淄博时空', '其他', '新闻');
INSERT INTO `website` VALUES ('16812', 'http://sc.people.com.cn/', '人民网四川频道', '其他', '新闻');
INSERT INTO `website` VALUES ('16813', 'http://www.ktx.cn/', 'vista看天下', '其他', '新闻');
INSERT INTO `website` VALUES ('16814', 'http://news.jinghua.cn/', '京华网', '其他', '新闻');
INSERT INTO `website` VALUES ('16815', 'http://www.lzbd.com/', '临淄佰渡信息网', '其他', '新闻');
INSERT INTO `website` VALUES ('16816', 'http://china.qianlong.com/', '千龙网', '其他', '新闻');
INSERT INTO `website` VALUES ('16817', 'http://news.dahe.cn/', '大河网', '其他', '新闻');
INSERT INTO `website` VALUES ('16818', 'http://news.china.com/', '中华网', '其他', '新闻');
INSERT INTO `website` VALUES ('16819', 'http://news.gxtv.cn/', '广西电视网', '其他', '新闻');
INSERT INTO `website` VALUES ('16820', 'http://news.qtv.com.cn/', '青岛网络电视台', '其他', '新闻');
INSERT INTO `website` VALUES ('16821', 'http://news.jschina.com.cn/', '中国江苏网', '其他', '新闻');
INSERT INTO `website` VALUES ('16822', 'http://www.tibet.cn/', '中国西藏网', '其他', '新闻');
INSERT INTO `website` VALUES ('16823', 'http://www.gdyfs.com/', '云浮在线', '其他', '新闻');
INSERT INTO `website` VALUES ('16824', 'http://www.cqyy.net/', '幸福云阳网', '其他', '新闻');
INSERT INTO `website` VALUES ('16825', 'http://news.scol.com.cn/', '四川在线', '其他', '新闻');
INSERT INTO `website` VALUES ('16826', 'http://inews.ifeng.com/', '手机凤凰网', '其他', '手机');
INSERT INTO `website` VALUES ('16827', 'http://www.chinanews.com/', '手机中新网', '其他', '其他');
INSERT INTO `website` VALUES ('16828', 'http://news.wuxi.cn/', '阿福台网', '其他', '新闻');
INSERT INTO `website` VALUES ('16829', 'http://www.gywb.cn/', '贵阳新闻网', '其他', '新闻');
INSERT INTO `website` VALUES ('16830', 'http://news.onlinejx.net/', '江西热线', '其他', '新闻');
INSERT INTO `website` VALUES ('16831', 'http://news.sohu.com/', '搜狐', '其他', '新闻');
INSERT INTO `website` VALUES ('16832', 'http://news.163.com/', '网易', '其他', '新闻');
INSERT INTO `website` VALUES ('16833', 'http://3g.163.com/', '手机网易网', '其他', '手机');
INSERT INTO `website` VALUES ('16834', 'http://epaper.jinghua.cn/', '京华时报', '其他', '报纸');
INSERT INTO `website` VALUES ('16835', 'http://www.kangai8.com/', '汉唐军事', '其他', '新闻');
INSERT INTO `website` VALUES ('16836', 'http://www.qn0854.com/', '黔南论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16837', 'http://www.lieqi.com/', '猎奇网', '其他', '新闻');
INSERT INTO `website` VALUES ('16838', 'http://www.19lou.com/', '杭州19楼', '其他', '论坛');
INSERT INTO `website` VALUES ('16839', 'http://learning.sohu.com/', '搜狐', '其他', '新闻');
INSERT INTO `website` VALUES ('16840', 'http://www.morningpost.com.cn/', '北京晨报网', '其他', '新闻');
INSERT INTO `website` VALUES ('16841', 'http://top.todayonhistory.com/', '历史上的今天', '其他', '新闻');
INSERT INTO `website` VALUES ('16842', 'http://stock.591hx.com/', '华讯财经', '其他', '新闻');
INSERT INTO `website` VALUES ('16843', 'http://he.people.com.cn/', '人民网河北频道', '其他', '新闻');
INSERT INTO `website` VALUES ('16844', 'http://www.bjnew.net/', '北京在线', '其他', '新闻');
INSERT INTO `website` VALUES ('16845', 'http://www.chinareports.org.cn/', '中国报道网', '其他', '新闻');
INSERT INTO `website` VALUES ('16846', 'http://bbs.wj001.com/', '武进论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16847', 'http://www.njdaily.cn/', '南报网', '其他', '新闻');
INSERT INTO `website` VALUES ('16848', 'http://cul.china.com.cn/', '文化中国', '其他', '新闻');
INSERT INTO `website` VALUES ('16849', 'http://w.545600.com/', '鹿寨都市论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16850', 'http://dezhou.news.163.com/', '网易德州', '其他', '新闻');
INSERT INTO `website` VALUES ('16851', 'http://news.zhuhai.gd.cn/', '珠海视窗', '其他', '新闻');
INSERT INTO `website` VALUES ('16852', 'http://www.lygnews.com.cn/', '连云港新闻网', '其他', '新闻');
INSERT INTO `website` VALUES ('16853', 'http://www.xuanen.ccoo.cn/', '宣恩在线论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16854', 'http://society.ynet.com/', '北青网', '其他', '新闻');
INSERT INTO `website` VALUES ('16855', 'http://news.ynet.com/', '北青网', '其他', '新闻');
INSERT INTO `website` VALUES ('16856', 'http://www.sznews.com/', '深圳新闻网', '其他', '新闻');
INSERT INTO `website` VALUES ('16857', 'http://www.xuyi365.net/', '盱眙365论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16858', 'http://www.cnhuadong.net/', '华东在线', '其他', '新闻');
INSERT INTO `website` VALUES ('16859', 'http://www.bjnews.com.cn/', '新京报网', '其他', '视频');
INSERT INTO `website` VALUES ('16860', 'http://www.jjntv.cn/', '九江视听网', '其他', '新闻');
INSERT INTO `website` VALUES ('16861', 'http://bbs.xishu365.com/', '西蜀论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16862', 'http://www.hxnews.com/', '海峡都市网', '其他', '新闻');
INSERT INTO `website` VALUES ('16863', 'http://news.sina.com.cn/', '新浪', '其他', '新闻');
INSERT INTO `website` VALUES ('16864', 'http://news.haiwainet.cn/', '海外网', '其他', '新闻');
INSERT INTO `website` VALUES ('16865', 'http://www.zgmszk.cn/', '中国民生周刊网', '其他', '新闻');
INSERT INTO `website` VALUES ('16866', 'http://news.sun0769.com/', '东莞阳光网', '其他', '新闻');
INSERT INTO `website` VALUES ('16867', 'http://www.la-bbs.net/', '六安论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16868', 'http://news.asean168.com/', '东盟网', '其他', '新闻');
INSERT INTO `website` VALUES ('16869', 'http://fazhi.yunnan.cn/', '云南网', '其他', '新闻');
INSERT INTO `website` VALUES ('16870', 'http://news.cri.cn/', '国际在线', '其他', '新闻');
INSERT INTO `website` VALUES ('16871', 'http://www.mala.cn/', '麻辣社区', '其他', '论坛');
INSERT INTO `website` VALUES ('16872', 'http://bbs.scol.com.cn/', '四川在线天府论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16873', 'http://szbbs.sznews.com/', '深圳新闻论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16874', 'http://ll.sxgov.cn/', '黄河新闻网吕梁频道', '其他', '新闻');
INSERT INTO `website` VALUES ('16875', 'http://www.whnews.cn/', '威海新闻网', '其他', '新闻');
INSERT INTO `website` VALUES ('16876', 'http://jl.sina.cn/', '手机新浪网', '其他', '手机');
INSERT INTO `website` VALUES ('16877', 'http://news.cnnb.com.cn/', '中国宁波网', '其他', '新闻');
INSERT INTO `website` VALUES ('16878', 'http://sx.sina.com.cn/', '新浪陕西', '其他', '新闻');
INSERT INTO `website` VALUES ('16879', 'http://henan.youth.cn/', '中国青年网河南频道', '其他', '新闻');
INSERT INTO `website` VALUES ('16880', 'http://www.hualongxiang.com/', '化龙巷论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16881', 'http://edu.qianlong.com/', '千龙网', '其他', '新闻');
INSERT INTO `website` VALUES ('16882', 'http://news.zynews.com/', '中原网', '其他', '新闻');
INSERT INTO `website` VALUES ('16883', 'http://www.cwyan.com/', '微言论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16884', 'http://news.cn.chinagate.cn/', '中国发展门户网', '其他', '新闻');
INSERT INTO `website` VALUES ('16885', 'http://news.china.com.cn/', '中国网', '其他', '新闻');
INSERT INTO `website` VALUES ('16886', 'http://www.fytv.com.cn/', '阜阳公众网', '其他', '新闻');
INSERT INTO `website` VALUES ('16887', 'http://www.nt.cc/', '南通热线论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16888', 'http://mp.weixin.qq.com/', '微信', '其他', '微信');
INSERT INTO `website` VALUES ('16889', 'http://www.isen.so/', '艾森网', '其他', '新闻');
INSERT INTO `website` VALUES ('16890', 'http://www.dzwww.com/', '大众网', '其他', '新闻');
INSERT INTO `website` VALUES ('16891', 'http://www.jiaozuo.ccoo.cn/', '焦作城市在线', '其他', '新闻');
INSERT INTO `website` VALUES ('16892', 'http://picture.youth.cn/', '中国青年网', '其他', '新闻');
INSERT INTO `website` VALUES ('16893', 'http://cd.qq.com/', '腾讯大成网', '其他', '新闻');
INSERT INTO `website` VALUES ('16894', 'http://news.cnr.cn/', '央广网', '其他', '新闻');
INSERT INTO `website` VALUES ('16895', 'http://msn.ynet.com/', 'MSN中文网', '其他', '问答');
INSERT INTO `website` VALUES ('16896', 'http://law.southcn.com/', '南方网', '其他', '新闻');
INSERT INTO `website` VALUES ('16897', 'http://news.xinhuanet.com/', '新华网', '其他', '新闻');
INSERT INTO `website` VALUES ('16898', 'http://photo.ishaanxi.com/', '陕西综合门户网', '其他', '新闻');
INSERT INTO `website` VALUES ('16899', 'http://www.slit.cn/', '胜利社区', '其他', '论坛');
INSERT INTO `website` VALUES ('16900', 'http://news.qq.com/', '腾讯', '其他', '新闻');
INSERT INTO `website` VALUES ('16901', 'http://info.3g.qq.com/', '手机腾讯网', '其他', '手机');
INSERT INTO `website` VALUES ('16902', 'http://locnews.gztv.com/', '广州电视台', '其他', '新闻');
INSERT INTO `website` VALUES ('16903', 'http://zy.takungpao.com/', '大公中原新闻网', '其他', '新闻');
INSERT INTO `website` VALUES ('16904', 'http://toutiao.com/', '今日头条', '其他', '新闻');
INSERT INTO `website` VALUES ('16905', 'http://www.sgnet.cc/', '中国寿光网', '其他', '新闻');
INSERT INTO `website` VALUES ('16906', 'http://www.googcc.com.cn/', '千寻论文网', '其他', '新闻');
INSERT INTO `website` VALUES ('16907', 'http://news.jnwb.net/', '江南晚报网', '其他', '新闻');
INSERT INTO `website` VALUES ('16908', 'http://new.qi-che.com/', '汽车中国网', '其他', '新闻');
INSERT INTO `website` VALUES ('16909', 'http://club.kdnet.net/', '凯迪社区', '其他', '论坛');
INSERT INTO `website` VALUES ('16910', 'http://www.nhxxg.com/', '宁海网', '其他', '新闻');
INSERT INTO `website` VALUES ('16911', 'http://www.jdbbs.com/', '家电论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16912', 'http://www.jd-bbs.com/', '家电论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16913', 'http://news.jxnews.com.cn/', '大江网九江频道', '其他', '新闻');
INSERT INTO `website` VALUES ('16914', 'http://www.cnwomen.com.cn/', '中国女性网', '其他', '新闻');
INSERT INTO `website` VALUES ('16915', 'http://bbs.meishanren.com/', '眉山人网', '其他', '论坛');
INSERT INTO `website` VALUES ('16916', 'http://www.7quw.com/', '戚区论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16917', 'http://edu.china.com/', '中华网', '其他', '新闻');
INSERT INTO `website` VALUES ('16918', 'http://news.iyaxin.com/', '亚心网', '其他', '新闻');
INSERT INTO `website` VALUES ('16919', 'http://club.china.com/', '中华网社区', '其他', '论坛');
INSERT INTO `website` VALUES ('16920', 'http://bbs.bato.cn/', '八通社区', '其他', '论坛');
INSERT INTO `website` VALUES ('16921', 'http://www.huaxunwang.com.cn/', '华讯网', '其他', '新闻');
INSERT INTO `website` VALUES ('16922', 'http://www.ln19.com/', '园洲社区', '其他', '论坛');
INSERT INTO `website` VALUES ('16923', 'http://henan.163.com/', '网易河南', '其他', '新闻');
INSERT INTO `website` VALUES ('16924', 'http://www.81ce.com/', '八一军事', '其他', '新闻');
INSERT INTO `website` VALUES ('16925', 'http://www.chinavalue.net/', '价值中国网', '其他', '新闻');
INSERT INTO `website` VALUES ('16926', 'http://www.iqiyi.com/', '爱奇艺', '其他', '视频');
INSERT INTO `website` VALUES ('16927', 'http://www.taiwan.cn/', '中国台湾网', '其他', '新闻');
INSERT INTO `website` VALUES ('16928', 'http://www.aihami.com/', '楚秀网', '其他', '新闻');
INSERT INTO `website` VALUES ('16929', 'http://news.yyrtv.com/', '益阳广播电视在线', '其他', '新闻');
INSERT INTO `website` VALUES ('16930', 'http://bbs.gz0668.com/', '高州阳光论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16931', 'http://peterlin88888888.blogchina.com/', '博客中国', '其他', '博客');
INSERT INTO `website` VALUES ('16932', 'http://bbs.enorth.com.cn/', '北方论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16933', 'http://news.ifeng.com/', '凤凰网', '其他', '新闻');
INSERT INTO `website` VALUES ('16934', 'http://edu.dbw.cn/', '东北网', '其他', '新闻');
INSERT INTO `website` VALUES ('16935', 'http://news.youth.cn/', '中国青年网', '其他', '新闻');
INSERT INTO `website` VALUES ('16936', 'http://www.mnw.cn/', '闽南网', '其他', '新闻');
INSERT INTO `website` VALUES ('16937', 'http://news.voc.com.cn/', '华声在线', '其他', '新闻');
INSERT INTO `website` VALUES ('16938', 'http://www.funuo.com/', '富诺财经网', '其他', '新闻');
INSERT INTO `website` VALUES ('16939', 'http://club.autohome.com.cn/', '汽车之家论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16940', 'http://shanxi.sina.com.cn/', '新浪山西', '其他', '新闻');
INSERT INTO `website` VALUES ('16941', 'http://www.0731o.cn/', '长沙家园网', '其他', '新闻');
INSERT INTO `website` VALUES ('16942', 'http://www.qdcaijing.com/', '青岛财经网', '其他', '新闻');
INSERT INTO `website` VALUES ('16943', 'http://www.xcar.com.cn/', '爱卡社区', '其他', '论坛');
INSERT INTO `website` VALUES ('16944', 'http://news.sq1996.com/', '宿迁新闻网', '其他', '新闻');
INSERT INTO `website` VALUES ('16945', 'http://www.jynews.net/', '揭阳新闻网', '其他', '新闻');
INSERT INTO `website` VALUES ('16946', 'http://news.k618.cn/', '未来网', '其他', '新闻');
INSERT INTO `website` VALUES ('16947', 'http://www.hq0564.com/', '霍邱论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16948', 'http://gx.people.com.cn/', '人民网广西频道', '其他', '新闻');
INSERT INTO `website` VALUES ('16949', 'http://edu.sina.com.cn/', '新浪', '其他', '新闻');
INSERT INTO `website` VALUES ('16950', 'http://edu.sina.cn/', '手机新浪网', '其他', '手机');
INSERT INTO `website` VALUES ('16951', 'http://shanxi.youth.cn/', '中国青年网山西频道', '其他', '新闻');
INSERT INTO `website` VALUES ('16952', 'http://slide.jl.sina.com.cn/', '新浪吉林', '其他', '新闻');
INSERT INTO `website` VALUES ('16953', 'http://news.365jilin.com/', '吉和网', '其他', '新闻');
INSERT INTO `website` VALUES ('16954', 'http://www.23xfw.com/', '襄阳信息论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16955', 'http://news.m4.cn/', '四月网', '其他', '新闻');
INSERT INTO `website` VALUES ('16956', 'http://www.81lj.com/', '八一亮剑论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16957', 'http://sd.china.com/', '中华网山东频道', '其他', '新闻');
INSERT INTO `website` VALUES ('16958', 'http://www.81.net/', '八一军事网', '其他', '新闻');
INSERT INTO `website` VALUES ('16959', 'http://news.szhk.com/', '深港在线', '其他', '新闻');
INSERT INTO `website` VALUES ('16960', 'http://bbs.139life.com/', '苏州生活网论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16961', 'http://news.subaonet.com/', '苏州新闻网', '其他', '新闻');
INSERT INTO `website` VALUES ('16962', 'http://news.yntv.cn/', '云视网', '其他', '新闻');
INSERT INTO `website` VALUES ('16963', 'http://fzzx.gansudaily.com.cn/', '每日甘肃网', '其他', '新闻');
INSERT INTO `website` VALUES ('16964', 'http://news.xhby.net/', '新华报业网', '其他', '新闻');
INSERT INTO `website` VALUES ('16965', 'http://www.ckdzb.com/', '参考之家', '其他', '新闻');
INSERT INTO `website` VALUES ('16966', 'http://info.whinfo.net.cn/', '威海信息港', '其他', '新闻');
INSERT INTO `website` VALUES ('16967', 'http://society.stnn.cc/', '星岛环球网', '其他', '新闻');
INSERT INTO `website` VALUES ('16968', 'http://forum.chinaso.com/', '国搜社区', '其他', '论坛');
INSERT INTO `website` VALUES ('16969', 'http://club.news.sohu.com/', '搜狐论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16970', 'http://www.seezy.com/', '遵义万维网', '其他', '新闻');
INSERT INTO `website` VALUES ('16971', 'http://club.qingdaonews.com/', '青青岛论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16972', 'http://www.fynews.com.cn/', '富阳网新闻网', '其他', '新闻');
INSERT INTO `website` VALUES ('16973', 'http://hebei.news.163.com/', '网易河北', '其他', '新闻');
INSERT INTO `website` VALUES ('16974', 'http://www.zzbtv.com/', '株洲传媒网', '其他', '新闻');
INSERT INTO `website` VALUES ('16975', 'http://www.hdzc.net/', '邯郸之窗', '其他', '新闻');
INSERT INTO `website` VALUES ('16976', 'http://js.scxxb.com.cn/', '市场信息报-江苏视窗', '其他', '新闻');
INSERT INTO `website` VALUES ('16977', 'http://www.mdmmm.com/', '大茂名论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16978', 'http://www.gd.xinhuanet.com/', '新华广东', '其他', '新闻');
INSERT INTO `website` VALUES ('16979', 'http://baby.sina.com.cn/', '新浪', '其他', '新闻');
INSERT INTO `website` VALUES ('16980', 'http://baby.sina.cn/', '手机新浪网', '其他', '手机');
INSERT INTO `website` VALUES ('16981', 'http://hebei.sina.com.cn/', '新浪河北', '其他', '新闻');
INSERT INTO `website` VALUES ('16982', 'http://www.gs.xinhuanet.com/', '新华甘肃', '其他', '新闻');
INSERT INTO `website` VALUES ('16983', 'http://www.henan100.com/', '河南百度', '其他', '新闻');
INSERT INTO `website` VALUES ('16984', 'http://guoqing.china.com.cn/', '中国网中国国情', '其他', '新闻');
INSERT INTO `website` VALUES ('16985', 'http://www.cnncw.cn/', '南充新闻网', '其他', '新闻');
INSERT INTO `website` VALUES ('16986', 'http://www.0597kk.com/', '龙岩kk社区', '其他', '论坛');
INSERT INTO `website` VALUES ('16987', 'http://internal.dbw.cn/', '东北网', '其他', '新闻');
INSERT INTO `website` VALUES ('16988', 'http://www.sdenews.com/', '山东财经网', '其他', '新闻');
INSERT INTO `website` VALUES ('16989', 'http://www.gznet.com/', '广州视窗', '其他', '新闻');
INSERT INTO `website` VALUES ('16990', 'http://www.jnnews.tv/', '山东济宁新闻网', '其他', '新闻');
INSERT INTO `website` VALUES ('16991', 'http://www.jiangyanwang.cn/', '姜堰网论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('16992', 'http://www.ntjoy.com/', '江海明珠网', '其他', '新闻');
INSERT INTO `website` VALUES ('16993', 'http://news.asxxg.cn/', '鞍山信息港', '其他', '新闻');
INSERT INTO `website` VALUES ('16994', 'http://dl.sina.com.cn/', '新浪大连', '其他', '新闻');
INSERT INTO `website` VALUES ('16995', 'http://dl.sina.cn/', '手机新浪网', '其他', '手机');
INSERT INTO `website` VALUES ('16996', 'http://pic.people.com.cn/', '人民网', '其他', '新闻');
INSERT INTO `website` VALUES ('16997', 'http://news.guilinlife.com/', '桂林生活网', '其他', '新闻');
INSERT INTO `website` VALUES ('16998', 'http://ah.people.com.cn/', '人民网安徽频道', '其他', '新闻');
INSERT INTO `website` VALUES ('16999', 'http://www.wpji.cn/', '万朋集论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17000', 'http://www.88148.com/', '律法网', '其他', '新闻');
INSERT INTO `website` VALUES ('17001', 'http://fxb.591hx.com/', '华讯财经', '其他', '新闻');
INSERT INTO `website` VALUES ('17002', 'http://edu.ce.cn/', '中国经济网', '其他', '新闻');
INSERT INTO `website` VALUES ('17003', 'http://health.lyd.com.cn/', '洛阳网', '其他', '新闻');
INSERT INTO `website` VALUES ('17004', 'http://life.jschina.com.cn/', '中国江苏网', '其他', '新闻');
INSERT INTO `website` VALUES ('17005', 'http://www.szwmw.cn/', '随州文明网论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17006', 'http://www.ncnews.com.cn/', '南昌天园网', '其他', '新闻');
INSERT INTO `website` VALUES ('17007', 'http://news.e23.cn/', '舜网', '其他', '新闻');
INSERT INTO `website` VALUES ('17008', 'http://gongyi.ifeng.com/', '凤凰网', '其他', '新闻');
INSERT INTO `website` VALUES ('17009', 'http://weifang.dzwww.com/', '潍坊大众网', '其他', '新闻');
INSERT INTO `website` VALUES ('17010', 'http://www.ln.chinanews.com/', '中新网辽宁频道', '其他', '新闻');
INSERT INTO `website` VALUES ('17011', 'http://bbs.qianhuaweb.com/', '千华社区', '其他', '论坛');
INSERT INTO `website` VALUES ('17012', 'http://society.yunnan.cn/', '云南网', '其他', '新闻');
INSERT INTO `website` VALUES ('17013', 'http://news.hexun.com/', '和讯', '其他', '新闻');
INSERT INTO `website` VALUES ('17014', 'http://health.huanqiu.com/', '环球网', '其他', '新闻');
INSERT INTO `website` VALUES ('17015', 'http://www.ijiangyin.com/', '大澄网', '其他', '新闻');
INSERT INTO `website` VALUES ('17016', 'http://bbs.hefei.cc/', '合肥论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17017', 'http://www.huizhou.cn/', '今日惠州网', '其他', '新闻');
INSERT INTO `website` VALUES ('17018', 'http://www.gazx.org/', '广安在线', '其他', '新闻');
INSERT INTO `website` VALUES ('17019', 'http://www.legaldaily.com.cn/', '法制网', '其他', '新闻');
INSERT INTO `website` VALUES ('17020', 'http://www.ln.xinhuanet.com/', '新华辽宁', '其他', '新闻');
INSERT INTO `website` VALUES ('17021', 'http://www.qzwb.com/', '泉州网', '其他', '新闻');
INSERT INTO `website` VALUES ('17022', 'http://news.qzwb.com/', '泉州网', '其他', '新闻');
INSERT INTO `website` VALUES ('17023', 'http://www.365kl.net/', '贵港快乐网', '其他', '论坛');
INSERT INTO `website` VALUES ('17024', 'http://www.rmzxb.com.cn/', '人民政协网', '其他', '新闻');
INSERT INTO `website` VALUES ('17025', 'http://sd.youth.cn/', '中国青年网山东频道', '其他', '新闻');
INSERT INTO `website` VALUES ('17026', 'http://www.zsr.cc/', '知识人网', '其他', '新闻');
INSERT INTO `website` VALUES ('17027', 'http://www.ce.cn/', '中国经济网', '其他', '新闻');
INSERT INTO `website` VALUES ('17028', 'http://jz.sxgov.cn/', '黄河新闻网晋中频道', '其他', '新闻');
INSERT INTO `website` VALUES ('17029', 'http://www.lnmedia.cn/', '鲁南传媒网', '其他', '新闻');
INSERT INTO `website` VALUES ('17030', 'http://news.anhuinews.com/', '中安在线', '其他', '新闻');
INSERT INTO `website` VALUES ('17031', 'http://www.hbjjrb.com/', '河北经济网', '其他', '新闻');
INSERT INTO `website` VALUES ('17032', 'http://news.shm.com.cn/', '水母网', '其他', '新闻');
INSERT INTO `website` VALUES ('17033', 'http://news.cnhubei.com/', '荆楚网', '其他', '新闻');
INSERT INTO `website` VALUES ('17034', 'http://club.faw-mazda.com/', '壹马会车主论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17035', 'http://www.my0538.com/', '中华泰山网', '其他', '新闻');
INSERT INTO `website` VALUES ('17036', 'http://shehui.china.com.cn/', '中国网', '其他', '新闻');
INSERT INTO `website` VALUES ('17037', 'http://www.xzyradio.com/', '心之语公益网', '其他', '新闻');
INSERT INTO `website` VALUES ('17038', 'http://ent.sinmeng.com/', '新梦网', '其他', '新闻');
INSERT INTO `website` VALUES ('17039', 'http://news.dayoo.com/', '大洋网', '其他', '新闻');
INSERT INTO `website` VALUES ('17040', 'http://www.07905.com/', '新余大新网', '其他', '新闻');
INSERT INTO `website` VALUES ('17041', 'http://henan.sina.cn/', '手机新浪网', '其他', '手机');
INSERT INTO `website` VALUES ('17042', 'http://henan.sina.com.cn/', '新浪河南', '其他', '新闻');
INSERT INTO `website` VALUES ('17043', 'http://www.kmtv.com.cn/', '昆明电视台', '其他', '新闻');
INSERT INTO `website` VALUES ('17044', 'http://slide.news.sina.com.cn/', '新浪', '其他', '新闻');
INSERT INTO `website` VALUES ('17045', 'http://photo.sina.cn/', '新浪新闻客户端', '其他', '手机');
INSERT INTO `website` VALUES ('17046', 'http://society.workercn.cn/', '中工网', '其他', '新闻');
INSERT INTO `website` VALUES ('17047', 'http://www.xiancity.cn/', '西安网', '其他', '新闻');
INSERT INTO `website` VALUES ('17048', 'http://news.xiancity.cn/', '西安网', '其他', '新闻');
INSERT INTO `website` VALUES ('17049', 'http://o.xiancity.cn/', '西安网', '其他', '新闻');
INSERT INTO `website` VALUES ('17050', 'http://bbs.lyss123.com/', '溧阳山水社区', '其他', '论坛');
INSERT INTO `website` VALUES ('17051', 'http://shop.lyss123.com/', '溧阳山水社区', '其他', '论坛');
INSERT INTO `website` VALUES ('17052', 'http://news.jinxun.cc/', '今讯网', '其他', '新闻');
INSERT INTO `website` VALUES ('17053', 'http://www.hnr.cn/', '河南广播网', '其他', '新闻');
INSERT INTO `website` VALUES ('17054', 'http://news.sznews.com/', '深圳新闻网', '其他', '新闻');
INSERT INTO `website` VALUES ('17055', 'http://ibaoan.sznews.com/', '深圳宝安网', '其他', '新闻');
INSERT INTO `website` VALUES ('17056', 'http://ilonggang.sznews.com/', '深圳龙岗新闻网', '其他', '新闻');
INSERT INTO `website` VALUES ('17057', 'http://www.hi.chinanews.com/', '中新网海南频道', '其他', '新闻');
INSERT INTO `website` VALUES ('17058', 'http://www.huanqiu.com/', '环球网', '其他', '新闻');
INSERT INTO `website` VALUES ('17059', 'http://www.jwb.com.cn/', '今晚网', '其他', '新闻');
INSERT INTO `website` VALUES ('17060', 'http://www.cnr.cn/', '央广网吉林分网', '其他', '新闻');
INSERT INTO `website` VALUES ('17061', 'http://weibo.com/', '新浪微博', '其他', '微博');
INSERT INTO `website` VALUES ('17062', 'http://api.k.sohu.com/', '搜狐新闻客户端', '其他', '手机');
INSERT INTO `website` VALUES ('17063', 'http://www.sncsu.com/', '艾森网江苏频道', '其他', '新闻');
INSERT INTO `website` VALUES ('17064', 'http://www.xsnet.cn/', '萧山网', '其他', '新闻');
INSERT INTO `website` VALUES ('17065', 'http://www.darongcheng.com/', '荣成信息港', '其他', '新闻');
INSERT INTO `website` VALUES ('17066', 'http://edu.qq.com/', '腾讯', '其他', '新闻');
INSERT INTO `website` VALUES ('17067', 'http://news.hnr.cn/', '映像网', '其他', '新闻');
INSERT INTO `website` VALUES ('17068', 'http://www.guangyuanol.cn/', '川北在线', '其他', '新闻');
INSERT INTO `website` VALUES ('17069', 'http://society.eastday.com/', '东方网', '其他', '新闻');
INSERT INTO `website` VALUES ('17070', 'http://sc.sina.com.cn/', '新浪四川', '其他', '新闻');
INSERT INTO `website` VALUES ('17071', 'http://sc.sina.cn/', '手机新浪网', '其他', '手机');
INSERT INTO `website` VALUES ('17072', 'http://law.chinaso.com/', '中国搜索', '其他', '新闻');
INSERT INTO `website` VALUES ('17073', 'http://gongyi.gmw.cn/', '光明网', '其他', '新闻');
INSERT INTO `website` VALUES ('17074', 'http://w.dzwww.com/', '掌上大众网', '其他', '手机');
INSERT INTO `website` VALUES ('17075', 'http://bj.jjj.qq.com/', '腾讯大燕网北京站', '其他', '新闻');
INSERT INTO `website` VALUES ('17076', 'http://www.tudou.com/', '土豆网', '其他', '视频');
INSERT INTO `website` VALUES ('17077', 'http://www.kankancity.com/', '看看城事', '其他', '新闻');
INSERT INTO `website` VALUES ('17078', 'http://www.05273.com/', '沭阳论坛网', '其他', '新闻');
INSERT INTO `website` VALUES ('17079', 'http://news.zjkonline.com/', '张家口在线', '其他', '新闻');
INSERT INTO `website` VALUES ('17080', 'http://api.iclient.ifeng.com/', '凤凰新闻客户端', '其他', '手机');
INSERT INTO `website` VALUES ('17081', 'http://sichuan.scol.com.cn/', '四川在线', '其他', '新闻');
INSERT INTO `website` VALUES ('17082', 'http://www.huangpujs.cn/', '黄埔军事', '其他', '新闻');
INSERT INTO `website` VALUES ('17083', 'http://news.sinmeng.com/', '新梦网', '其他', '新闻');
INSERT INTO `website` VALUES ('17084', 'http://www.baizhan.net/', '百战军事网', '其他', '新闻');
INSERT INTO `website` VALUES ('17085', 'http://www.shuchuan.net/', '蜀川在线论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17086', 'http://www.4hw.com.cn/', '四海网', '其他', '新闻');
INSERT INTO `website` VALUES ('17087', 'http://yule.4hw.com.cn/', '四海网', '其他', '新闻');
INSERT INTO `website` VALUES ('17088', 'http://www.junshis.com/', '三军网', '其他', '新闻');
INSERT INTO `website` VALUES ('17089', 'http://fund.stockstar.com/', '证券之星', '其他', '新闻');
INSERT INTO `website` VALUES ('17090', 'http://bbs.xnnews.com.cn/', '咸宁新闻论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17091', 'http://edu.szhk.com/', '深港在线', '其他', '新闻');
INSERT INTO `website` VALUES ('17092', 'http://www.ceiea.com/', '中国教育装备网', '其他', '新闻');
INSERT INTO `website` VALUES ('17093', 'http://bbs.lyd.com.cn/', '洛阳社区论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17094', 'http://bbs.luanren.com/', '六安人', '其他', '论坛');
INSERT INTO `website` VALUES ('17095', 'http://news.changsha.cn/', '星辰在线', '其他', '新闻');
INSERT INTO `website` VALUES ('17096', 'http://muzicoffee.com/', '木子网', '其他', '新闻');
INSERT INTO `website` VALUES ('17097', 'http://edu.cnr.cn/', '央广网', '其他', '新闻');
INSERT INTO `website` VALUES ('17098', 'http://www.wjol.net.cn/', '皖江在线', '其他', '新闻');
INSERT INTO `website` VALUES ('17099', 'http://c.3g.163.com/', '网易新闻客户端', '其他', '手机');
INSERT INTO `website` VALUES ('17100', 'http://bbs.news.163.com/', '网易论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17101', 'http://www.tengtv.com/', '滕国网', '其他', '新闻');
INSERT INTO `website` VALUES ('17102', 'http://blog.sina.com.cn/', '新浪博客', '其他', '博客');
INSERT INTO `website` VALUES ('17103', 'http://toutiao.v2gg.com/', '微儿网', '其他', '微信');
INSERT INTO `website` VALUES ('17104', 'http://www.qq.gg/', 'QQ公馆', '其他', '论坛');
INSERT INTO `website` VALUES ('17105', 'http://bbs.jj.xmfish.com/', '晋江小鱼论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17106', 'http://www.haljl.com/', '海安零距离', '其他', '论坛');
INSERT INTO `website` VALUES ('17107', 'http://jiaxing.19lou.com/', '嘉兴19楼', '其他', '论坛');
INSERT INTO `website` VALUES ('17108', 'http://bbs.gmw.cn/', '光明网论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17109', 'http://www.457000.com/', '大濮网论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17110', 'http://www.dongfeng.net/', '东风论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17111', 'http://bbs.dongfeng.net/', '东风论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17112', 'http://bbs.xyl.gov.cn/', '新榆林论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17113', 'http://bbs.jsxww.cn/', '嘉善市民论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17114', 'http://www.dxbei.com/', '大西北网', '其他', '新闻');
INSERT INTO `website` VALUES ('17115', 'http://shengzhou.108sq.com/', '108社区网', '省级', '论坛');
INSERT INTO `website` VALUES ('17116', 'http://bbs.3dmgame.com/', '3dmgame论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17117', 'http://www.junhunw.cn/', '军魂网社区', '其他', '论坛');
INSERT INTO `website` VALUES ('17118', 'http://news.zkxww.com/', '周口网', '其他', '新闻');
INSERT INTO `website` VALUES ('17119', 'http://bbs.wjnin.cn/', '望江论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17120', 'http://www.0573ren.com/', '嘉兴人论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17121', 'http://bbs.tiexue.net/', '铁血社区', '其他', '论坛');
INSERT INTO `website` VALUES ('17122', 'http://www.miss-no1.com/', '第一女人网', '其他', '新闻');
INSERT INTO `website` VALUES ('17123', 'http://www.jingdong.ccoo.cn/', '景东百姓论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17124', 'http://www.ahwang.cn/', '安徽网', '其他', '新闻');
INSERT INTO `website` VALUES ('17125', 'http://policewomen.cpd.com.cn/', '中国警察网', '其他', '新闻');
INSERT INTO `website` VALUES ('17126', 'http://top.chinadaily.com.cn/', '中国日报中文网', '其他', '新闻');
INSERT INTO `website` VALUES ('17127', 'http://bbs.hb163.cn/', '淮北人论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17128', 'http://bbs.21yq.com/', '乐清城市网论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17129', 'http://www.gminfo.cn/', '高密信息港', '其他', '新闻');
INSERT INTO `website` VALUES ('17130', 'http://www.zhangqiur.com/', '章丘人论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17131', 'http://www.ahbb.cc/', '蚌埠论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17132', 'http://www.bskk.com/', '地藏论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17133', 'http://www.chengdubbs.cn/', '成都论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17134', 'http://www.zgqss.cn/', '自贡全搜索论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17135', 'http://finance.ifeng.com/', '凤凰网财经', '其他', '新闻');
INSERT INTO `website` VALUES ('17136', 'http://bbs.nhzj.com/', '宁海论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17137', 'http://www.csxww.com/', '常熟新闻网', '其他', '新闻');
INSERT INTO `website` VALUES ('17138', 'http://bbs.0513.org/', '濠滨论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17139', 'http://lt.cjdby.net/', '超级大本营军事论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17140', 'http://www.xshang.net/', '邢商网论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17141', 'http://www.zznews.cn/', '漳州新闻网', '其他', '新闻');
INSERT INTO `website` VALUES ('17142', 'http://stock.romaway.com/', '容维社区', '其他', '论坛');
INSERT INTO `website` VALUES ('17143', 'http://bbs.ahwang.cn/', '99度社区', '其他', '论坛');
INSERT INTO `website` VALUES ('17144', 'http://news.cngold.org/', '金投网', '其他', '新闻');
INSERT INTO `website` VALUES ('17145', 'http://news.lanzhou.cn/', '中国兰州网', '其他', '新闻');
INSERT INTO `website` VALUES ('17146', 'http://bbs.hangzhou.com.cn/', '杭州网论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17147', 'http://www.fxsc.cn/', '丰县视窗', '其他', '新闻');
INSERT INTO `website` VALUES ('17148', 'http://news.ahlife.com/', '安徽生活网', '其他', '新闻');
INSERT INTO `website` VALUES ('17149', 'http://www.xbfw.com.cn/', '新北方网', '其他', '新闻');
INSERT INTO `website` VALUES ('17150', 'http://www.hgitv.com/', '黄冈新视窗', '其他', '新闻');
INSERT INTO `website` VALUES ('17151', 'http://db.chinaso.com/', '中国搜索', '其他', '新闻');
INSERT INTO `website` VALUES ('17152', 'http://news.lcxw.cn/', '聊城新闻网', '其他', '新闻');
INSERT INTO `website` VALUES ('17153', 'http://www.jmradio.com/', '江门电台', '其他', '新闻');
INSERT INTO `website` VALUES ('17154', 'http://www.jmtv.cn/', '江门广播电视台', '其他', '新闻');
INSERT INTO `website` VALUES ('17155', 'http://bbs.hebei.com.cn/', '长城论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17156', 'http://stock.huagu.com/', '华股财经', '其他', '新闻');
INSERT INTO `website` VALUES ('17157', 'http://cs.comnews.cn/', '中国商务新闻网', '其他', '新闻');
INSERT INTO `website` VALUES ('17158', 'http://yuqing.jschina.com.cn/', '中国江苏网', '其他', '新闻');
INSERT INTO `website` VALUES ('17159', 'http://www.xinyang.la/', '信阳生活网论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17160', 'http://law.beelink.com/', '百灵网', '其他', '新闻');
INSERT INTO `website` VALUES ('17161', 'http://fd.bbs0830.com/', '肥东第一人气论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17162', 'http://www.5281.cc/', '复转军人网论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17163', 'http://www.cnsnrc.com/', '中国社会新闻调查中心', '其他', '新闻');
INSERT INTO `website` VALUES ('17164', 'http://news.jstv.com/', '江苏网络广播电视台', '其他', '新闻');
INSERT INTO `website` VALUES ('17165', 'http://www.snyq.org/', '三农舆情网', '其他', '新闻');
INSERT INTO `website` VALUES ('17166', 'http://www.fawan.com/', '法制晚报网', '其他', '新闻');
INSERT INTO `website` VALUES ('17167', 'http://china.rednet.cn/', '红网', '其他', '新闻');
INSERT INTO `website` VALUES ('17168', 'http://bbs.nmql.org/', '农权论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17169', 'http://www.jj-tv.com/', '九江电视台', '其他', '新闻');
INSERT INTO `website` VALUES ('17170', 'http://www.zjknews.com/', '张家口新闻网', '其他', '新闻');
INSERT INTO `website` VALUES ('17171', 'http://www.js.xinhuanet.com/', '新华江苏', '其他', '新闻');
INSERT INTO `website` VALUES ('17172', 'http://www.dsz.cc:7001/', '独山子在线', '其他', '新闻');
INSERT INTO `website` VALUES ('17173', 'http://news.wehefei.com/', '合肥新闻资讯', '其他', '新闻');
INSERT INTO `website` VALUES ('17174', 'http://www.fj.chinanews.com/', '中新网福建频道', '其他', '新闻');
INSERT INTO `website` VALUES ('17175', 'http://www.edu-hb.com/', '招生考试网', '其他', '新闻');
INSERT INTO `website` VALUES ('17176', 'http://www.jx09.com/', '嘉兴第九区', '其他', '论坛');
INSERT INTO `website` VALUES ('17177', 'http://news.116.com.cn/', '天天在线', '其他', '新闻');
INSERT INTO `website` VALUES ('17178', 'http://news.zj.com/', '浙江都市网', '其他', '新闻');
INSERT INTO `website` VALUES ('17179', 'http://www.nxing.cn/', '宁夏在线', '其他', '新闻');
INSERT INTO `website` VALUES ('17180', 'http://m.cctv.com/', '手机央视网', '其他', '手机');
INSERT INTO `website` VALUES ('17181', 'http://politics.scdaily.cn/', '四川日报网', '其他', '报纸');
INSERT INTO `website` VALUES ('17182', 'http://law.cyol.com/', '中青在线', '其他', '新闻');
INSERT INTO `website` VALUES ('17183', 'http://www.chinadaily.com.cn/', '中国日报中文网', '其他', '新闻');
INSERT INTO `website` VALUES ('17184', 'http://sz.bendibao.com/', '深圳本地宝', '其他', '新闻');
INSERT INTO `website` VALUES ('17185', 'http://www.zaojiao.com/', '中国早教网', '其他', '新闻');
INSERT INTO `website` VALUES ('17186', 'http://legal.dbw.cn/', '东北网', '其他', '新闻');
INSERT INTO `website` VALUES ('17187', 'http://city.shenchuang.com/', '深圳之窗', '其他', '新闻');
INSERT INTO `website` VALUES ('17188', 'http://www.ycmhz.com.cn/', '中国宜春门户站', '其他', '新闻');
INSERT INTO `website` VALUES ('17189', 'http://www.cnyxzg.cn/', '印象中国网', '其他', '新闻');
INSERT INTO `website` VALUES ('17190', 'http://club.cnokcn.com/', '中国电子供应商网论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17191', 'http://bbs.m4.cn/', '四月青年论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17192', 'http://cq.qq.com/', '腾讯大渝网', '其他', '新闻');
INSERT INTO `website` VALUES ('17193', 'http://j.news.163.com/', '网易荐新闻', '其他', '新闻');
INSERT INTO `website` VALUES ('17194', 'http://blog.ifeng.com/', '凤凰博报', '其他', '博客');
INSERT INTO `website` VALUES ('17195', 'http://blog.chinaiiss.com/', '战略网博客', '其他', '博客');
INSERT INTO `website` VALUES ('17196', 'http://yadianna2shu.blogchina.com/', '博客中国', '其他', '博客');
INSERT INTO `website` VALUES ('17197', 'http://blog.tianya.cn/', '天涯博客', '其他', '博客');
INSERT INTO `website` VALUES ('17198', 'http://yadianna2shu.blog.sohu.com/', '搜狐博客', '其他', '博客');
INSERT INTO `website` VALUES ('17199', 'http://www.zzbbs.com/', '方圆郑州论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17200', 'http://msn.huanqiu.com/', 'MSN中文网', '其他', '新闻');
INSERT INTO `website` VALUES ('17201', 'http://china.huanqiu.com/', '环球网', '其他', '新闻');
INSERT INTO `website` VALUES ('17202', 'http://w.huanqiu.com/', '手机环球网', '其他', '手机');
INSERT INTO `website` VALUES ('17203', 'http://www.thepaper.cn/', '澎湃新闻网', '其他', '新闻');
INSERT INTO `website` VALUES ('17204', 'http://m.thepaper.cn/', '手机澎湃新闻网', '其他', '新闻');
INSERT INTO `website` VALUES ('17205', 'http://news.southcn.com/', '南方网', '其他', '新闻');
INSERT INTO `website` VALUES ('17206', 'http://zhidao.baidu.com/', '百度知道', '其他', '问答');
INSERT INTO `website` VALUES ('17207', 'http://dzh.mop.com/', '猫扑大杂烩', '其他', '论坛');
INSERT INTO `website` VALUES ('17208', 'http://bbs.msxh.com/', '搜眉山社区', '其他', '论坛');
INSERT INTO `website` VALUES ('17209', 'http://bbs.ly.shangdu.com/', '洛阳信息港论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17210', 'http://www.liaochengxx.com/', '聊城信息港2', '其他', '新闻');
INSERT INTO `website` VALUES ('17211', 'http://www.guanxian.org/', '冠县信息港', '其他', '新闻');
INSERT INTO `website` VALUES ('17212', 'http://www.wuyishan.com/', '武夷山网', '其他', '新闻');
INSERT INTO `website` VALUES ('17213', 'http://www.xbkfw.cn/', '西部开发网', '其他', '新闻');
INSERT INTO `website` VALUES ('17214', 'http://pinglun.eastday.com/', '东方网', '其他', '新闻');
INSERT INTO `website` VALUES ('17215', 'http://bbs.workercn.cn/', '中工网论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17216', 'http://blog.gmw.cn/', '光明网思想博客', '其他', '博客');
INSERT INTO `website` VALUES ('17217', 'http://www.changyang.ccoo.cn/', '长阳在线论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17218', 'http://www.400.com.cn/', '兴化400生活论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17219', 'http://bbs.safehoo.com/', '安全管理论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17220', 'http://www.lawtv.com.cn/', '法治中国视听', '其他', '视频');
INSERT INTO `website` VALUES ('17221', 'http://www.1732.net/', '赤峰在线', '其他', '新闻');
INSERT INTO `website` VALUES ('17222', 'http://www.gzqss.cn/', '贵州商报', '其他', '报纸');
INSERT INTO `website` VALUES ('17223', 'http://photos.caijing.com.cn/', '财经网', '其他', '新闻');
INSERT INTO `website` VALUES ('17224', 'http://comment.scol.com.cn/', '四川在线', '其他', '新闻');
INSERT INTO `website` VALUES ('17225', 'http://bbs.fcgsnews.com/', '防城港人论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17226', 'http://www.lfrbnews.com/', '廊坊日报网', '其他', '新闻');
INSERT INTO `website` VALUES ('17227', 'http://hb.ifeng.com/', '凤凰网湖北频道', '其他', '新闻');
INSERT INTO `website` VALUES ('17228', 'http://www.tobnews.com/', '透博网', '其他', '新闻');
INSERT INTO `website` VALUES ('17229', 'http://www.hnedu.cn/', '湖南教育网', '其他', '新闻');
INSERT INTO `website` VALUES ('17230', 'http://bbs.sg169.com/', '韶关家园论坛', '其他', '论坛');
INSERT INTO `website` VALUES ('17231', 'http://www.tiboo.cn/', '地宝网', '其他', '论坛');
INSERT INTO `website` VALUES ('17232', 'www.test.com.cn/', '其他', '其他', '其他');
INSERT INTO `website` VALUES ('17233', 'http://www.ktouch.org/', '其他', '其他', '其他');
INSERT INTO `website` VALUES ('17234', 'http://henan.china.com.cn/', '其他', '其他', '其他');
INSERT INTO `website` VALUES ('17235', 'http://news.3g.cn/', '其他', '其他', '其他');
INSERT INTO `website` VALUES ('17236', 'http://peterlin8888888.blogchina.com/', '其他', '其他', '其他');
INSERT INTO `website` VALUES ('17237', 'http://news.sina.cn/', '其他', '其他', '其他');
INSERT INTO `website` VALUES ('17238', 'http://www.scsn.cn/', '其他', '其他', '其他');
INSERT INTO `website` VALUES ('17239', 'http://survey.btime.com/', '其他', '其他', '其他');
INSERT INTO `website` VALUES ('17240', 'http://www.anhui163.net/', '其他', '其他', '其他');
INSERT INTO `website` VALUES ('17241', 'http://jk.scol.com.cn/', '其他', '其他', '其他');
INSERT INTO `website` VALUES ('17242', 'http://www.fzhnw.com/', '其他', '其他', '其他');
INSERT INTO `website` VALUES ('17243', 'http://news.syd.com.cn/', '其他', '其他', '其他');
INSERT INTO `website` VALUES ('17244', 'http://www.scxxb.com.cn/', '其他', '其他', '其他');
INSERT INTO `website` VALUES ('17245', 'http://www.dmnic.org/', '其他', '其他', '其他');
INSERT INTO `website` VALUES ('17246', 'http://bbs.lygbst.cn/', '其他', '其他', '其他');
INSERT INTO `website` VALUES ('17247', 'http://www.mzyfz.com/', '其他', '其他', '其他');
INSERT INTO `website` VALUES ('17248', 'http://www.qianhuaweb.com/', '其他', '其他', '其他');
INSERT INTO `website` VALUES ('17249', 'http://yisheng.china.com.cn/', '其他', '其他', '其他');
INSERT INTO `website` VALUES ('17250', 'http://www.zijing.org/', '其他', '其他', '其他');
INSERT INTO `website` VALUES ('17251', 'http://health.zijing.org/', '其他', '其他', '其他');
INSERT INTO `website` VALUES ('17252', 'http://news.zijing.org/', '其他', '其他', '其他');
INSERT INTO `website` VALUES ('17253', 'http://money.huagu.com/', '其他', '其他', '其他');
INSERT INTO `website` VALUES ('17254', 'http://www.gdin.net/', '其他', '其他', '其他');
INSERT INTO `website` VALUES ('17255', 'http://www.dbbaa.com/', '其他', '其他', '其他');
INSERT INTO `website` VALUES ('17256', 'http://www.cssq.net/', '其他', '其他', '其他');
INSERT INTO `website` VALUES ('17257', 'http://www.zgrbhb.com/', '其他', '其他', '其他');
INSERT INTO `website` VALUES ('17258', 'http://hn.china.com/', '其他', '其他', '其他');

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
