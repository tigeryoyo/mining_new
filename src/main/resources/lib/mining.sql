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
INSERT INTO `power` VALUES ('36', '合并类', '/result/combineSets');
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
INSERT INTO `power` VALUES ('86', '获取标签数量', '/label/selectlabelcount');
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
INSERT INTO `power` VALUES ('146', '算法容器文件上传', '/AlgorithmContainer/upload');
INSERT INTO `power` VALUES ('147', '算法容器下载结果', '/AlgorithmContainer/downloadResult');
INSERT INTO `power` VALUES ('148', '算法容器设置默认算法', '/user/setAlgorithmAndGranularity');
INSERT INTO `power` VALUES ('149', 'KMeans算法聚类演示', '/AlgorithmContainer/ClusterByKmeans');
INSERT INTO `power` VALUES ('150', 'Canopy算法聚类演示', '/AlgorithmContainer/ClusterByCanopy');
INSERT INTO `power` VALUES ('151', 'DBScan算法聚类演示', '/AlgorithmContainer/ClusterByDBScan');
INSERT INTO `power` VALUES ('152', '添加映射文件', '/website/importMapUrl');

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
INSERT INTO `role` VALUES ('2', '一般人员');
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
INSERT INTO `role_power` VALUES ('1849', '2', '20');
INSERT INTO `role_power` VALUES ('1850', '2', '21');
INSERT INTO `role_power` VALUES ('1851', '2', '22');
INSERT INTO `role_power` VALUES ('1852', '2', '23');
INSERT INTO `role_power` VALUES ('1853', '2', '24');
INSERT INTO `role_power` VALUES ('1854', '2', '25');
INSERT INTO `role_power` VALUES ('1855', '2', '26');
INSERT INTO `role_power` VALUES ('1856', '2', '27');
INSERT INTO `role_power` VALUES ('1857', '2', '28');
INSERT INTO `role_power` VALUES ('1858', '2', '29');
INSERT INTO `role_power` VALUES ('1859', '2', '30');
INSERT INTO `role_power` VALUES ('1860', '2', '31');
INSERT INTO `role_power` VALUES ('1861', '2', '32');
INSERT INTO `role_power` VALUES ('1862', '2', '33');
INSERT INTO `role_power` VALUES ('1863', '2', '34');
INSERT INTO `role_power` VALUES ('1864', '2', '35');
INSERT INTO `role_power` VALUES ('1865', '2', '36');
INSERT INTO `role_power` VALUES ('1866', '2', '37');
INSERT INTO `role_power` VALUES ('1867', '2', '38');
INSERT INTO `role_power` VALUES ('1868', '2', '39');
INSERT INTO `role_power` VALUES ('1869', '2', '40');
INSERT INTO `role_power` VALUES ('1870', '2', '41');
INSERT INTO `role_power` VALUES ('1871', '2', '42');
INSERT INTO `role_power` VALUES ('1872', '2', '43');
INSERT INTO `role_power` VALUES ('1873', '2', '44');
INSERT INTO `role_power` VALUES ('1874', '2', '45');
INSERT INTO `role_power` VALUES ('1875', '2', '46');
INSERT INTO `role_power` VALUES ('1876', '2', '47');
INSERT INTO `role_power` VALUES ('1877', '2', '48');
INSERT INTO `role_power` VALUES ('1878', '2', '50');
INSERT INTO `role_power` VALUES ('1879', '2', '51');
INSERT INTO `role_power` VALUES ('1880', '2', '52');
INSERT INTO `role_power` VALUES ('1881', '2', '53');
INSERT INTO `role_power` VALUES ('1882', '2', '54');
INSERT INTO `role_power` VALUES ('1883', '2', '55');
INSERT INTO `role_power` VALUES ('1884', '2', '56');
INSERT INTO `role_power` VALUES ('1885', '2', '57');
INSERT INTO `role_power` VALUES ('1886', '2', '58');
INSERT INTO `role_power` VALUES ('1887', '2', '59');
INSERT INTO `role_power` VALUES ('1888', '2', '60');
INSERT INTO `role_power` VALUES ('1889', '2', '61');
INSERT INTO `role_power` VALUES ('1890', '2', '62');
INSERT INTO `role_power` VALUES ('1891', '2', '63');
INSERT INTO `role_power` VALUES ('1892', '2', '64');
INSERT INTO `role_power` VALUES ('1893', '2', '65');
INSERT INTO `role_power` VALUES ('1894', '2', '66');
INSERT INTO `role_power` VALUES ('1895', '2', '67');
INSERT INTO `role_power` VALUES ('1896', '2', '68');
INSERT INTO `role_power` VALUES ('1897', '2', '71');
INSERT INTO `role_power` VALUES ('1898', '2', '72');
INSERT INTO `role_power` VALUES ('1899', '2', '75');
INSERT INTO `role_power` VALUES ('1900', '2', '76');
INSERT INTO `role_power` VALUES ('1901', '2', '77');
INSERT INTO `role_power` VALUES ('1902', '2', '78');
INSERT INTO `role_power` VALUES ('1903', '2', '82');
INSERT INTO `role_power` VALUES ('1904', '2', '83');
INSERT INTO `role_power` VALUES ('1905', '2', '84');
INSERT INTO `role_power` VALUES ('1906', '2', '85');
INSERT INTO `role_power` VALUES ('1907', '2', '89');
INSERT INTO `role_power` VALUES ('1908', '2', '99');
INSERT INTO `role_power` VALUES ('1909', '1', '1');
INSERT INTO `role_power` VALUES ('1910', '1', '2');
INSERT INTO `role_power` VALUES ('1911', '1', '3');
INSERT INTO `role_power` VALUES ('1912', '1', '4');
INSERT INTO `role_power` VALUES ('1913', '1', '5');
INSERT INTO `role_power` VALUES ('1914', '1', '6');
INSERT INTO `role_power` VALUES ('1915', '1', '7');
INSERT INTO `role_power` VALUES ('1916', '1', '8');
INSERT INTO `role_power` VALUES ('1917', '1', '9');
INSERT INTO `role_power` VALUES ('1918', '1', '10');
INSERT INTO `role_power` VALUES ('1919', '1', '11');
INSERT INTO `role_power` VALUES ('1920', '1', '12');
INSERT INTO `role_power` VALUES ('1921', '1', '13');
INSERT INTO `role_power` VALUES ('1922', '1', '14');
INSERT INTO `role_power` VALUES ('1923', '1', '15');
INSERT INTO `role_power` VALUES ('1924', '1', '16');
INSERT INTO `role_power` VALUES ('1925', '1', '17');
INSERT INTO `role_power` VALUES ('1926', '1', '18');
INSERT INTO `role_power` VALUES ('1927', '1', '19');
INSERT INTO `role_power` VALUES ('1928', '1', '20');
INSERT INTO `role_power` VALUES ('1929', '1', '21');
INSERT INTO `role_power` VALUES ('1930', '1', '22');
INSERT INTO `role_power` VALUES ('1931', '1', '23');
INSERT INTO `role_power` VALUES ('1932', '1', '24');
INSERT INTO `role_power` VALUES ('1933', '1', '25');
INSERT INTO `role_power` VALUES ('1934', '1', '26');
INSERT INTO `role_power` VALUES ('1935', '1', '27');
INSERT INTO `role_power` VALUES ('1936', '1', '28');
INSERT INTO `role_power` VALUES ('1937', '1', '29');
INSERT INTO `role_power` VALUES ('1938', '1', '30');
INSERT INTO `role_power` VALUES ('1939', '1', '31');
INSERT INTO `role_power` VALUES ('1940', '1', '32');
INSERT INTO `role_power` VALUES ('1941', '1', '33');
INSERT INTO `role_power` VALUES ('1942', '1', '34');
INSERT INTO `role_power` VALUES ('1943', '1', '35');
INSERT INTO `role_power` VALUES ('1944', '1', '36');
INSERT INTO `role_power` VALUES ('1945', '1', '37');
INSERT INTO `role_power` VALUES ('1946', '1', '38');
INSERT INTO `role_power` VALUES ('1947', '1', '39');
INSERT INTO `role_power` VALUES ('1948', '1', '40');
INSERT INTO `role_power` VALUES ('1949', '1', '41');
INSERT INTO `role_power` VALUES ('1950', '1', '42');
INSERT INTO `role_power` VALUES ('1951', '1', '43');
INSERT INTO `role_power` VALUES ('1952', '1', '44');
INSERT INTO `role_power` VALUES ('1953', '1', '45');
INSERT INTO `role_power` VALUES ('1954', '1', '46');
INSERT INTO `role_power` VALUES ('1955', '1', '47');
INSERT INTO `role_power` VALUES ('1956', '1', '48');
INSERT INTO `role_power` VALUES ('1957', '1', '49');
INSERT INTO `role_power` VALUES ('1958', '1', '50');
INSERT INTO `role_power` VALUES ('1959', '1', '51');
INSERT INTO `role_power` VALUES ('1960', '1', '52');
INSERT INTO `role_power` VALUES ('1961', '1', '53');
INSERT INTO `role_power` VALUES ('1962', '1', '54');
INSERT INTO `role_power` VALUES ('1963', '1', '55');
INSERT INTO `role_power` VALUES ('1964', '1', '56');
INSERT INTO `role_power` VALUES ('1965', '1', '57');
INSERT INTO `role_power` VALUES ('1966', '1', '58');
INSERT INTO `role_power` VALUES ('1967', '1', '59');
INSERT INTO `role_power` VALUES ('1968', '1', '60');
INSERT INTO `role_power` VALUES ('1969', '1', '61');
INSERT INTO `role_power` VALUES ('1970', '1', '62');
INSERT INTO `role_power` VALUES ('1971', '1', '63');
INSERT INTO `role_power` VALUES ('1972', '1', '64');
INSERT INTO `role_power` VALUES ('1973', '1', '65');
INSERT INTO `role_power` VALUES ('1974', '1', '66');
INSERT INTO `role_power` VALUES ('1975', '1', '67');
INSERT INTO `role_power` VALUES ('1976', '1', '68');
INSERT INTO `role_power` VALUES ('1977', '1', '69');
INSERT INTO `role_power` VALUES ('1978', '1', '70');
INSERT INTO `role_power` VALUES ('1979', '1', '71');
INSERT INTO `role_power` VALUES ('1980', '1', '72');
INSERT INTO `role_power` VALUES ('1981', '1', '73');
INSERT INTO `role_power` VALUES ('1982', '1', '74');
INSERT INTO `role_power` VALUES ('1983', '1', '75');
INSERT INTO `role_power` VALUES ('1984', '1', '76');
INSERT INTO `role_power` VALUES ('1985', '1', '77');
INSERT INTO `role_power` VALUES ('1986', '1', '78');
INSERT INTO `role_power` VALUES ('1987', '1', '79');
INSERT INTO `role_power` VALUES ('1988', '1', '80');
INSERT INTO `role_power` VALUES ('1989', '1', '81');
INSERT INTO `role_power` VALUES ('1990', '1', '82');
INSERT INTO `role_power` VALUES ('1991', '1', '83');
INSERT INTO `role_power` VALUES ('1992', '1', '84');
INSERT INTO `role_power` VALUES ('1993', '1', '85');
INSERT INTO `role_power` VALUES ('1994', '1', '86');
INSERT INTO `role_power` VALUES ('1995', '1', '87');
INSERT INTO `role_power` VALUES ('1996', '1', '88');
INSERT INTO `role_power` VALUES ('1997', '1', '89');
INSERT INTO `role_power` VALUES ('1998', '1', '90');
INSERT INTO `role_power` VALUES ('1999', '1', '91');
INSERT INTO `role_power` VALUES ('2000', '1', '92');
INSERT INTO `role_power` VALUES ('2001', '1', '93');
INSERT INTO `role_power` VALUES ('2002', '1', '94');
INSERT INTO `role_power` VALUES ('2003', '1', '95');
INSERT INTO `role_power` VALUES ('2004', '1', '96');
INSERT INTO `role_power` VALUES ('2005', '1', '97');
INSERT INTO `role_power` VALUES ('2006', '1', '98');
INSERT INTO `role_power` VALUES ('2007', '1', '99');
INSERT INTO `role_power` VALUES ('2008', '1', '146');
INSERT INTO `role_power` VALUES ('2009', '1', '147');
INSERT INTO `role_power` VALUES ('2010', '1', '148');
INSERT INTO `role_power` VALUES ('2011', '1', '149');
INSERT INTO `role_power` VALUES ('2012', '1', '150');
INSERT INTO `role_power` VALUES ('2013', '1', '151');
INSERT INTO `role_power` VALUES ('2014', '1', '152');


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
INSERT INTO `user` VALUES ('1', 'niannian', 'niannian', 'niannian@qq.com', '18202757049', '念念', '2017-06-02', '1', '1');
INSERT INTO `user` VALUES ('2', 'zhangzz', 'zhangzz', '1074915263@qq.com', '13226081147', '张志钊', '2017-06-19', '1', '1');
INSERT INTO `user` VALUES ('3', 'chenjie', 'chenjie', '466413559@qq.com', '18202795813', '陈杰', '2017-06-02', '1', '1');
INSERT INTO `user` VALUES ('4', 'chenghu', 'chenghu', '1043595701@qq.com', '15395795687', '程虎', '2017-06-19', '1', '1');
INSERT INTO `user` VALUES ('5', 'test', 'test', '1043595701@qq.com', '18202757085', 'test', '2017-06-02', '1', '1');
INSERT INTO `user` VALUES ('6', 'tankai', 'kkkkkk', '1043595701@qq.com', '17762617656', '谈凯', '2017-06-12', '1', '1');

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
INSERT INTO `user_role` VALUES ('1', '5', '2');
INSERT INTO `user_role` VALUES ('2', '1', '1');
INSERT INTO `user_role` VALUES ('5', '3', '1');
INSERT INTO `user_role` VALUES ('3', '6', '1');
INSERT INTO `user_role` VALUES ('4', '2', '2');
INSERT INTO `user_role` VALUES ('6', '4', '1');

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
