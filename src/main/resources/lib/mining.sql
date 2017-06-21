/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50718
Source Host           : localhost:3306
Source Database       : mining

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2017-06-14 13:53:38
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for core_result
-- ----------------------------
DROP TABLE IF EXISTS `core_result`;
CREATE TABLE `core_result` (
  `core_rid` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `res_name` varchar(512) NOT NULL,
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
-- Table structure for label
-- ----------------------------
DROP TABLE IF EXISTS `label`;
CREATE TABLE `label` (
  `labelid` int(11) NOT NULL AUTO_INCREMENT,
  `labelname` varchar(32) NOT NULL,
  PRIMARY KEY (`labelid`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of label
-- ----------------------------
INSERT INTO `label` VALUES ('1', '戒毒fffff');
INSERT INTO `label` VALUES ('2', '公安');
INSERT INTO `label` VALUES ('3', '杀人');
INSERT INTO `label` VALUES ('4', '跳楼');
INSERT INTO `label` VALUES ('5', '救人');
INSERT INTO `label` VALUES ('6', '车祸');
INSERT INTO `label` VALUES ('7', '政法');
INSERT INTO `label` VALUES ('9', '坠楼');
INSERT INTO `label` VALUES ('10', '高考');
INSERT INTO `label` VALUES ('11', '中考');
INSERT INTO `label` VALUES ('13', '查询');
INSERT INTO `label` VALUES ('14', '查看');
INSERT INTO `label` VALUES ('15', '哈哈哈');

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
INSERT INTO `power` VALUES ('10', '查询用户列表', '/user/getUserInfoByPageLimit');
INSERT INTO `power` VALUES ('11', '查询角色不包含的权限', '/role/notIncludePowersOfRole');
INSERT INTO `power` VALUES ('12', '为角色赋予权限', '/role/insertPowerOfRole');
INSERT INTO `power` VALUES ('13', '删除角色权限映射', '/role/deletePowerOfRole');
INSERT INTO `power` VALUES ('14', '查询角色包含的权限', '/role/includePowersOfRole');
INSERT INTO `power` VALUES ('15', '查询单条权限', '/power/selectOnePowerInfo');
INSERT INTO `power` VALUES ('16', '添加权限', '/power/insertPowerInfo');
INSERT INTO `power` VALUES ('17', '删除权限', '/power/deletePowerById');
INSERT INTO `power` VALUES ('18', '更新权限', '/power/updatePowerInfo');
INSERT INTO `power` VALUES ('19', '查询用户不包含的角色', '/role/selectNotIncluedRole');
INSERT INTO `power` VALUES ('20', '登录系统', '/login');
INSERT INTO `power` VALUES ('21', '退出系统', '/logout');
INSERT INTO `power` VALUES ('22', '查看个人信息', '/personal/getPersonalInfo');
INSERT INTO `power` VALUES ('23', '修改个人信息', '/personal/updatePersonalInfo');
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
INSERT INTO `power` VALUES ('36', '合并类簇', '/result/combineSets');
INSERT INTO `power` VALUES ('37', '获取历史操作结果', '/result/queryResultList');
INSERT INTO `power` VALUES ('38', '重置聚类结果', '/result/resetResultById');
INSERT INTO `power` VALUES ('39', '创建话题', '/issue/create');
INSERT INTO `power` VALUES ('40', '预览文件', '/file/getColumnTitle');
INSERT INTO `power` VALUES ('41', '上传文件', '/file/upload');
INSERT INTO `power` VALUES ('42', '删除话题', '/issue/delete');
INSERT INTO `power` VALUES ('43', '下载结果', '/file/download');
INSERT INTO `power` VALUES ('44', '搜索文件', '/file/searchFileByCon');
INSERT INTO `power` VALUES ('45', '根据时间聚类', '/issue/miningByTime');
INSERT INTO `power` VALUES ('46', '查询所有任务表', '/issue/queryAllIssue');
INSERT INTO `power` VALUES ('47', '单文件聚类', '/result/miningSingleFile');
INSERT INTO `power` VALUES ('48', '获取当前用户的名称', '/getCurrentUser');
INSERT INTO `power` VALUES ('49', '查询所有任务', '/issue/queryAllIssue');
INSERT INTO `power` VALUES ('50', '删除一条历史记录', '/result/delResultById');
INSERT INTO `power` VALUES ('51', '查询所有来源类型', '/sourceType/selectAllSourceType');
INSERT INTO `power` VALUES ('52', '根据来源名称查询', '/sourceType/selectSourceTypeByName');
INSERT INTO `power` VALUES ('53', '删除来源类型', '/sourceType/deleteSourceTypeById');
INSERT INTO `power` VALUES ('54', '添加来源类型', '/sourceType/insertSourceType');
INSERT INTO `power` VALUES ('55', '更新来源类型', '/sourceType/updateSourceType');
INSERT INTO `power` VALUES ('56', '查询所有网址', '/website/selectAllWebsite');
INSERT INTO `power` VALUES ('57', '查询所有未知网址', '/website/selectAllWebsiteUnknow');
INSERT INTO `power` VALUES ('58', '添加网址', '/website/insertWebsite');
INSERT INTO `power` VALUES ('59', '删除网址', '/website/deleteWebsite');
INSERT INTO `power` VALUES ('60', '修改网址信息', '/website/updateWebsite');
INSERT INTO `power` VALUES ('61', '根据条件查询网址', '/website/selectByCondition');
INSERT INTO `power` VALUES ('62', '查询所有权重信息', '/weight/selectAllWeight');
INSERT INTO `power` VALUES ('63', '根据条件查询权重信息', '/weight/selectByCondition');
INSERT INTO `power` VALUES ('64', '添加权重信息', '/weight/insertWeight');
INSERT INTO `power` VALUES ('65', '删除权重信息', '/weight/deleteWeight');
INSERT INTO `power` VALUES ('66', '更新权重信息', '/weight/updateWeight');
INSERT INTO `power` VALUES ('67', '修改登录密码', '/personal/updatePassword');
INSERT INTO `power` VALUES ('68', '查询所有权限', '/power/selectAllPower');
INSERT INTO `power` VALUES ('69', '修改角色的权限', '/role/updateRoleInfo');
INSERT INTO `power` VALUES ('70', '删除角色', '/role/deleteRoleInfoById');
INSERT INTO `power` VALUES ('71', '生成简报', '/file/exportAbstract');
INSERT INTO `power` VALUES ('72', '查询自有任务数量', '/issue/queryOwnIssueCount');
INSERT INTO `power` VALUES ('73', '查询全局任务数量', '/issue/queryAllIssueCount');
INSERT INTO `power` VALUES ('74', '查询停用词数量', '/stopword/selectStopwordCount');
INSERT INTO `power` VALUES ('75', '查询未知URL数量', '/website/selectUnknowWebsiteCount');
INSERT INTO `power` VALUES ('76', '查询网站数量', '/website/selectWebsiteCount');
INSERT INTO `power` VALUES ('77', '查询网站权重数量', '/weight/selectWeightCount');
INSERT INTO `power` VALUES ('78', '查询源数据类型数量', '/sourceType/selectSourceTypeCount');
INSERT INTO `power` VALUES ('79', '查询用户数量', '/user/selectUserInfoCount');
INSERT INTO `power` VALUES ('80', '查询角色数量', '/role/selectRoleInfoCount');
INSERT INTO `power` VALUES ('81', '查询权限数量', '/power/selectPowerCount');
INSERT INTO `power` VALUES ('82', '获取登录用户ID', '/getCurrentUserId');
INSERT INTO `power` VALUES ('83', '查看类中所有元素', '/result/getClusterResult');
INSERT INTO `power` VALUES ('84', '删除类簇中元素', '/result/deleteClusterItems');
INSERT INTO `power` VALUES ('85', '重置类簇信息', '/result/resetClusterItems');
INSERT INTO `power` VALUES ('87', '查询准数据', '/standardResult/queryStandardResults');
INSERT INTO `power` VALUES ('88', '查询关联任务', '/issue/queryLinkedIssue');
INSERT INTO `power` VALUES ('89', '导出已知URL', '/website/downloadKnownUrl');
INSERT INTO `power` VALUES ('90', '添加停用词', '/stopword/insertStopwords');
INSERT INTO `power` VALUES ('91', '查询所有停用词', '/stopword/selectAllStopword');
INSERT INTO `power` VALUES ('92', '删除停用词', '/stopword/deleteStopwordById');
INSERT INTO `power` VALUES ('93', '生成准数据', '/issue/createIssueWithLink');
INSERT INTO `power` VALUES ('94', '下载准数据', '/standardResult/download');
INSERT INTO `power` VALUES ('95', '删除准数据', '/standardResult/delete');
INSERT INTO `power` VALUES ('96', '查询核心数据', '/coreResult/queryCoreResults');
INSERT INTO `power` VALUES ('97', '下载核心数据', '/coreResult/download');
INSERT INTO `power` VALUES ('98', '删除核心数据', '/coreResult/delete');
INSERT INTO `power` VALUES ('99', '导出未知URL', '/website/downloadUnKnownUrl');
INSERT INTO `power` VALUES ('100', '算法容器文件上传', '/AlgorithmContainer/upload');
INSERT INTO `power` VALUES ('101', '算法容器下载结果', '/AlgorithmContainer/downloadResult');
INSERT INTO `power` VALUES ('102', '算法容器设置默认算法', '/user/setAlgorithmAndGranularity');
INSERT INTO `power` VALUES ('103', 'KMeans算法聚类演示', '/AlgorithmContainer/ClusterByKmeans');
INSERT INTO `power` VALUES ('104', 'Canopy算法聚类演示', '/AlgorithmContainer/ClusterByCanopy');
INSERT INTO `power` VALUES ('105', 'DBScan算法聚类演示', '/AlgorithmContainer/ClusterByDBScan');
INSERT INTO `power` VALUES ('106', '添加映射文件', '/website/importMapUrl');
INSERT INTO `power` VALUES ('107', '统计任务下所有文件的URL', '/issue/countURL');
INSERT INTO `power` VALUES ('108', '查看当前准数据已有的标签', '/issue/selectLabelsForStandResult');
INSERT INTO `power` VALUES ('109', '查看当前准数据没有的标签', '/issue/findLabelNotInStandardResult');
INSERT INTO `power` VALUES ('110', '删除准数据标签', '/issue/deleteLabelOfStandard');
INSERT INTO `power` VALUES ('111', '显示每一页标签信息', '/label/selectAllLabel');
INSERT INTO `power` VALUES ('112', '查询标签数量', '/label/selectlabelcount');
INSERT INTO `power` VALUES ('113', '搜索标签', '/label/selectLabelByName');
INSERT INTO `power` VALUES ('114', '添加标签', '/label/insertLabel');
INSERT INTO `power` VALUES ('115', '更新标签', '/label/updateLabel');
INSERT INTO `power` VALUES ('116', '删除标签', '/label/deleteLabelById');
INSERT INTO `power` VALUES ('117', '为准数据贴标签', '/issue/SetLabelForStandardResult');

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
INSERT INTO `role_power` VALUES ('2309', '2', '1');
INSERT INTO `role_power` VALUES ('2310', '2', '2');
INSERT INTO `role_power` VALUES ('2311', '2', '3');
INSERT INTO `role_power` VALUES ('2312', '2', '4');
INSERT INTO `role_power` VALUES ('2313', '2', '5');
INSERT INTO `role_power` VALUES ('2314', '2', '6');
INSERT INTO `role_power` VALUES ('2315', '2', '7');
INSERT INTO `role_power` VALUES ('2316', '2', '8');
INSERT INTO `role_power` VALUES ('2317', '2', '9');
INSERT INTO `role_power` VALUES ('2318', '2', '10');
INSERT INTO `role_power` VALUES ('2319', '2', '12');
INSERT INTO `role_power` VALUES ('2320', '2', '13');
INSERT INTO `role_power` VALUES ('2321', '2', '14');
INSERT INTO `role_power` VALUES ('2322', '2', '19');
INSERT INTO `role_power` VALUES ('2323', '2', '20');
INSERT INTO `role_power` VALUES ('2324', '2', '21');
INSERT INTO `role_power` VALUES ('2325', '2', '22');
INSERT INTO `role_power` VALUES ('2326', '2', '23');
INSERT INTO `role_power` VALUES ('2327', '2', '24');
INSERT INTO `role_power` VALUES ('2328', '2', '25');
INSERT INTO `role_power` VALUES ('2329', '2', '26');
INSERT INTO `role_power` VALUES ('2330', '2', '27');
INSERT INTO `role_power` VALUES ('2331', '2', '28');
INSERT INTO `role_power` VALUES ('2332', '2', '29');
INSERT INTO `role_power` VALUES ('2333', '2', '30');
INSERT INTO `role_power` VALUES ('2334', '2', '31');
INSERT INTO `role_power` VALUES ('2335', '2', '32');
INSERT INTO `role_power` VALUES ('2336', '2', '33');
INSERT INTO `role_power` VALUES ('2337', '2', '34');
INSERT INTO `role_power` VALUES ('2338', '2', '35');
INSERT INTO `role_power` VALUES ('2339', '2', '36');
INSERT INTO `role_power` VALUES ('2340', '2', '37');
INSERT INTO `role_power` VALUES ('2341', '2', '38');
INSERT INTO `role_power` VALUES ('2342', '2', '39');
INSERT INTO `role_power` VALUES ('2343', '2', '40');
INSERT INTO `role_power` VALUES ('2344', '2', '41');
INSERT INTO `role_power` VALUES ('2345', '2', '42');
INSERT INTO `role_power` VALUES ('2346', '2', '43');
INSERT INTO `role_power` VALUES ('2347', '2', '44');
INSERT INTO `role_power` VALUES ('2348', '2', '45');
INSERT INTO `role_power` VALUES ('2349', '2', '46');
INSERT INTO `role_power` VALUES ('2350', '2', '47');
INSERT INTO `role_power` VALUES ('2351', '2', '48');
INSERT INTO `role_power` VALUES ('2352', '2', '49');
INSERT INTO `role_power` VALUES ('2353', '2', '50');
INSERT INTO `role_power` VALUES ('2354', '2', '51');
INSERT INTO `role_power` VALUES ('2355', '2', '52');
INSERT INTO `role_power` VALUES ('2356', '2', '53');
INSERT INTO `role_power` VALUES ('2357', '2', '54');
INSERT INTO `role_power` VALUES ('2358', '2', '55');
INSERT INTO `role_power` VALUES ('2359', '2', '56');
INSERT INTO `role_power` VALUES ('2360', '2', '57');
INSERT INTO `role_power` VALUES ('2361', '2', '58');
INSERT INTO `role_power` VALUES ('2362', '2', '59');
INSERT INTO `role_power` VALUES ('2363', '2', '60');
INSERT INTO `role_power` VALUES ('2364', '2', '61');
INSERT INTO `role_power` VALUES ('2365', '2', '62');
INSERT INTO `role_power` VALUES ('2366', '2', '63');
INSERT INTO `role_power` VALUES ('2367', '2', '64');
INSERT INTO `role_power` VALUES ('2368', '2', '65');
INSERT INTO `role_power` VALUES ('2369', '2', '66');
INSERT INTO `role_power` VALUES ('2370', '2', '67');
INSERT INTO `role_power` VALUES ('2371', '2', '69');
INSERT INTO `role_power` VALUES ('2372', '2', '71');
INSERT INTO `role_power` VALUES ('2373', '2', '72');
INSERT INTO `role_power` VALUES ('2374', '2', '73');
INSERT INTO `role_power` VALUES ('2375', '2', '74');
INSERT INTO `role_power` VALUES ('2376', '2', '75');
INSERT INTO `role_power` VALUES ('2377', '2', '76');
INSERT INTO `role_power` VALUES ('2378', '2', '77');
INSERT INTO `role_power` VALUES ('2379', '2', '78');
INSERT INTO `role_power` VALUES ('2380', '2', '79');
INSERT INTO `role_power` VALUES ('2381', '2', '80');
INSERT INTO `role_power` VALUES ('2382', '2', '82');
INSERT INTO `role_power` VALUES ('2383', '2', '83');
INSERT INTO `role_power` VALUES ('2384', '2', '84');
INSERT INTO `role_power` VALUES ('2385', '2', '85');
INSERT INTO `role_power` VALUES ('2387', '2', '87');
INSERT INTO `role_power` VALUES ('2388', '2', '88');
INSERT INTO `role_power` VALUES ('2389', '2', '89');
INSERT INTO `role_power` VALUES ('2390', '2', '90');
INSERT INTO `role_power` VALUES ('2391', '2', '91');
INSERT INTO `role_power` VALUES ('2392', '2', '92');
INSERT INTO `role_power` VALUES ('2393', '2', '93');
INSERT INTO `role_power` VALUES ('2394', '2', '94');
INSERT INTO `role_power` VALUES ('2395', '2', '95');
INSERT INTO `role_power` VALUES ('2396', '2', '96');
INSERT INTO `role_power` VALUES ('2397', '2', '97');
INSERT INTO `role_power` VALUES ('2398', '2', '98');
INSERT INTO `role_power` VALUES ('2399', '2', '99');
INSERT INTO `role_power` VALUES ('2400', '2', '100');
INSERT INTO `role_power` VALUES ('2401', '2', '101');
INSERT INTO `role_power` VALUES ('2402', '2', '102');
INSERT INTO `role_power` VALUES ('2403', '2', '103');
INSERT INTO `role_power` VALUES ('2404', '2', '104');
INSERT INTO `role_power` VALUES ('2405', '2', '105');
INSERT INTO `role_power` VALUES ('2406', '2', '106');
INSERT INTO `role_power` VALUES ('2407', '2', '11');
INSERT INTO `role_power` VALUES ('2632', '1', '1');
INSERT INTO `role_power` VALUES ('2633', '1', '2');
INSERT INTO `role_power` VALUES ('2634', '1', '3');
INSERT INTO `role_power` VALUES ('2635', '1', '4');
INSERT INTO `role_power` VALUES ('2636', '1', '5');
INSERT INTO `role_power` VALUES ('2637', '1', '6');
INSERT INTO `role_power` VALUES ('2638', '1', '7');
INSERT INTO `role_power` VALUES ('2639', '1', '8');
INSERT INTO `role_power` VALUES ('2640', '1', '9');
INSERT INTO `role_power` VALUES ('2641', '1', '10');
INSERT INTO `role_power` VALUES ('2642', '1', '11');
INSERT INTO `role_power` VALUES ('2643', '1', '12');
INSERT INTO `role_power` VALUES ('2644', '1', '13');
INSERT INTO `role_power` VALUES ('2645', '1', '14');
INSERT INTO `role_power` VALUES ('2646', '1', '15');
INSERT INTO `role_power` VALUES ('2647', '1', '16');
INSERT INTO `role_power` VALUES ('2648', '1', '17');
INSERT INTO `role_power` VALUES ('2649', '1', '18');
INSERT INTO `role_power` VALUES ('2650', '1', '19');
INSERT INTO `role_power` VALUES ('2651', '1', '20');
INSERT INTO `role_power` VALUES ('2652', '1', '21');
INSERT INTO `role_power` VALUES ('2653', '1', '22');
INSERT INTO `role_power` VALUES ('2654', '1', '23');
INSERT INTO `role_power` VALUES ('2655', '1', '24');
INSERT INTO `role_power` VALUES ('2656', '1', '25');
INSERT INTO `role_power` VALUES ('2657', '1', '26');
INSERT INTO `role_power` VALUES ('2658', '1', '27');
INSERT INTO `role_power` VALUES ('2659', '1', '28');
INSERT INTO `role_power` VALUES ('2660', '1', '29');
INSERT INTO `role_power` VALUES ('2661', '1', '30');
INSERT INTO `role_power` VALUES ('2662', '1', '31');
INSERT INTO `role_power` VALUES ('2663', '1', '32');
INSERT INTO `role_power` VALUES ('2664', '1', '33');
INSERT INTO `role_power` VALUES ('2665', '1', '34');
INSERT INTO `role_power` VALUES ('2666', '1', '35');
INSERT INTO `role_power` VALUES ('2667', '1', '36');
INSERT INTO `role_power` VALUES ('2668', '1', '37');
INSERT INTO `role_power` VALUES ('2669', '1', '38');
INSERT INTO `role_power` VALUES ('2670', '1', '39');
INSERT INTO `role_power` VALUES ('2671', '1', '40');
INSERT INTO `role_power` VALUES ('2672', '1', '41');
INSERT INTO `role_power` VALUES ('2673', '1', '42');
INSERT INTO `role_power` VALUES ('2674', '1', '43');
INSERT INTO `role_power` VALUES ('2675', '1', '44');
INSERT INTO `role_power` VALUES ('2676', '1', '45');
INSERT INTO `role_power` VALUES ('2677', '1', '46');
INSERT INTO `role_power` VALUES ('2678', '1', '47');
INSERT INTO `role_power` VALUES ('2679', '1', '48');
INSERT INTO `role_power` VALUES ('2680', '1', '49');
INSERT INTO `role_power` VALUES ('2681', '1', '50');
INSERT INTO `role_power` VALUES ('2682', '1', '51');
INSERT INTO `role_power` VALUES ('2683', '1', '52');
INSERT INTO `role_power` VALUES ('2684', '1', '53');
INSERT INTO `role_power` VALUES ('2685', '1', '54');
INSERT INTO `role_power` VALUES ('2686', '1', '55');
INSERT INTO `role_power` VALUES ('2687', '1', '56');
INSERT INTO `role_power` VALUES ('2688', '1', '57');
INSERT INTO `role_power` VALUES ('2689', '1', '58');
INSERT INTO `role_power` VALUES ('2690', '1', '59');
INSERT INTO `role_power` VALUES ('2691', '1', '60');
INSERT INTO `role_power` VALUES ('2692', '1', '61');
INSERT INTO `role_power` VALUES ('2693', '1', '62');
INSERT INTO `role_power` VALUES ('2694', '1', '63');
INSERT INTO `role_power` VALUES ('2695', '1', '64');
INSERT INTO `role_power` VALUES ('2696', '1', '65');
INSERT INTO `role_power` VALUES ('2697', '1', '66');
INSERT INTO `role_power` VALUES ('2698', '1', '67');
INSERT INTO `role_power` VALUES ('2699', '1', '68');
INSERT INTO `role_power` VALUES ('2700', '1', '69');
INSERT INTO `role_power` VALUES ('2701', '1', '70');
INSERT INTO `role_power` VALUES ('2702', '1', '71');
INSERT INTO `role_power` VALUES ('2703', '1', '72');
INSERT INTO `role_power` VALUES ('2704', '1', '73');
INSERT INTO `role_power` VALUES ('2705', '1', '74');
INSERT INTO `role_power` VALUES ('2706', '1', '75');
INSERT INTO `role_power` VALUES ('2707', '1', '76');
INSERT INTO `role_power` VALUES ('2708', '1', '77');
INSERT INTO `role_power` VALUES ('2709', '1', '78');
INSERT INTO `role_power` VALUES ('2710', '1', '79');
INSERT INTO `role_power` VALUES ('2711', '1', '80');
INSERT INTO `role_power` VALUES ('2712', '1', '81');
INSERT INTO `role_power` VALUES ('2713', '1', '82');
INSERT INTO `role_power` VALUES ('2714', '1', '83');
INSERT INTO `role_power` VALUES ('2715', '1', '84');
INSERT INTO `role_power` VALUES ('2716', '1', '85');
INSERT INTO `role_power` VALUES ('2717', '1', '87');
INSERT INTO `role_power` VALUES ('2718', '1', '88');
INSERT INTO `role_power` VALUES ('2719', '1', '89');
INSERT INTO `role_power` VALUES ('2720', '1', '90');
INSERT INTO `role_power` VALUES ('2721', '1', '91');
INSERT INTO `role_power` VALUES ('2722', '1', '92');
INSERT INTO `role_power` VALUES ('2723', '1', '93');
INSERT INTO `role_power` VALUES ('2724', '1', '94');
INSERT INTO `role_power` VALUES ('2725', '1', '95');
INSERT INTO `role_power` VALUES ('2726', '1', '96');
INSERT INTO `role_power` VALUES ('2727', '1', '97');
INSERT INTO `role_power` VALUES ('2728', '1', '98');
INSERT INTO `role_power` VALUES ('2729', '1', '99');
INSERT INTO `role_power` VALUES ('2730', '1', '100');
INSERT INTO `role_power` VALUES ('2731', '1', '101');
INSERT INTO `role_power` VALUES ('2732', '1', '102');
INSERT INTO `role_power` VALUES ('2733', '1', '103');
INSERT INTO `role_power` VALUES ('2734', '1', '104');
INSERT INTO `role_power` VALUES ('2735', '1', '105');
INSERT INTO `role_power` VALUES ('2736', '1', '106');
INSERT INTO `role_power` VALUES ('2737', '1', '107');
INSERT INTO `role_power` VALUES ('2738', '1', '108');
INSERT INTO `role_power` VALUES ('2739', '1', '109');
INSERT INTO `role_power` VALUES ('2740', '1', '110');
INSERT INTO `role_power` VALUES ('2741', '1', '111');
INSERT INTO `role_power` VALUES ('2742', '1', '112');
INSERT INTO `role_power` VALUES ('2743', '1', '113');
INSERT INTO `role_power` VALUES ('2744', '1', '114');
INSERT INTO `role_power` VALUES ('2745', '1', '115');
INSERT INTO `role_power` VALUES ('2746', '1', '116');
INSERT INTO `role_power` VALUES ('2747', '1', '117');


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
-- Table structure for standardresult_label
-- ----------------------------
DROP TABLE IF EXISTS `standardresult_label`;
CREATE TABLE `standardresult_label` (
  `std_rid` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `labelid` int(11) NOT NULL,
  KEY `std_rid` (`std_rid`),
  KEY `labelid` (`labelid`),
  CONSTRAINT `standardresult_label_ibfk_1` FOREIGN KEY (`std_rid`) REFERENCES `standard_result` (`std_rid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `standardresult_label_ibfk_2` FOREIGN KEY (`labelid`) REFERENCES `label` (`labelid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of standardresult_label
-- ----------------------------

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
INSERT INTO `user` VALUES ('1', 'superman', 'superman', 'superman@qq.com', '17762617653', '超级管理员', '2017-06-21', '1', '1');
INSERT INTO `user` VALUES ('2', 'jingjing', 'jingjing', 'jingjing@qq.com', '15395795687', '汪静远', '2017-06-21', '1', '1');

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
