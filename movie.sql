/*
 Navicat Premium Data Transfer

 Source Server         : localmysql
 Source Server Type    : MySQL
 Source Server Version : 80031
 Source Host           : localhost:3306
 Source Schema         : movie

 Target Server Type    : MySQL
 Target Server Version : 80031
 File Encoding         : 65001

 Date: 28/03/2025 15:21:03
*/
DROP DATABASE IF EXISTS movie ;
CREATE DATABASE movie CHARACTER SET utf8;
use movie ;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cinema
-- ----------------------------
DROP TABLE IF EXISTS `cinema`;
CREATE TABLE `cinema`  (
  `cinema_id` bigint NOT NULL AUTO_INCREMENT,
  `cinema_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `cinema_address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`cinema_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '电影院表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cinema
-- ----------------------------
INSERT INTO `cinema` VALUES (1, '大地影院', '顺德区人昌路美的新都荟广场');
INSERT INTO `cinema` VALUES (2, '万达影城', '黄埔区科学城科学大道高德汇购物中心');
INSERT INTO `cinema` VALUES (3, '成龙影城', '白云区钟落潭广从五路钟港大厦');
INSERT INTO `cinema` VALUES (4, '飞扬影城', '天河区天河路228号正佳购物广场');
INSERT INTO `cinema` VALUES (5, '中华广场电影城', '越秀区中山三路33号中华广场8楼');
INSERT INTO `cinema` VALUES (6, '金逸影城', '花都区狮岭镇阳光路丽莎广场七层');
INSERT INTO `cinema` VALUES (7, '测试', 'xxx');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `comment_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NULL DEFAULT NULL,
  `comment_content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `movie_id` bigint NULL DEFAULT NULL,
  `comment_time` datetime(0) NULL DEFAULT NULL,
  `comment_score` int NULL DEFAULT NULL,
  PRIMARY KEY (`comment_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (5, 1, '我觉得这部电影不错我觉得这部电影不错我觉得这部电影不错我觉得这部电影不错我觉得这部电影不错我觉得这部电影不错我觉得这部电影不错我觉得这部电影不错我觉得这部电影不错我觉得这部电影不错我觉得这部电影不错我觉得这部电影不错', 4, '2020-01-02 22:00:00', 9);
INSERT INTO `comment` VALUES (7, 1, '12345', 2, '2020-01-02 22:00:00', 9);
INSERT INTO `comment` VALUES (9, 9, '1234', 3, '2020-01-02 22:00:00', 2);
INSERT INTO `comment` VALUES (13, 9, '2222', 2, '2020-01-02 22:00:00', 9);
INSERT INTO `comment` VALUES (14, 9, '12312313', 2, '2020-01-02 22:00:00', 9);
INSERT INTO `comment` VALUES (15, 9, '123213', 2, '2020-01-02 22:00:00', 9);
INSERT INTO `comment` VALUES (16, 9, '123123', 2, '2020-01-02 22:00:00', 9);
INSERT INTO `comment` VALUES (17, 9, '123123', 2, '2020-01-02 22:00:00', 9);
INSERT INTO `comment` VALUES (18, 9, '123', 2, '2020-01-02 22:00:00', 9);
INSERT INTO `comment` VALUES (19, 9, '1231', 2, '2020-01-02 22:00:00', 9);
INSERT INTO `comment` VALUES (20, 9, '13', 2, '2020-01-02 22:00:00', 9);
INSERT INTO `comment` VALUES (21, 9, '123123', 2, '2020-01-02 22:00:00', 9);
INSERT INTO `comment` VALUES (23, 1, '111111', 2, '2020-01-02 22:00:00', 10);
INSERT INTO `comment` VALUES (24, 1, '12', 6, '2020-01-04 20:28:31', 5);
INSERT INTO `comment` VALUES (25, 1, '13', 7, '2020-01-04 20:28:42', 2);
INSERT INTO `comment` VALUES (26, 1, '14', 8, '2020-01-04 20:28:52', 3);
INSERT INTO `comment` VALUES (27, 1, '15', 9, '2020-01-04 20:28:59', 5);
INSERT INTO `comment` VALUES (28, 1, '16', 10, '2020-01-04 20:29:08', 6);
INSERT INTO `comment` VALUES (29, 1, '17', 11, '2020-01-04 20:29:15', 7);
INSERT INTO `comment` VALUES (31, 1, '18', 16, '2020-01-04 20:30:35', 3);
INSERT INTO `comment` VALUES (32, 1, '19', 17, '2020-01-04 20:30:46', 1);
INSERT INTO `comment` VALUES (33, 1, '18', 11, '2020-01-04 21:41:12', 1);
INSERT INTO `comment` VALUES (34, 9, '2201', 2, '2020-01-04 22:01:35', 9);
INSERT INTO `comment` VALUES (35, 1, '11', 2, '2020-01-05 13:53:44', 1);
INSERT INTO `comment` VALUES (36, 9, '202016', 2, '2020-01-05 13:54:46', 10);
INSERT INTO `comment` VALUES (37, 21, '很好11', 6, '2020-01-11 09:12:11', 9);
INSERT INTO `comment` VALUES (38, 23, '不错', 23, '2021-06-03 11:03:09', 9);
INSERT INTO `comment` VALUES (39, 23, '666', 23, '2021-06-03 11:03:38', 7);

-- ----------------------------
-- Table structure for hall
-- ----------------------------
DROP TABLE IF EXISTS `hall`;
CREATE TABLE `hall`  (
  `hall_id` bigint NOT NULL AUTO_INCREMENT,
  `hall_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `hall_capacity` int NULL DEFAULT NULL,
  `cinema_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`hall_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '放映厅' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hall
-- ----------------------------
INSERT INTO `hall` VALUES (2, '二号厅', 100, 1);
INSERT INTO `hall` VALUES (3, '一号厅', 50, 1);
INSERT INTO `hall` VALUES (4, '三号厅', 100, 1);
INSERT INTO `hall` VALUES (5, '四号厅', 50, 1);
INSERT INTO `hall` VALUES (6, '五号放映厅', 10, 1);
INSERT INTO `hall` VALUES (7, '一号厅', 100, 2);
INSERT INTO `hall` VALUES (8, '2号厅', 50, 2);
INSERT INTO `hall` VALUES (9, '3号厅', 50, 2);
INSERT INTO `hall` VALUES (10, '1号厅', 50, 3);
INSERT INTO `hall` VALUES (11, '2号厅', 50, 3);
INSERT INTO `hall` VALUES (12, '3号厅', 50, 3);
INSERT INTO `hall` VALUES (13, '1号厅', 50, 4);
INSERT INTO `hall` VALUES (14, '2号厅', 50, 4);
INSERT INTO `hall` VALUES (15, '3号厅', 50, 4);
INSERT INTO `hall` VALUES (16, '1号厅', 50, 5);
INSERT INTO `hall` VALUES (17, '2号厅', 50, 5);
INSERT INTO `hall` VALUES (18, '3号厅', 50, 5);
INSERT INTO `hall` VALUES (19, '1号厅', 50, 6);
INSERT INTO `hall` VALUES (20, '2号厅', 50, 6);
INSERT INTO `hall` VALUES (21, '3号厅', 50, 6);

-- ----------------------------
-- Table structure for movie
-- ----------------------------
DROP TABLE IF EXISTS `movie`;
CREATE TABLE `movie`  (
  `movie_id` bigint NOT NULL AUTO_INCREMENT,
  `movie_cn_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `movie_fg_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `movie_actor` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `movie_director` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `movie_detail` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `movie_duration` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `movie_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `movie_score` float(10, 1) NULL DEFAULT NULL,
  `movie_boxOffice` float(10, 2) NULL DEFAULT NULL,
  `movie_commentCount` bigint NULL DEFAULT 0,
  `movie_releaseDate` datetime(0) NULL DEFAULT NULL,
  `movie_picture` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `movie_country` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `movie_state` int NULL DEFAULT NULL,
  PRIMARY KEY (`movie_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '电影表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movie
-- ----------------------------
INSERT INTO `movie` VALUES (2, '叶问4：完结篇', '葉問4', '甄子丹:叶问,吴樾:万宗华,吴建豪:赫文,斯科特·阿金斯:巴顿,李宛妲:若男', '叶伟信', '因故来到美国唐人街的叶问（甄子丹 饰），意外卷入一场当地军方势力与华人武馆的纠纷，面对日益猖狂的民族歧视与压迫，叶问挺身而出，在美国海军陆战队军营拼死一战，以正宗咏春，向世界证明了中国功夫。', '120分钟', '动作', 8.7, NULL, 14, '2019-11-30 00:00:00', '/file/upload/head/53a1f31f-1b86-4fce-9ab9-c07981bff888.jpg', '中国大陆', 1);
INSERT INTO `movie` VALUES (3, '误杀', 'Sheep Without a Shepherd', '肖央:李维杰', '柯文丽', '李维杰（肖央 饰）与妻子阿玉（谭卓 饰）打拼多年，膝下育有两个女儿。一个雨夜，一场意外，打破了这个家庭的宁静。而李维杰作为一个父亲，为了保全自己的家人，他不顾一切地决定瞒天过海……', '112分钟', '剧情 犯罪', 3.7, NULL, 1, '2019-11-29 00:00:00', '/file/upload/movies/c9dfbe5a616041ab8ccf593f46548f92.jpg', '中国大陆', 1);
INSERT INTO `movie` VALUES (4, '宠爱', 'Adoring', '张子枫:江楠,于和伟:高铭,吴磊:陈乐云', '杨子', '电影《宠爱》共由6段温暖的故事组成，不同年龄段的人们，在宠物的陪伴和守护中，收获爱、发现爱，更重新学会爱。在“爱”的主线下，一系列关于亲情、友情、爱情的故事逐一展开。电影《宠爱》将于12月31日，全国公映，陪大家一起温暖跨年。', '108分钟', '喜剧 爱情 剧情', 9.0, NULL, 1, '2020-01-01 00:00:00', '/file/upload/head/a11b37ba-c96d-4ad2-bc92-4215e744914b.jpg', '中国大陆', 1);
INSERT INTO `movie` VALUES (6, '叶问', 'ye2', ':', '叶问2', '', '', '动作', 7.0, NULL, 2, '2020-01-03 00:00:00', '/file/upload/head/f03d48aa-f31c-46b9-a7df-a5b8b676084a.jpg', '大陆', 1);
INSERT INTO `movie` VALUES (7, '中国机长', 'The Captain', '张涵予:刘长健,欧豪:徐奕辰,杜江:梁栋,袁泉:毕男,李沁:周雅文', '刘伟强', '根据2018年5月14日四川航空3U8633航班机组成功处置特情真实事件改编。机组执行航班任务时，在万米高空突遇驾驶舱风挡玻璃爆裂脱落、座舱释压的极端罕见险情，生死关头，他们临危不乱、果断应对、正确处置，确保了机上全部人员的生命安全，创造了世界民航史上的奇迹', '111分钟', '剧情', 2.0, NULL, 1, '2019-09-30 00:00:00', '/file/upload/head/679e5220-af24-4e37-ab23-221b07b6a7c9.jpg', '大陆', 1);
INSERT INTO `movie` VALUES (8, '唐人街探案2', 'Detective Chinatown 2', '王宝强:唐仁,刘昊然:秦风,肖央:宋义,刘承羽:陈英', ' 陈思诚', '秦风接到唐仁的邀请来纽约参加其与阿香的婚礼。壕气逼人的唐仁迎接秦风，极尽招摇。岂料“婚礼”是唐仁为巨额奖金而参加的世界名侦大赛，比赛的内容是寻找杀害唐人街教父七叔的孙子的凶手。 受骗的秦风怒极欲走，却被纽约华人刑警陈英送来的讯息所吸引。七叔孙子的死法离奇，寻人上升为悬赏缉凶。“名侦探”们各显“其能”，鸡飞狗跳。众人调查的同时另一起案件发生，作案手法极其相似。原本锁定的凶手竟有了不在场证明，秦风不禁对自己的推理产生了怀疑。第三起案件发生连环案件。秦风、唐仁二人再次披挂，摆脱各路纠缠，闹翻纽约，几欲接近真相。第四起，与凶手失之交臂，诡计呼之欲出。真凶伏法，动机令人不寒而栗。看似完美结案的背后却隐藏着另一个发人深省的谜题 。', '121分钟', '喜剧 动作 悬疑', 3.0, NULL, 1, '2018-02-16 00:00:00', '/file/upload/head/d9e1bf6e-385f-4a0f-875d-46627e85dd55.jpg', '大陆', 1);
INSERT INTO `movie` VALUES (9, '航海王：狂热行动', 'ONE PIECE STAMPEDE', '田中真弓:蒙奇·D·路飞（配音）,冈村明美:娜美（配音）,中井和哉:罗罗诺亚·索隆（配音）,山口胜平:乌索普（配音）,平田广明:香吉士（配音）', '大塚隆史', '“航海王系列”第14部剧场版，也是《航海王》动画二十周年纪念之作。 以超新星为代表的众多航海家纷纷现身世界最大的航海家庆典——航海世博会。草帽航海团也收到了主办者费斯塔的邀请函，搭乘万里阳光号前往。原以为航海家们的狂热世博会只是为争夺“航海王罗杰留下的宝藏”，就在神秘宝藏争夺战如火如荼之际，阻挡在路飞等人面前的可怕威胁道格拉斯·巴雷特突然现身！暗藏阴谋的敌我混战一触即发……', '101分钟', '动画 冒险', 5.0, NULL, 1, '2019-10-08 00:00:00', '/file/upload/head/c61bbee2-75ee-4bc2-b4c9-d33156dc36e8.jpg', '日本', 1);
INSERT INTO `movie` VALUES (10, 'aa', 'a', 'a:a', 'a', 'a', 'a', '传记', 6.0, NULL, 1, '2100-01-10 00:00:00', '/file/upload/head/3c0a744c-66fa-48fd-9b87-ce170cf7142c.jpg', '大陆', 1);
INSERT INTO `movie` VALUES (11, '勇敢者游戏：决战丛林', 'Jumanji: Welcome to the Jungle', '道恩·强森:斯宾塞,凯文·哈特:弗里奇,杰克·布莱克:贝瑟尼,凯伦·吉兰:玛莎,尼克·乔纳斯:亚历克斯', '杰克·卡斯丹', '本片讲述了四名性格迥异的高中生意外穿越到险象环生的勇敢者游戏中，变身成为与自身性格外貌截然不同的游戏角色：瘦小“弱鸡”斯宾塞变成了大块头冒险家(道恩·强森 饰)，高大威猛的运动员福基变成了身材迷你的龟速行李手 (凯文· 哈特 饰)，万人迷校花贝瑟尼变成一个中年发福教授(杰克·布莱克 饰)，自闭内向的学霸玛莎变成了魅力十足的热辣女打手(凯伦·吉兰 饰)。四人惊魂 未定，就发现更大的危机已经来临：在各类猛兽的恐怖袭击和邪恶势力的夺命追逐中，他们必须要利用自身技能，并肩作战，才能赢得游戏，而这也是他们重返现实的唯一途径⋯⋯', '119分钟', '动作 冒险', 4.0, NULL, 2, '2018-01-12 00:00:00', '/file/upload/head/716578ec-308e-41b9-a581-e7613f7c548f.jpg', '美国', 1);
INSERT INTO `movie` VALUES (13, 'a', 'a', 'a:a', 'a', 'a', 'a', 'a', 0.0, NULL, 0, '2020-01-02 00:00:00', '/file/upload/head/a905a2dc-af5c-4543-9f78-806cb2cad8cd.jpg', 'a', 1);
INSERT INTO `movie` VALUES (14, 'a', 'a', 'a:a', 'a', 'a', 'a', 'a', 0.0, NULL, 0, '2020-01-02 00:00:00', '/file/upload/head/fc25b7bb-b95e-4246-8e24-422b1c302937.jpg', 'a', 1);
INSERT INTO `movie` VALUES (16, '2', '2', '2:2', '2', '2', '2', '2', 3.0, NULL, 1, '2020-01-04 00:00:00', '/file/upload/head/81e455a3-21bb-488f-8ef3-13843751172c.jpg', '2', 1);
INSERT INTO `movie` VALUES (17, '3', '3', '3:3', '3', '3', '3', '3', 1.0, NULL, 1, '2020-01-04 00:00:00', '/file/upload/head/cbac3225-e231-4490-8ad7-360eaed02b75.jpg', '3', 1);
INSERT INTO `movie` VALUES (18, '4', '4', '4:4', '4', '4', '4', '4', 0.0, NULL, 0, '2020-01-04 00:00:00', '/file/upload/head/0ba3641a-94af-4431-a04f-95cf6c0bf019.jpg', '4', 1);
INSERT INTO `movie` VALUES (20, '13', '13', '13:1', '13', '3', '13', '13', 0.0, NULL, 0, '2015-08-08 00:00:00', '/file/upload/head/dd76493e-4f8b-4636-8e7f-a275aef0e95a.jpg', '31', 1);
INSERT INTO `movie` VALUES (21, '红海行动', 'Operation Red Sea', '张译:杨锐,黄景瑜:顾顺,海清:夏楠,杜江:徐宏,蒋璐霞:佟莉', '林超贤', '本片主要讲述了索马里海域外，中国商船遭遇劫持，船员全数沦为阶下囚。蛟龙突击队沉着应对，潜入商船进行突袭，成功解救全部人质。返航途中，非洲北部伊维亚共和国发生政变，恐怖组织连同叛军攻入首都，当地华侨面临危险，海军战舰接到上级命令改变航向，前往执行撤侨任务。蛟龙突击队八人，整装待发。时间紧迫，在“撤侨遇袭可反击，相反则必须避免交火，以免引起外交冲突”的大原则下，海军战舰及蛟龙突击队深入伊维亚，在恶劣的环境之下，借助海陆等多种装备，成功转移等候在码头的中国侨民，并在激烈的遭遇战之后，营救了被恐怖分子追击的中国领事馆巴士。然而事情尚未完结，就在掩护华侨撤离之际，蛟龙突击队收到中国人质被恐怖分子劫持的消息。众人深感责任重大，义无反顾地再度展开营救行动。前方路途险恶，蛟龙突击队即将遭遇的，远不止人质营救那么简单,恐怖分子的惊天阴谋即将浮出水面…..', '138分钟', '剧情 动作', 0.0, NULL, 0, '2018-02-16 00:00:00', '/file/upload/head/3ea74b51-9d77-48b5-9bbb-6ea776e2de56.jpg', '大陆', 1);
INSERT INTO `movie` VALUES (23, '你好，李焕英', 'Hi, Mom', '贾玲:贾晓玲,张小斐:李焕英,沈腾:沈光林', '贾玲', '2001年的某一天，刚刚考上大学的贾晓玲（贾玲 饰）经历了人生中的一次大起大落。一心想要成为母亲骄傲的她却因母亲突遭严重意外，而悲痛万分。在贾晓玲情绪崩溃的状态下，竟意外的回到了1981年，并与年轻的母亲李焕英（张小斐 饰）相遇，二人形影不离，宛如闺蜜。与此同时，也结识了一群天真善良的好朋友。晓玲以为来到了这片“广阔天地”，她可以凭借自己超前的思维，让母亲“大有作为”，但结果却让晓玲感到意外 [3]  。', '128 分钟', '喜剧', 8.0, NULL, 2, '2021-02-11 00:00:00', '/file/upload/head/163d508c-7c7c-47ec-9c2d-d66492a65457.jpg', '中国大陆', 1);

-- ----------------------------
-- Table structure for orderinfo
-- ----------------------------
DROP TABLE IF EXISTS `orderinfo`;
CREATE TABLE `orderinfo`  (
  `order_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `user_id` bigint NULL DEFAULT NULL,
  `schedule_id` bigint NULL DEFAULT NULL,
  `order_position` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `order_state` int NULL DEFAULT NULL,
  `order_price` int NULL DEFAULT NULL,
  `order_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orderinfo
-- ----------------------------
INSERT INTO `orderinfo` VALUES ('2020010100010606', 1, 2, '6排6座', 1, 30, '2020-01-01 16:44:06');
INSERT INTO `orderinfo` VALUES ('2020010100010607', 1, 2, '6排7座', 1, 30, '2020-01-01 16:44:06');
INSERT INTO `orderinfo` VALUES ('2020010100010608', 1, 2, '6排8座', 1, 30, '2020-01-01 16:44:06');
INSERT INTO `orderinfo` VALUES ('2020010100010609', 1, 2, '6排9座', 1, 30, '2020-01-01 16:44:06');
INSERT INTO `orderinfo` VALUES ('2020010100010709', 1, 2, '7排9座', 1, 30, '2020-01-01 16:45:15');
INSERT INTO `orderinfo` VALUES ('2020010100010809', 1, 2, '8排9座', 1, 30, '2020-01-01 16:45:15');
INSERT INTO `orderinfo` VALUES ('2020010100010909', 1, 2, '9排9座', 1, 30, '2020-01-01 16:46:22');
INSERT INTO `orderinfo` VALUES ('2020010100011009', 1, 2, '10排9座', 1, 30, '2020-01-01 16:40:58');
INSERT INTO `orderinfo` VALUES ('2020010200010108', 1, 4, '1排8座', 1, 60, '2020-01-02 14:53:18');
INSERT INTO `orderinfo` VALUES ('2020010200010510', 1, 5, '5排10座', 1, 40, '2020-01-02 14:56:18');
INSERT INTO `orderinfo` VALUES ('2020010200010610', 1, 1, '6排10座', 1, 100, '2020-01-02 13:45:17');
INSERT INTO `orderinfo` VALUES ('2020010200010709', 1, 1, '7排9座', 1, 100, '2020-01-02 13:45:17');
INSERT INTO `orderinfo` VALUES ('2020010200010710', 1, 1, '7排10座', 1, 100, '2020-01-02 13:45:17');
INSERT INTO `orderinfo` VALUES ('2020010200010712', 1, 1, '7排12座', 1, 100, '2020-01-02 13:45:17');
INSERT INTO `orderinfo` VALUES ('2020010200010809', 1, 5, '8排9座', 1, 40, '2020-01-02 14:55:48');
INSERT INTO `orderinfo` VALUES ('2020010200010812', 1, 5, '8排12座', 1, 40, '2020-01-02 14:56:05');
INSERT INTO `orderinfo` VALUES ('2020010200010912', 1, 5, '9排12座', 1, 40, '2020-01-02 14:56:05');
INSERT INTO `orderinfo` VALUES ('2020010200011005', 1, 5, '10排5座', 1, 40, '2020-01-02 14:55:48');
INSERT INTO `orderinfo` VALUES ('2020010200011007', 1, 5, '10排7座', 1, 40, '2020-01-02 14:55:48');
INSERT INTO `orderinfo` VALUES ('2020010200011010', 1, 5, '10排10座', 1, 40, '2020-01-02 14:55:48');
INSERT INTO `orderinfo` VALUES ('2020010200090101', 9, 1, '1排1座', 1, 100, '2020-01-02 15:43:33');
INSERT INTO `orderinfo` VALUES ('2020010200090102', 9, 1, '1排2座', 1, 100, '2020-01-02 15:43:33');
INSERT INTO `orderinfo` VALUES ('2020010200090103', 9, 1, '1排3座', 1, 100, '2020-01-02 15:43:33');
INSERT INTO `orderinfo` VALUES ('2020010400010606', 1, 6, '6排6座', 1, 50, '2020-01-04 10:43:09');
INSERT INTO `orderinfo` VALUES ('2020010400010607', 1, 6, '6排7座', 1, 50, '2020-01-04 10:43:08');
INSERT INTO `orderinfo` VALUES ('2020010400010608', 1, 6, '6排8座', 1, 50, '2020-01-04 10:43:08');
INSERT INTO `orderinfo` VALUES ('2020010400010609', 1, 6, '6排9座', 1, 50, '2020-01-04 10:43:08');
INSERT INTO `orderinfo` VALUES ('2020010400010709', 1, 7, '7排9座', 1, 40, '2020-01-04 21:01:03');
INSERT INTO `orderinfo` VALUES ('2020010500010305', 1, 28, '3排5座', 1, 50, '2020-01-05 20:57:19');
INSERT INTO `orderinfo` VALUES ('2020010500010306', 1, 9, '3排6座', 1, 50, '2020-01-05 22:16:54');
INSERT INTO `orderinfo` VALUES ('2020010500010504', 1, 20, '5排4座', 1, 61, '2020-01-05 14:37:29');
INSERT INTO `orderinfo` VALUES ('2020010500010605', 1, 9, '6排5座', 1, 50, '2020-01-05 22:14:46');
INSERT INTO `orderinfo` VALUES ('2020010500090509', 9, 20, '5排9座', 1, 61, '2020-01-05 14:38:43');
INSERT INTO `orderinfo` VALUES ('2020010500090712', 9, 20, '7排12座', 1, 61, '2020-01-05 14:38:43');
INSERT INTO `orderinfo` VALUES ('2020010500090806', 9, 20, '8排6座', 1, 61, '2020-01-05 14:38:43');
INSERT INTO `orderinfo` VALUES ('2020010500150406', 15, 20, '4排6座', 1, 71, '2020-01-05 14:42:12');
INSERT INTO `orderinfo` VALUES ('2020010500150507', 15, 20, '5排7座', 1, 71, '2020-01-05 14:42:13');
INSERT INTO `orderinfo` VALUES ('2020010500150607', 15, 20, '6排7座', 1, 71, '2020-01-05 14:42:13');
INSERT INTO `orderinfo` VALUES ('2020010500160111', 16, 26, '1排11座', 1, 65, '2020-01-05 14:40:18');
INSERT INTO `orderinfo` VALUES ('2020010500160209', 16, 26, '2排9座', 1, 65, '2020-01-05 14:40:07');
INSERT INTO `orderinfo` VALUES ('2020010500160410', 16, 20, '4排10座', 1, 71, '2020-01-05 14:39:56');
INSERT INTO `orderinfo` VALUES ('2020010600010311', 1, 22, '3排11座', 1, 72, '2020-01-06 16:47:25');
INSERT INTO `orderinfo` VALUES ('2020010600010907', 1, 29, '9排7座', 1, 50, '2020-01-06 13:47:16');
INSERT INTO `orderinfo` VALUES ('2021060300230101', 23, 43, '1排1座', 1, 50, '2021-06-03 11:06:38');
INSERT INTO `orderinfo` VALUES ('2021060300230107', 23, 43, '1排7座', 1, 50, '2021-06-03 11:06:38');

-- ----------------------------
-- Table structure for schedule
-- ----------------------------
DROP TABLE IF EXISTS `schedule`;
CREATE TABLE `schedule`  (
  `schedule_id` bigint NOT NULL AUTO_INCREMENT,
  `hall_id` bigint NULL DEFAULT NULL,
  `movie_id` bigint NULL DEFAULT NULL,
  `schedule_startTime` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `schedule_price` int NULL DEFAULT NULL,
  `schedule_remain` int NULL DEFAULT NULL,
  `schedule_state` int NULL DEFAULT NULL,
  PRIMARY KEY (`schedule_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '场次表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of schedule
-- ----------------------------
INSERT INTO `schedule` VALUES (1, 6, 2, '2019-12-30 09:00', 100, 3, 1);
INSERT INTO `schedule` VALUES (2, 3, 4, '2020-01-02 10:00', 30, 35, 1);
INSERT INTO `schedule` VALUES (3, 5, 2, '2020-01-03 15:00', 50, 0, 1);
INSERT INTO `schedule` VALUES (4, 6, 2, '2020-01-02 00:00', 60, 9, 1);
INSERT INTO `schedule` VALUES (5, 7, 2, '2020-01-03 15:00', 40, 92, 1);
INSERT INTO `schedule` VALUES (6, 2, 2, '2020-01-04 12:00', 60, 96, 1);
INSERT INTO `schedule` VALUES (7, 2, 2, '2020-01-05 00:00', 50, 99, 1);
INSERT INTO `schedule` VALUES (8, 2, 2, '2020-01-04 20:17', 60, 100, 1);
INSERT INTO `schedule` VALUES (9, 2, 2, '2020-01-06 00:00', 60, 97, 1);
INSERT INTO `schedule` VALUES (10, 3, 2, '2020-01-03 00:00', 30, 50, 1);
INSERT INTO `schedule` VALUES (11, 7, 2, '2020-01-05 00:00', 40, 100, 1);
INSERT INTO `schedule` VALUES (12, 6, 2, '2020-01-18 00:00', 120, 10, 1);
INSERT INTO `schedule` VALUES (13, 3, 4, '2020-01-05 00:00', 50, 50, 1);
INSERT INTO `schedule` VALUES (14, 3, 6, '2020-01-04 00:00', 67, 50, 0);
INSERT INTO `schedule` VALUES (15, 2, 6, '2020-01-05 00:00', 67, 100, 0);
INSERT INTO `schedule` VALUES (16, 3, 2, '2020-01-05 20:17', 60, 50, 0);
INSERT INTO `schedule` VALUES (17, 7, 2, '2020-01-05 20:17', 40, 100, 0);
INSERT INTO `schedule` VALUES (18, 3, 2, '2020-01-05 13:17', 20, 50, 0);
INSERT INTO `schedule` VALUES (19, 6, 2, '2020-01-05 00:00', 70, 10, 1);
INSERT INTO `schedule` VALUES (20, 2, 2, '2020-01-05 17:00', 71, 92, 1);
INSERT INTO `schedule` VALUES (21, 3, 2, '2020-01-06 00:00', 81, 50, 1);
INSERT INTO `schedule` VALUES (22, 6, 2, '2020-01-07 00:00', 82, 9, 1);
INSERT INTO `schedule` VALUES (24, 5, 2, '2020-01-07 00:00', 59, 0, 1);
INSERT INTO `schedule` VALUES (25, 2, 2, '2020-01-05 00:00', 65, 100, 0);
INSERT INTO `schedule` VALUES (26, 2, 2, '2020-01-05 17:43', 65, 98, 1);
INSERT INTO `schedule` VALUES (27, 2, 2, '2020-01-05 00:00', 40, 100, 1);
INSERT INTO `schedule` VALUES (28, 7, 2, '2020-01-06 00:00', 60, 99, 0);
INSERT INTO `schedule` VALUES (29, 3, 2, '2020-01-07 00:00', 60, 49, 1);
INSERT INTO `schedule` VALUES (30, 6, 2, '2020-01-08 00:00', 6, 10, 0);
INSERT INTO `schedule` VALUES (31, 2, 2, '2020-01-09 00:00', 80, 100, 1);
INSERT INTO `schedule` VALUES (32, 3, 2, '2020-01-06 13:58', 50, 50, 1);
INSERT INTO `schedule` VALUES (33, 7, 2, '2020-01-07 00:00', 60, 100, 1);
INSERT INTO `schedule` VALUES (34, 10, 2, '2020-01-07 00:00', 70, 50, 1);
INSERT INTO `schedule` VALUES (35, 13, 2, '2020-01-07 00:00', 80, 50, 1);
INSERT INTO `schedule` VALUES (36, 16, 2, '2020-01-07 00:00', 77, 50, 1);
INSERT INTO `schedule` VALUES (37, 20, 2, '2020-01-07 00:00', 55, 50, 1);
INSERT INTO `schedule` VALUES (38, 3, 2, '2020-01-07 01:00', 30, 50, 1);
INSERT INTO `schedule` VALUES (39, 4, 2, '2020-01-07 02:00', 33, 100, 1);
INSERT INTO `schedule` VALUES (40, 5, 2, '2020-01-07 04:00', 50, 50, 1);
INSERT INTO `schedule` VALUES (41, 6, 2, '2020-01-07 02:00', 30, 10, 1);
INSERT INTO `schedule` VALUES (42, 6, 2, '2020-01-07 03:00', 34, 10, 1);
INSERT INTO `schedule` VALUES (43, 7, 23, '2021-06-04 00:00', 50, 98, 1);

-- ----------------------------
-- Table structure for sys_bill
-- ----------------------------
DROP TABLE IF EXISTS `sys_bill`;
CREATE TABLE `sys_bill`  (
  `bill_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '订单编号',
  `pay_state` tinyint NOT NULL DEFAULT 0 COMMENT '支付状态，0未支付，1已支付',
  `cancel_state` tinyint NOT NULL DEFAULT 0 COMMENT '取消状态，0未取消，1取消',
  `user_id` bigint UNSIGNED NOT NULL COMMENT '用户编号',
  `session_id` bigint UNSIGNED NOT NULL COMMENT '场次编号',
  `seats` json NOT NULL COMMENT '购买的座位号',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `deadline` datetime(0) NULL DEFAULT NULL COMMENT '失效时间',
  `cancel_time` datetime(0) NULL DEFAULT NULL COMMENT '取消时间',
  PRIMARY KEY (`bill_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 114 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_bill
-- ----------------------------
INSERT INTO `sys_bill` VALUES (112, 1, 0, 30, 75, '[\"1排8座\"]', '2024-03-22 21:07:49', '2024-03-22 21:22:41', NULL);
INSERT INTO `sys_bill` VALUES (113, 1, 0, 30, 76, '[\"3排7座\", \"3排8座\"]', '2024-03-22 21:08:55', '2024-03-22 21:23:51', NULL);
INSERT INTO `sys_bill` VALUES (114, 1, 0, 30, 76, '[\"3排4座\"]', '2024-03-22 21:37:51', '2024-03-22 21:52:19', NULL);

-- ----------------------------
-- Table structure for sys_cinema
-- ----------------------------
DROP TABLE IF EXISTS `sys_cinema`;
CREATE TABLE `sys_cinema`  (
  `cinema_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '影院编号',
  `cinema_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '影院名称',
  `hall_category_list` json NULL COMMENT '拥有影厅类别',
  `cinema_picture` json NULL COMMENT '影院图片',
  `cinema_phone` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '影院电话',
  `cinema_address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '影院地址',
  `work_start_time` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '开始营业时间',
  `work_end_time` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '结束营业时间',
  PRIMARY KEY (`cinema_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_cinema
-- ----------------------------
INSERT INTO `sys_cinema` VALUES (1, '影院购票', '[\"激光厅\", \"IMAX厅\", \"4DX厅\", \"DTS:X 临镜音厅\", \"儿童厅\", \"4K厅\", \"60帧厅\", \"巨幕厅\", \"MX4D厅\", \"私人定制\", \"5D\"]', '[\"/images/cinema/2024/03/09/039c3745985643a7a22406cd2d6581b9.jpg\"]', '088-80888848', '湖南机电旁', '00:00', '23:59');

-- ----------------------------
-- Table structure for sys_hall
-- ----------------------------
DROP TABLE IF EXISTS `sys_hall`;
CREATE TABLE `sys_hall`  (
  `hall_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '影厅编号',
  `cinema_id` bigint UNSIGNED NOT NULL DEFAULT 1 COMMENT '影院编号',
  `hall_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '影厅名称',
  `hall_category` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '影厅类别',
  `row_start` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '1' COMMENT '排开始编号',
  `row_nums` smallint UNSIGNED NOT NULL DEFAULT 10 COMMENT '总排数',
  `seat_nums_row` smallint UNSIGNED NOT NULL DEFAULT 18 COMMENT '每排的座位数',
  `seat_nums` smallint UNSIGNED NOT NULL DEFAULT 180 COMMENT '总可用座位数',
  `seat_state` json NOT NULL COMMENT '座位的状态',
  `del_state` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`hall_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_hall
-- ----------------------------
INSERT INTO `sys_hall` VALUES (1, 1, '1号激光厅', '激光厅', '1', 10, 10, 100, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 0);
INSERT INTO `sys_hall` VALUES (2, 1, '2号厅', 'IMAX厅', '1', 10, 11, 110, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 0);
INSERT INTO `sys_hall` VALUES (3, 1, '3号厅', '杜比全景声厅', '1', 7, 7, 49, '{\"1\": [0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0]}', 0);
INSERT INTO `sys_hall` VALUES (4, 1, '4号厅', 'RealD 6FLag厅', '1', 15, 15, 225, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"11\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"12\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"13\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"14\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"15\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 0);
INSERT INTO `sys_hall` VALUES (5, 1, '5号厅', 'DTS:X 临镜音厅', '1', 10, 10, 92, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [1, 0, 0, 0, 0, 0, 0, 0, 0, 1], \"8\": [1, 0, 0, 0, 0, 0, 0, 0, 0, 1], \"9\": [1, 0, 0, 0, 0, 0, 0, 0, 0, 1], \"10\": [1, 0, 0, 0, 0, 0, 0, 0, 0, 1]}', 0);
INSERT INTO `sys_hall` VALUES (6, 1, '6号厅', '巨幕厅', '1', 18, 18, 324, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"11\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"12\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"13\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"14\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"15\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"16\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"17\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"18\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 0);
INSERT INTO `sys_hall` VALUES (7, 1, '7号IMAX4D厅', 'MX4D厅', '1', 15, 18, 246, '{\"1\": [1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1], \"2\": [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1], \"3\": [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"11\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"12\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"13\": [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1], \"14\": [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1], \"15\": [1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1]}', 0);
INSERT INTO `sys_hall` VALUES (8, 1, '8号厅', '激光厅', '1', 10, 15, 100, '{\"1\": [0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1], \"2\": [0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1], \"3\": [0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1], \"4\": [0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1], \"5\": [0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1], \"6\": [0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1], \"7\": [0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1], \"8\": [0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1], \"9\": [0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1], \"10\": [0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1]}', 0);
INSERT INTO `sys_hall` VALUES (9, 1, '9号IMAX厅', 'IMAX厅', '1', 18, 18, 324, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"11\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"12\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"13\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"14\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"15\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"16\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"17\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"18\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 0);
INSERT INTO `sys_hall` VALUES (10, 1, '10号激光厅', '激光厅', '1', 10, 15, 150, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 0);
INSERT INTO `sys_hall` VALUES (42, 1, '私人定制', '4DX厅', '3', 10, 10, 100, '{\"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"11\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"12\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 0);

-- ----------------------------
-- Table structure for sys_movie
-- ----------------------------
DROP TABLE IF EXISTS `sys_movie`;
CREATE TABLE `sys_movie`  (
  `movie_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '电影编号',
  `movie_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '电影名称',
  `movie_length` int NULL DEFAULT NULL COMMENT '电影时长',
  `movie_poster` varchar(10000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电影海报',
  `movie_area` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电影区域',
  `release_date` datetime(0) NULL DEFAULT NULL COMMENT '上映时间',
  `movie_box_office` decimal(20, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '电影总票房',
  `movie_introduction` varchar(10000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电影简介',
  `movie_pictures` json NULL COMMENT '电影图集',
  `del_state` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`movie_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_movie
-- ----------------------------
INSERT INTO `sys_movie` VALUES (1, '长津湖', 176, '[\"/images/movie/2024/03/09/472a712daf074850ad12c5a7e60c6d9f.jpg\"]', '中国大陆', '2024-03-10 09:30:00', 1000269.00, '电影《长津湖》以抗美援朝战争第二次战役中的长津湖战役为背景，讲述了一段波澜壮阔的历史：71年前，中国人民志愿军赴朝作战，在极寒严酷环境下，东线作战部队凭着钢铁意志和英勇无畏的战斗精神一路追击，奋勇杀敌，扭转了战场态势，打出了军威国威。', '[\"/images/movie/2024/03/09/14ec328423b24574b4215a0db87fe874.jpg\"]', 0);
INSERT INTO `sys_movie` VALUES (2, '狙击手', 96, '[\"/images/movie/2024/03/09/ff438c494d2043f7ba943d41dcc65a92.jpg\"]', '中国大陆', '2024-03-08 08:00:00', 100335.00, '影片根据抗美援朝战争“冷枪冷炮”运动中神枪手群体事迹改编。1952年冬至1953年初，中国人民志愿军与联合国军在朝鲜战场形成僵持，双方发起了低强度的密集狙击战，史称“冷枪冷炮运动”。在连长（张译 饰）带领下的狙击五班战士枪法过人，成为敌军的心头大患，班长刘文武（章宇 饰）更成为重点狙击对象。为重创狙击五班，敌方调配精英狙击小队，配以最先进的武器装备，更迫使狙击五班战士大永（陈永胜 饰）等人为救同伴进入其设好的险境之地。但正当敌军打响自己如意算盘之时，他们未料到，被他们当作诱饵的侦察兵亮亮（刘奕铁 饰）身上其实隐藏着更大的秘密......', '[]', 0);
INSERT INTO `sys_movie` VALUES (3, '长津湖之水门桥', 149, '[\"/images/movie/2024/03/09/bb330b1c87c244adb53fc67a45360ab8.png\"]', '中国大陆', '2024-02-01 08:00:00', 9999999.00, '电影《长津湖之水门桥》以抗美援朝战争第二次战役中的长津湖战役为背景，讲述了在结束了新兴里和下碣隅里的战斗之后，七连战士们又接到了更艰巨的任务.....', '[\"/images/movie/2024/03/09/16a1afa442b746dfa558293d0759bd45.jpg\", \"/images/movie/2024/03/09/a68eaea237314497ad612471a5ff88bd.jpg\", \"/images/movie/2024/03/09/5afd6cf4e05a46379a47db2c14969f90.jpg\", \"/images/movie/2024/03/09/1e708013824e4ce58aeb2d30205c1c0a.jpg\"]', 0);
INSERT INTO `sys_movie` VALUES (4, '奇迹·笨小孩', 106, '[\"/images/movie/2024/03/09/b2184aa3ceff4a4e885e37939600002a.jpg\"]', '中国大陆', '2024-03-06 08:00:00', 889344.00, '二十岁的景浩（易烊千玺 饰）独自带着年幼的妹妹来到深圳生活，兄妹俩生活温馨却拮据。机缘巧合之下，景浩得到一个机会，本以为美好生活即将来临，却不料遭遇重创。在时间和金钱的双重压力下，毫无退路的景浩决定孤注一掷，而他陷入困境的平凡人生，又能否燃起希望的火花？电影《奇迹·笨小孩》是中宣部国家电影局 2021 年重点电影项目，也是 2021 年重点建党百年献礼片，描述十八大以后新时代年轻人在深圳创业的影片。', '[\"/images/movie/2024/03/09/51c7a41449ba4663b1d82e5e1bfdc510.jpg\"]', 0);
INSERT INTO `sys_movie` VALUES (5, ' 断·桥', 148, '[\"/images/movie/2024/03/09/f6b8dc9065614874957083002da63b2f.jpg\"]', '中国大陆', '2024-06-02 00:00:00', 0.00, '黄雀市大桥突然垮塌，桥墩中一副被活埋多年的人骨赫然惊现。死者女儿闻晓雨（马思纯 饰）为追查父亲死因，得到一个自称孟超（王俊凯 饰）的男孩协助，并携手走上探寻真相与复仇之路。渐渐地，他们发现，闻晓雨的养父朱方正（范伟 饰）很可能就是杀人凶手，而他背后似乎隐藏着惊天的秘密…', '[\"/images/movie/2024/03/09/0efbcde195184fa1b25fa3a828cd1a47.jpg\"]', 0);
INSERT INTO `sys_movie` VALUES (6, '维和防暴队', 120, '[\"/images/movie/2024/03/09/8318b3cc8f254e9096f4b90d93975221.jpg\"]', '中国大陆', '2024-05-05 00:00:00', 0.00, '影片聚焦中国维和警察，讲述中国维和警察防暴队在海外执行任务的故事。他们头戴蓝盔，全副武装，在危险中前行，枕着枪声入眠，只为维护世界的安全与和平。这一次，维和防暴队的成员们将如何应对全新的严峻挑战……', '[]', 0);
INSERT INTO `sys_movie` VALUES (7, '神秘海域', 169, '[\"/images/movie/2024/03/09/e779ab034a6a453887bce7b1034bf174.jpg\"]', '美国', '2024-03-14 09:00:00', 0.00, '足智多谋的内森·德雷克（汤姆·赫兰德 饰）和经验丰富的寻宝者维克多·苏利文（马克·沃尔伯格 饰）组成搭档，追寻费迪南·麦哲伦500年前遗失的宝藏。一开始，这似乎只是个简单的寻宝工作，但很快演变成了一场惊险刺激、横跨全球的竞赛。他们必须赶在冷酷无情的蒙卡达（安东尼奥·班德拉斯 饰）之前寻得宝藏。蒙卡达坚信他和他的家族才是宝藏的正当继承人。若内森和苏利文能破译线索，解开这世界上最古老的谜团，他们便能找到价值50亿美元的宝藏，甚至还可能找到内森失踪已久的哥哥…但首先，他们必须学会通力合作。', '[\"/images/movie/2024/03/09/193302ea8eaa407b9e463d271ff18c11.jpg\"]', 0);
INSERT INTO `sys_movie` VALUES (8, '外太空的莫扎特', 120, '[\"/images/movie/2024/03/09/a54b5d0a76f2405995beb5ca0af4edfb.jpg\"]', '中国大陆', '2024-04-01 00:00:00', 0.00, '任大望（黄渤 饰）一心想把喜好天文的儿子任小天（荣梓杉 饰）培养成钢琴演奏家，为此父子争吵不断。一天，神秘外星人莫扎特意外出现，从此，莫扎特帮助任小天开启了和爸爸“斗智斗勇”的生活。令任小天没有想到的是，莫扎特来到地球竟另有任务……', '[]', 0);
INSERT INTO `sys_movie` VALUES (9, '明日战记', 136, '[\"/images/movie/2024/03/09/98e5ef3869b94e6aa120ceab3abd9dd9.jpg\"]', '中国香港', '2024-05-05 00:00:00', 0.00, '《明日战记》的故事设定在2055年，那时候的地球深受污染和全球变暖问题的困扰，一颗陨石击中地球，带来一种快速生长的触须类外星生物，它在净化地球的同时，也在杀死一切生命。拯救地球的任务落在了一支精英部队身上。在与外星生物作战的同时，他们也发现了一个惊天阴谋……', '[]', 0);
INSERT INTO `sys_movie` VALUES (10, '龙马精神', 142, '[\"/images/movie/2024/03/09/029b9834fd5c42b289a5ea94612cd80d.jpg\"]', '中国大陆', '2024-12-31 00:00:00', 0.00, '曾经风光一时，如今落魄的龙虎武师老罗（成龙 饰）与爱马赤兔相依为命。因赤兔卷入了一起债务纠纷，面临着“父子分离”的危机。情急之下，老罗向存在多年误会的女儿小宝（刘浩存 饰）和其男友乃华（郭麒麟 饰）求救。在三人一马的自救之路中，闹出不少笑话，也渐渐靠近彼此……', '[\"/images/movie/2024/03/09/bcf4783fac944b2aa02c8523af081862.jpg\"]', 0);
INSERT INTO `sys_movie` VALUES (11, '我和我的祖国', 155, '[\"/images/movie/2024/03/09/f85926f452864b01a8f54347c1a5b7d7.jpg\"]', '中国大陆', '2021-10-01 00:00:00', 1000000133.00, '七位导演分别取材新中国成立70周年以来，祖国经历的无数个历史性经典瞬间。讲述普通人与国家之间息息相关密不可分的动人故事。聚焦大时代大事件下，小人物和国家之间，看似遥远实则密切的关联，唤醒全球华人共同回忆。', '[]', 0);
INSERT INTO `sys_movie` VALUES (12, '速度与激情9', 142, '[\"/images/movie/2024/03/09/f6ffc5ecedd942249aab0076c34c18f9.jpg\"]', '美国', '2021-05-21 00:00:00', 156487.00, '范·迪塞尔饰演的唐老大多姆·托莱多，与莱蒂和他的儿子小布莱恩，过上了远离纷扰的平静生活。然而他们也知道，安宁之下总潜藏着危机。这一次，为了保护他所爱的人，唐老大不得不直面过去。他和伙伴们面临的是一场足以引起世界动荡的阴谋，以及一个前所未遇的一流杀手和高能车手。而这个名叫雅各布（约翰·塞纳饰）的人，恰巧是多姆遗落在外的亲弟弟。', '[]', 0);
INSERT INTO `sys_movie` VALUES (13, ' 指环王：双塔奇兵', 182, '[\"/images/movie/2024/03/09/c8e3942d78f84a6ba0136df334f02639.jpg\"]', '美国', '2012-03-09 14:42:54', 260.00, '护戒联盟中的哈比人梅里与皮平被奥克斯掳走，护戒使者们不得不分头行事。弗拉多与好友山姆继续向索隆领地莫都进发，途中他们制服了也在疯狂寻找魔戒的怪物 古鲁姆，魔戒曾经为他带来了长寿与隐身之道直到弗拉多的前辈毕尔博拿走了这枚戒指。', '[]', 0);
INSERT INTO `sys_movie` VALUES (14, '复仇者联盟4：终局之战', 180, '[\"/images/movie/2024/03/09/6f10d729472549bf9f4cf2fb48436174.jpg\"]', '美国', '2019-04-24 00:00:00', 865492.00, '来自泰坦星的 灭霸为了解决宇宙资源匮乏、人口暴增的问题，集齐了所有 无限宝石，一个响指成功地使全宇宙生命随机减半。宇宙由于灭霸的行动而变得满目疮痍，但是五年之后，被困在量子领域的 蚁人意外回到现实世界，他的出现为幸存的复仇者点燃了希望。无备捆拔论前方将遭遇怎样的后果，幸存的复仇者都必须在剩余盟友的帮助下再一次集结，以逆转灭霸的所作所为，彻底恢复宇宙的秩序。', '[\"/images/movie/2024/03/09/06ab257ccdb547a38383f20d2670c1aa.jpg\"]', 0);
INSERT INTO `sys_movie` VALUES (15, ' 这个杀手不太冷静', 109, '[\"/images/movie/2024/03/09/1765f51dc9264a639d75d284aad201ec.jpg\"]', '中国大陆', '2024-03-08 00:00:00', 420.00, '马丽魏翔上演2024开年第一喜剧，平台高分好评如潮！《夏洛特烦恼》《西虹市首富》导演闫非、彭大魔监制，邢文雄执导，马丽、魏翔等喜剧人主演，携手打造爆笑“杀手奇遇”！小人物龙套演员魏成功（魏翔 饰）得到当红女星米兰（马丽 饰）“赏识”，被邀请出演男一号神秘杀手，却没想到这一切竟是一场危机四伏的“戏中戏”、“局中局”。被蒙在鼓里的魏成功数次凭借自己的演技和好运化险为夷，而这场阴谋却逐渐失控，残酷的真相也离他越来越近……', '[\"/images/movie/2024/03/09/85b0fd94ba49451d89cdb82b56cc9660.jpg\"]', 0);
INSERT INTO `sys_movie` VALUES (16, '我们的冬奥', 90, '[\"/images/movie/2024/03/09/81d6e01f0b094708920f42eaa45dd264.jpg\"]', '中国大陆', '2024-03-08 00:00:00', 132.00, '冰墩墩雪容融领衔主演，冬奥会唯一授权动画电影，打造年后最好看的动画电影! 小光头强与小熊大熊二帮冰墩墩雪容融从暴风雪中脱险成功参加奥运村的开村典礼；九月偶然“捡到”冰墩墩，将其送回的同时收获完美假期；小虎妞在玩具的鼓励下勇敢面对挑战；大圣借“冰器”时遇到图图一起参加天宫冰雪大会。从孙悟空到非人哉，片中集合30多位知名IP动画角色热血集结，唤醒五代人的童年回忆。', '[\"/images/movie/2024/03/09/426c0e98c9304ab5a480e92f0a2ab47e.jpg\"]', 0);
INSERT INTO `sys_movie` VALUES (46, '1', 1111, '[]', '中国大陆', '2024-03-31 00:00:00', 0.00, '11', '[]', 1);

-- ----------------------------
-- Table structure for sys_movie_category
-- ----------------------------
DROP TABLE IF EXISTS `sys_movie_category`;
CREATE TABLE `sys_movie_category`  (
  `movie_category_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '电影类别编号',
  `movie_category_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '电影类别名称',
  PRIMARY KEY (`movie_category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_movie_category
-- ----------------------------
INSERT INTO `sys_movie_category` VALUES (1, '爱情');
INSERT INTO `sys_movie_category` VALUES (2, '喜剧');
INSERT INTO `sys_movie_category` VALUES (3, '动画');
INSERT INTO `sys_movie_category` VALUES (4, '剧情');
INSERT INTO `sys_movie_category` VALUES (5, '恐怖');
INSERT INTO `sys_movie_category` VALUES (6, '动作');
INSERT INTO `sys_movie_category` VALUES (7, '科幻');
INSERT INTO `sys_movie_category` VALUES (8, '悬疑');
INSERT INTO `sys_movie_category` VALUES (9, '惊悚');
INSERT INTO `sys_movie_category` VALUES (10, '犯罪');
INSERT INTO `sys_movie_category` VALUES (11, '冒险');
INSERT INTO `sys_movie_category` VALUES (12, '战争');
INSERT INTO `sys_movie_category` VALUES (13, '奇幻');
INSERT INTO `sys_movie_category` VALUES (14, '运动');
INSERT INTO `sys_movie_category` VALUES (15, '励志');
INSERT INTO `sys_movie_category` VALUES (16, '古装');
INSERT INTO `sys_movie_category` VALUES (17, '武侠');
INSERT INTO `sys_movie_category` VALUES (19, '历史');

-- ----------------------------
-- Table structure for sys_movie_to_category
-- ----------------------------
DROP TABLE IF EXISTS `sys_movie_to_category`;
CREATE TABLE `sys_movie_to_category`  (
  `movie_id` bigint UNSIGNED NOT NULL COMMENT '电影编号',
  `movie_category_id` bigint UNSIGNED NOT NULL COMMENT '电影类别编号',
  PRIMARY KEY (`movie_id`, `movie_category_id`) USING BTREE,
  INDEX `movie_category_id`(`movie_category_id`) USING BTREE,
  CONSTRAINT `sys_movie_to_category_ibfk_1` FOREIGN KEY (`movie_category_id`) REFERENCES `sys_movie_category` (`movie_category_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_movie_to_category
-- ----------------------------
INSERT INTO `sys_movie_to_category` VALUES (10, 2);
INSERT INTO `sys_movie_to_category` VALUES (15, 2);
INSERT INTO `sys_movie_to_category` VALUES (16, 3);
INSERT INTO `sys_movie_to_category` VALUES (2, 4);
INSERT INTO `sys_movie_to_category` VALUES (4, 4);
INSERT INTO `sys_movie_to_category` VALUES (8, 4);
INSERT INTO `sys_movie_to_category` VALUES (11, 4);
INSERT INTO `sys_movie_to_category` VALUES (16, 4);
INSERT INTO `sys_movie_to_category` VALUES (7, 6);
INSERT INTO `sys_movie_to_category` VALUES (13, 6);
INSERT INTO `sys_movie_to_category` VALUES (14, 6);
INSERT INTO `sys_movie_to_category` VALUES (12, 10);
INSERT INTO `sys_movie_to_category` VALUES (7, 11);
INSERT INTO `sys_movie_to_category` VALUES (12, 11);
INSERT INTO `sys_movie_to_category` VALUES (13, 11);
INSERT INTO `sys_movie_to_category` VALUES (1, 12);
INSERT INTO `sys_movie_to_category` VALUES (2, 12);
INSERT INTO `sys_movie_to_category` VALUES (3, 12);
INSERT INTO `sys_movie_to_category` VALUES (8, 13);
INSERT INTO `sys_movie_to_category` VALUES (9, 13);
INSERT INTO `sys_movie_to_category` VALUES (14, 13);
INSERT INTO `sys_movie_to_category` VALUES (4, 15);
INSERT INTO `sys_movie_to_category` VALUES (1, 19);
INSERT INTO `sys_movie_to_category` VALUES (2, 19);
INSERT INTO `sys_movie_to_category` VALUES (3, 19);

-- ----------------------------
-- Table structure for sys_resource
-- ----------------------------
DROP TABLE IF EXISTS `sys_resource`;
CREATE TABLE `sys_resource`  (
  `resource_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '资源编号',
  `resource_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '菜单名称',
  `path` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '菜单路径，用于保存页面地址',
  `level` int UNSIGNED NOT NULL DEFAULT 1 COMMENT '资源权限等级,1表示该资源为最高级权限',
  `parent_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '当前菜单父菜单编号',
  PRIMARY KEY (`resource_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 622 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_resource
-- ----------------------------
INSERT INTO `sys_resource` VALUES (1, '影院管理', '', 1, 0);
INSERT INTO `sys_resource` VALUES (2, '电影管理', '', 1, 0);
INSERT INTO `sys_resource` VALUES (3, '影厅管理', '', 1, 0);
INSERT INTO `sys_resource` VALUES (4, '订单管理', '', 1, 0);
INSERT INTO `sys_resource` VALUES (5, '用户管理', '', 1, 0);
INSERT INTO `sys_resource` VALUES (6, '权限管理', '', 1, 0);
INSERT INTO `sys_resource` VALUES (11, '影院信息管理', 'cinema', 2, 1);
INSERT INTO `sys_resource` VALUES (21, '电影信息管理', 'movie', 2, 2);
INSERT INTO `sys_resource` VALUES (22, '电影类别管理', 'movieCategory', 2, 2);
INSERT INTO `sys_resource` VALUES (31, '影厅信息管理', 'hall', 2, 3);
INSERT INTO `sys_resource` VALUES (32, '场次信息管理', 'session', 2, 3);
INSERT INTO `sys_resource` VALUES (41, '订单信息管理', 'bill', 2, 4);
INSERT INTO `sys_resource` VALUES (51, '用户信息管理', 'user', 2, 5);
INSERT INTO `sys_resource` VALUES (61, '角色信息管理', 'role', 2, 6);
INSERT INTO `sys_resource` VALUES (62, '资源信息管理', 'resource', 2, 6);
INSERT INTO `sys_resource` VALUES (111, '查询影院信息权限', '', 3, 11);
INSERT INTO `sys_resource` VALUES (112, '修改影院信息权限', '', 3, 11);
INSERT INTO `sys_resource` VALUES (211, '查询电影信息权限', '', 3, 21);
INSERT INTO `sys_resource` VALUES (212, '修改电影信息权限', '', 3, 21);
INSERT INTO `sys_resource` VALUES (221, '查询电影类别权限', '', 3, 22);
INSERT INTO `sys_resource` VALUES (222, '修改电影类别权限', '', 3, 22);
INSERT INTO `sys_resource` VALUES (311, '查询影厅信息权限', '', 3, 31);
INSERT INTO `sys_resource` VALUES (312, '修改影厅信息权限', '', 3, 31);
INSERT INTO `sys_resource` VALUES (321, '查询场次信息权限', '', 3, 32);
INSERT INTO `sys_resource` VALUES (322, '修改场次信息权限', '', 3, 32);
INSERT INTO `sys_resource` VALUES (411, '查询订单信息权限', '', 3, 41);
INSERT INTO `sys_resource` VALUES (412, '修改订单信息权限', '', 3, 41);
INSERT INTO `sys_resource` VALUES (511, '查询用户信息权限', '', 3, 51);
INSERT INTO `sys_resource` VALUES (512, '修改用户信息权限', '', 3, 51);
INSERT INTO `sys_resource` VALUES (611, '查询角色信息权限', '', 3, 61);
INSERT INTO `sys_resource` VALUES (612, '修改角色信息权限', '', 3, 61);
INSERT INTO `sys_resource` VALUES (621, '查询资源信息权限', '', 3, 62);
INSERT INTO `sys_resource` VALUES (622, '修改资源信息权限', '', 3, 62);

-- ----------------------------
-- Table structure for sys_resource_copy
-- ----------------------------
DROP TABLE IF EXISTS `sys_resource_copy`;
CREATE TABLE `sys_resource_copy`  (
  `resource_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '资源编号',
  `resource_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '菜单名称',
  `path` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '菜单路径，用于保存页面地址',
  `level` int UNSIGNED NOT NULL DEFAULT 1 COMMENT '资源权限等级,1表示该资源为最高级权限',
  `parent_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '当前菜单父菜单编号',
  PRIMARY KEY (`resource_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 62 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_resource_copy
-- ----------------------------
INSERT INTO `sys_resource_copy` VALUES (1, '影院管理', '', 1, 0);
INSERT INTO `sys_resource_copy` VALUES (2, '电影管理', '', 1, 0);
INSERT INTO `sys_resource_copy` VALUES (3, '影厅管理', '', 1, 0);
INSERT INTO `sys_resource_copy` VALUES (4, '订单管理', '', 1, 0);
INSERT INTO `sys_resource_copy` VALUES (5, '用户管理', '', 1, 0);
INSERT INTO `sys_resource_copy` VALUES (6, '权限管理', '', 1, 0);
INSERT INTO `sys_resource_copy` VALUES (11, '影院信息管理', 'cinema', 2, 1);
INSERT INTO `sys_resource_copy` VALUES (21, '电影信息管理', 'movie', 2, 2);
INSERT INTO `sys_resource_copy` VALUES (22, '电影类别管理', 'movieCategory', 2, 2);
INSERT INTO `sys_resource_copy` VALUES (31, '影厅信息管理', 'hall', 2, 3);
INSERT INTO `sys_resource_copy` VALUES (32, '场次信息管理', 'session', 2, 3);
INSERT INTO `sys_resource_copy` VALUES (41, '订单信息管理', 'bill', 2, 4);
INSERT INTO `sys_resource_copy` VALUES (51, '用户信息管理', 'user', 2, 5);
INSERT INTO `sys_resource_copy` VALUES (61, '角色信息管理', 'role', 2, 6);
INSERT INTO `sys_resource_copy` VALUES (62, '资源信息管理', 'resource', 2, 6);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '角色编号',
  `role_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '角色名称',
  `role_desc` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '角色描述',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '系统管理员', '管理整个影院在线售票系统');
INSERT INTO `sys_role` VALUES (2, '影院管理员', '管理其所属的影院的相关信息');
INSERT INTO `sys_role` VALUES (3, '用户', '用户，仅能使用前台浏览相关信息、下单、修改个人信息等功能');

-- ----------------------------
-- Table structure for sys_role_resource
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_resource`;
CREATE TABLE `sys_role_resource`  (
  `role_id` bigint UNSIGNED NOT NULL COMMENT '角色编号',
  `resource_id` bigint UNSIGNED NOT NULL COMMENT '资源编号，只以3级权限作为权限判断的依据',
  PRIMARY KEY (`role_id`, `resource_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_resource
-- ----------------------------
INSERT INTO `sys_role_resource` VALUES (1, 111);
INSERT INTO `sys_role_resource` VALUES (1, 112);
INSERT INTO `sys_role_resource` VALUES (1, 211);
INSERT INTO `sys_role_resource` VALUES (1, 212);
INSERT INTO `sys_role_resource` VALUES (1, 221);
INSERT INTO `sys_role_resource` VALUES (1, 222);
INSERT INTO `sys_role_resource` VALUES (1, 311);
INSERT INTO `sys_role_resource` VALUES (1, 312);
INSERT INTO `sys_role_resource` VALUES (1, 321);
INSERT INTO `sys_role_resource` VALUES (1, 322);
INSERT INTO `sys_role_resource` VALUES (1, 411);
INSERT INTO `sys_role_resource` VALUES (1, 412);
INSERT INTO `sys_role_resource` VALUES (1, 511);
INSERT INTO `sys_role_resource` VALUES (1, 512);
INSERT INTO `sys_role_resource` VALUES (1, 611);
INSERT INTO `sys_role_resource` VALUES (1, 612);
INSERT INTO `sys_role_resource` VALUES (1, 621);
INSERT INTO `sys_role_resource` VALUES (1, 622);
INSERT INTO `sys_role_resource` VALUES (2, 211);
INSERT INTO `sys_role_resource` VALUES (2, 221);
INSERT INTO `sys_role_resource` VALUES (2, 231);
INSERT INTO `sys_role_resource` VALUES (2, 241);
INSERT INTO `sys_role_resource` VALUES (2, 251);
INSERT INTO `sys_role_resource` VALUES (2, 261);
INSERT INTO `sys_role_resource` VALUES (2, 311);
INSERT INTO `sys_role_resource` VALUES (2, 312);
INSERT INTO `sys_role_resource` VALUES (2, 321);
INSERT INTO `sys_role_resource` VALUES (2, 411);
INSERT INTO `sys_role_resource` VALUES (2, 412);
INSERT INTO `sys_role_resource` VALUES (2, 511);
INSERT INTO `sys_role_resource` VALUES (2, 621);
INSERT INTO `sys_role_resource` VALUES (10, 621);
INSERT INTO `sys_role_resource` VALUES (10, 622);

-- ----------------------------
-- Table structure for sys_role_resource_copy
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_resource_copy`;
CREATE TABLE `sys_role_resource_copy`  (
  `role_id` bigint UNSIGNED NOT NULL COMMENT '角色编号',
  `resource_id` bigint UNSIGNED NOT NULL COMMENT '资源编号，只以3级权限作为权限判断的依据',
  PRIMARY KEY (`role_id`, `resource_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_resource_copy
-- ----------------------------
INSERT INTO `sys_role_resource_copy` VALUES (1, 11);
INSERT INTO `sys_role_resource_copy` VALUES (1, 21);
INSERT INTO `sys_role_resource_copy` VALUES (1, 22);
INSERT INTO `sys_role_resource_copy` VALUES (1, 31);
INSERT INTO `sys_role_resource_copy` VALUES (1, 32);
INSERT INTO `sys_role_resource_copy` VALUES (1, 41);
INSERT INTO `sys_role_resource_copy` VALUES (1, 51);
INSERT INTO `sys_role_resource_copy` VALUES (1, 61);
INSERT INTO `sys_role_resource_copy` VALUES (1, 62);
INSERT INTO `sys_role_resource_copy` VALUES (2, 21);
INSERT INTO `sys_role_resource_copy` VALUES (2, 22);
INSERT INTO `sys_role_resource_copy` VALUES (2, 23);
INSERT INTO `sys_role_resource_copy` VALUES (2, 24);
INSERT INTO `sys_role_resource_copy` VALUES (2, 25);
INSERT INTO `sys_role_resource_copy` VALUES (2, 26);
INSERT INTO `sys_role_resource_copy` VALUES (2, 31);
INSERT INTO `sys_role_resource_copy` VALUES (2, 32);
INSERT INTO `sys_role_resource_copy` VALUES (2, 41);
INSERT INTO `sys_role_resource_copy` VALUES (2, 51);
INSERT INTO `sys_role_resource_copy` VALUES (2, 62);
INSERT INTO `sys_role_resource_copy` VALUES (10, 62);

-- ----------------------------
-- Table structure for sys_session
-- ----------------------------
DROP TABLE IF EXISTS `sys_session`;
CREATE TABLE `sys_session`  (
  `session_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '场次编号',
  `hall_id` bigint UNSIGNED NOT NULL COMMENT '影厅编号',
  `language_version` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '语言版本',
  `movie_id` bigint UNSIGNED NOT NULL COMMENT '电影编号',
  `play_time` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '播放时间',
  `end_time` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '散场时间',
  `deadline` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '检测到的截止时间，没过这个时间不能删电影、影厅信息',
  `session_date` date NOT NULL COMMENT '场次日期',
  `session_price` decimal(10, 2) NOT NULL COMMENT '票价',
  `session_tips` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '影厅提示(如是否需要戴口罩，有什么福利，显示在选座购票位置的影厅后边，格式类似：6号Barco厅-（戴口罩勿饮食）凭票领券免费停车3小时)',
  `session_seats` json NOT NULL COMMENT '座位信息，采用{key: [], key: []}存储每一个座位的状态，其中key表示排，数组(下标+1)表示几号座，存储的值为0表示可选，1表示空(无座位)，值为2表示已选择，值为3表示已售出，',
  `seat_nums` smallint UNSIGNED NULL DEFAULT 0 COMMENT '总座位数',
  `sall_nums` smallint NOT NULL DEFAULT 0 COMMENT '售出座位数',
  `del_state` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记，0未删除，1删除，默认0',
  PRIMARY KEY (`session_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 76 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_session
-- ----------------------------
INSERT INTO `sys_session` VALUES (75, 1, '国语', 1, '21:07', '00:03', '2024-03-24 00:23:00', '2024-03-23', 55.00, NULL, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 3, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 100, 1, 0);
INSERT INTO `sys_session` VALUES (76, 2, '国语', 11, '21:08', '23:43', '2024-03-25 00:03:00', '2024-03-24', 45.00, NULL, '{\"1\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"2\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"3\": [0, 0, 0, 3, 0, 0, 3, 3, 0, 0, 0], \"4\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"5\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"6\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"7\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"8\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"9\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], \"10\": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}', 110, 3, 0);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `user_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户名称(用于登录，添加时验证唯一性)',
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户密码(密文存储)',
  `salt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '盐',
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户邮箱，记录个人信息和发送通知',
  `phone_number` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户电话号码，用于注册和发送通知',
  `sex` tinyint UNSIGNED NOT NULL COMMENT '用户性别，1为男性0为女性',
  `user_picture` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `role_id` bigint UNSIGNED NOT NULL DEFAULT 3 COMMENT '角色编号',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `autograph` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '个性签名',
  `del_state` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记，0未删除，1删除，默认0',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '2f6b5c3044b271f5c07545aa862cf35c', '0v#C4w&i', '17777744455@qq.com', '13111212312', 1, '[]', 1, '1999-10-15', '爱拼才会赢123', 0);
INSERT INTO `sys_user` VALUES (30, 'xbb', '334e6ffab40ca31d37fe3cce6270b2cb', 'B6)S%QMt', 'qq@163.com', '13656232356', 0, '[\"/images/user/2024/03/09/d03dcbd64c5c478c8ce794ef5e261220.jpg\"]', 3, '2024-03-09', '你好呀呀呀呀呀', 0);
INSERT INTO `sys_user` VALUES (32, 'bear', 'd1c99c791e1a6b37c37c1f3171ac226a', 'p23BT1lw', 'bear@163.com', '18181311131', 1, '[\"/images/user/2024/03/09/065f400ce90b494f819b685f7bed5fd2.jpg\"]', 3, NULL, NULL, 0);
INSERT INTO `sys_user` VALUES (33, 'Doraemon', '1b09db1fc32878be1034cabd3c298dcc', 'Wm@%(NF&', 'Doraemon@qq.com', '15123565613', 1, '[\"/images/user/2024/03/09/0911a73fcc56476294d4aa2fa65b84b2.jpg\"]', 3, NULL, NULL, 0);
INSERT INTO `sys_user` VALUES (34, 'tom', 'd283f120acc897bb027b43d2cce21c21', 'cgZDTZP^', 'tom@163.com', '13156312113', 0, '[\"/images/user/2024/03/09/74dd87f9c6714be3afb98ac65a153155.gif\"]', 3, '2024-03-10', NULL, 0);
INSERT INTO `sys_user` VALUES (35, 'jack', '58a349e5dc6e5a3cf12ccc0ccb024c41', 'pT!34hRd', 'jack@qq.com', '17643265686', 1, '[\"/images/user/2024/03/09/215c7e2ec8de4600b9fda8aef6a6b099.gif\"]', 3, '2024-03-11', '你好呀呀呀呀呀', 0);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `user_pwd` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `user_email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `user_role` int NULL DEFAULT NULL,
  `user_headImg` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '123456', '823810399@qq.com', 1, '/file/upload/head/c51a29cf-fe73-49d0-924a-cf7be0852d0f.jpg');
INSERT INTO `user` VALUES (2, 'test', '123456', '2222', 0, NULL);
INSERT INTO `user` VALUES (3, 'abc', '123456', 'abc2222', 0, '/file/upload/head/5bf2b66e-97aa-41ed-a1c1-5de685c616fa.jpg');
INSERT INTO `user` VALUES (5, '1234567', '1234567', '346641214@qq.com', 0, NULL);
INSERT INTO `user` VALUES (6, '12345678', '1234567', '346641214@qq.com', 0, NULL);
INSERT INTO `user` VALUES (7, '123456789', '1234567', '346641214@qq.com', 0, NULL);
INSERT INTO `user` VALUES (8, 'xj123', 'xj123', '346614@qq.com', 0, NULL);
INSERT INTO `user` VALUES (9, 'ww', '12345', '314@qq.com', 0, NULL);
INSERT INTO `user` VALUES (10, '111', '111', '111', 0, NULL);
INSERT INTO `user` VALUES (11, '222', '222', '222', 0, NULL);
INSERT INTO `user` VALUES (12, '333', '333', '333', 0, NULL);
INSERT INTO `user` VALUES (13, 'jjjj', '123', '123', 0, NULL);
INSERT INTO `user` VALUES (14, 'asdfg', '123123', '123@qq.com', 0, NULL);
INSERT INTO `user` VALUES (15, 'test2', '123', '123', 0, '/file/upload/head/b790274a-55bd-484a-8433-92ba73dd3dd9.jpg');
INSERT INTO `user` VALUES (16, 'test3', '123', '123@qq.com', 0, NULL);
INSERT INTO `user` VALUES (17, 'testRole', '123456', '123', 0, NULL);
INSERT INTO `user` VALUES (18, 'test4', '123', '123', 0, NULL);
INSERT INTO `user` VALUES (19, 'test5', '123456', '1234', 0, NULL);
INSERT INTO `user` VALUES (20, 'test6', '12345', '123@qq.com', 0, NULL);
INSERT INTO `user` VALUES (21, 'zhang', 'zhang', 'zhang@qq.com', 0, NULL);
INSERT INTO `user` VALUES (22, 'lisi', '123456', 'lisi1111@qq.com', 0, NULL);
INSERT INTO `user` VALUES (23, 'java', '123456', 'caofeng@126.com', 0, NULL);

SET FOREIGN_KEY_CHECKS = 1;
