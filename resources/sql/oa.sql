/*
SQLyog Ultimate v12.5.0 (64 bit)
MySQL - 5.1.73-community : Database - oa
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`oa` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `oa`;

/*Table structure for table `GOODS` */

DROP TABLE IF EXISTS `GOODS`;

CREATE TABLE `GOODS` (
  `id` varchar(10) DEFAULT NULL,
  `goodsName` varchar(100) DEFAULT NULL,
  `goodsTitle` varchar(100) DEFAULT NULL,
  `goodsImg` varchar(100) DEFAULT NULL,
  `goodsDetail` varchar(100) DEFAULT NULL,
  `goodsPrice` varchar(100) DEFAULT NULL,
  `goodsStock` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `GOODS` */

insert  into `GOODS`(`id`,`goodsName`,`goodsTitle`,`goodsImg`,`goodsDetail`,`goodsPrice`,`goodsStock`) values 
('100','苹果','苹果','/img/iphone8.png','苹果','6000','10');

/*Table structure for table `MIAOSHA_GOODS` */

DROP TABLE IF EXISTS `MIAOSHA_GOODS`;

CREATE TABLE `MIAOSHA_GOODS` (
  `goods_id` varchar(10) DEFAULT NULL,
  `stock_count` int(5) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `miaosha_price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `MIAOSHA_GOODS` */

insert  into `MIAOSHA_GOODS`(`goods_id`,`stock_count`,`start_date`,`end_date`,`miaosha_price`) values 
('100',0,'2018-06-28','2018-07-27',5000);

/*Table structure for table `MIAOSHA_ORDER` */

DROP TABLE IF EXISTS `MIAOSHA_ORDER`;

CREATE TABLE `MIAOSHA_ORDER` (
  `user_id` varchar(20) DEFAULT NULL,
  `goods_id` varchar(50) DEFAULT NULL,
  `order_id` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `MIAOSHA_ORDER` */

insert  into `MIAOSHA_ORDER`(`user_id`,`goods_id`,`order_id`) values 
('13672049605','100','0');

/*Table structure for table `MIAOSHA_USER` */

DROP TABLE IF EXISTS `MIAOSHA_USER`;

CREATE TABLE `MIAOSHA_USER` (
  `id` varchar(20) DEFAULT NULL,
  `nickname` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `salt` varchar(10) DEFAULT NULL,
  `head` varchar(10) DEFAULT NULL,
  `registerDate` date DEFAULT NULL,
  `lastLoginDate` date DEFAULT NULL,
  `loginCount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `MIAOSHA_USER` */

insert  into `MIAOSHA_USER`(`id`,`nickname`,`password`,`salt`,`head`,`registerDate`,`lastLoginDate`,`loginCount`) values 
('13672049605','zhangsan','b7797cce01b4b131b433b6acf4add449','1a2b3c4d','1',NULL,NULL,NULL);

/*Table structure for table `ORDER_INFO` */

DROP TABLE IF EXISTS `ORDER_INFO`;

CREATE TABLE `ORDER_INFO` (
  `id` int(11) DEFAULT NULL,
  `user_id` varchar(20) DEFAULT NULL,
  `goods_id` int(11) DEFAULT NULL,
  `deliveryAddr_Id` int(11) DEFAULT NULL,
  `goods_name` varchar(100) DEFAULT NULL,
  `goods_count` int(11) DEFAULT NULL,
  `goods_price` decimal(10,0) DEFAULT NULL,
  `order_channel` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `create_date` date DEFAULT NULL,
  `pay_Date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ORDER_INFO` */

insert  into `ORDER_INFO`(`id`,`user_id`,`goods_id`,`deliveryAddr_Id`,`goods_name`,`goods_count`,`goods_price`,`order_channel`,`status`,`create_date`,`pay_Date`) values 
(NULL,'13672049605',100,NULL,'苹果',1,5000,1,0,'2018-07-09',NULL);

/*Table structure for table `SEQUENCE` */

DROP TABLE IF EXISTS `SEQUENCE`;

CREATE TABLE `SEQUENCE` (
  `NAME` varchar(50) NOT NULL,
  `CURRENT_VALUE` int(11) NOT NULL,
  `INCREMENT` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `SEQUENCE` */

insert  into `SEQUENCE`(`NAME`,`CURRENT_VALUE`,`INCREMENT`) values 
('TestSeq',116,1);

/*Table structure for table `SYS_APP_USER` */

DROP TABLE IF EXISTS `SYS_APP_USER`;

CREATE TABLE `SYS_APP_USER` (
  `USER_ID` varchar(100) NOT NULL,
  `USERNAME` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `RIGHTS` varchar(255) DEFAULT NULL,
  `ROLE_ID` varchar(100) DEFAULT NULL,
  `LAST_LOGIN` varchar(255) DEFAULT NULL,
  `IP` varchar(100) DEFAULT NULL,
  `STATUS` varchar(32) DEFAULT NULL,
  `BZ` varchar(255) DEFAULT NULL,
  `PHONE` varchar(100) DEFAULT NULL,
  `SFID` varchar(100) DEFAULT NULL,
  `START_TIME` varchar(100) DEFAULT NULL,
  `END_TIME` varchar(100) DEFAULT NULL,
  `YEARS` int(10) DEFAULT NULL,
  `NUMBER` varchar(100) DEFAULT NULL,
  `EMAIL` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `SYS_APP_USER` */

insert  into `SYS_APP_USER`(`USER_ID`,`USERNAME`,`PASSWORD`,`NAME`,`RIGHTS`,`ROLE_ID`,`LAST_LOGIN`,`IP`,`STATUS`,`BZ`,`PHONE`,`SFID`,`START_TIME`,`END_TIME`,`YEARS`,`NUMBER`,`EMAIL`) values 
('1e89e6504be349a68c025976b3ecc1d1','a1','698d51a19d8a121ce581499d7b701668','会员甲','','115b386ff04f4352b060dffcd2b5d1da','','','1','121','1212','1212','2015-12-02','2015-12-25',2,'111','313596790@qq.com'),
('ead1f56708e4409c8d071e0a699e5633','a2','bcbe3365e6ac95ea2c0343a2395834dd','会员乙','','1b67fc82ce89457a8347ae53e43a347e','','','0','','','','2015-12-01','2015-12-24',1,'121','978336446@qq.com');

/*Table structure for table `SYS_CREATECODE` */

DROP TABLE IF EXISTS `SYS_CREATECODE`;

CREATE TABLE `SYS_CREATECODE` (
  `CREATECODE_ID` varchar(100) NOT NULL,
  `PACKAGENAME` varchar(50) DEFAULT NULL COMMENT '包名',
  `OBJECTNAME` varchar(50) DEFAULT NULL COMMENT '类名',
  `TABLENAME` varchar(50) DEFAULT NULL COMMENT '表名',
  `FIELDLIST` varchar(5000) DEFAULT NULL COMMENT '属性集',
  `CREATETIME` varchar(100) DEFAULT NULL COMMENT '创建时间',
  `TITLE` varchar(255) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`CREATECODE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `SYS_CREATECODE` */

insert  into `SYS_CREATECODE`(`CREATECODE_ID`,`PACKAGENAME`,`OBJECTNAME`,`TABLENAME`,`FIELDLIST`,`CREATETIME`,`TITLE`) values 
('002ea762e3e242a7a10ea5ca633701d8','system','Buttonrights','sys_,fh,BUTTONRIGHTS','NAME,fh,String,fh,名称,fh,是,fh,无,fh,255Q313596790','2016-01-16 23:20:36','按钮权限'),
('317c52b4201a4cb99c88130f03a4f18f','system','A1','TB_1111,fh,A1','AD,fh,String,fh,qqq,fh,是,fh,无,fh,255Q313596790','2018-02-24 22:50:20','11'),
('c7586f931fd44c61beccd3248774c68c','system','Department','SYS_,fh,DEPARTMENT','NAME,fh,String,fh,名称,fh,是,fh,无,fh,30Q313596790NAME_EN,fh,String,fh,英文,fh,是,fh,无,fh,50Q313596790BIANMA,fh,String,fh,编码,fh,是,fh,无,fh,50Q313596790PARENT_ID,fh,String,fh,上级ID,fh,否,fh,无,fh,100Q313596790BZ,fh,String,fh,备注,fh,是,fh,无,fh,255Q313596790HEADMAN,fh,String,fh,负责人,fh,是,fh,无,fh,30Q313596790TEL,fh,String,fh,电话,fh,是,fh,无,fh,50Q313596790FUNCTIONS,fh,String,fh,部门职能,fh,是,fh,无,fh,255Q313596790ADDRESS,fh,String,fh,地址,fh,是,fh,无,fh,255Q313596790','2015-12-20 01:49:25','组织机构'),
('cf9b5b6da5834c48aae38de9569aae76','system','A1','TB_1111,fh,A1','AD,fh,String,fh,qqq,fh,是,fh,无,fh,255Q313596790','2018-02-24 22:50:19','11'),
('d514dbd2474d4b6c8b6ab9904cc9cc7c','new','News','TB_,fh,NEWS','TITLE,fh,String,fh,标题,fh,是,fh,无,fh,255Q313596790','2016-01-25 16:38:14','新闻管理'),
('dbd7b8330d774dcabd184eca8668a295','system','Fhsms','SYS_,fh,FHSMS','CONTENT,fh,String,fh,内容,fh,是,fh,无,fh,1000Q313596790TYPE,fh,String,fh,类型,fh,否,fh,无,fh,5Q313596790TO_USERNAME,fh,String,fh,收信人,fh,是,fh,无,fh,255Q313596790FROM_USERNAME,fh,String,fh,发信人,fh,是,fh,无,fh,255Q313596790SEND_TIME,fh,String,fh,发信时间,fh,是,fh,无,fh,100Q313596790STATUS,fh,String,fh,状态,fh,否,fh,无,fh,5Q313596790SANME_ID,fh,String,fh,共同ID,fh,是,fh,无,fh,100Q313596790','2016-01-23 01:44:15','站内信'),
('fe239f8742194481a5b56f90cad71520','system','Fhbutton','SYS_,fh,FHBUTTON','NAME,fh,String,fh,名称,fh,是,fh,无,fh,30Q313596790QX_NAME,fh,String,fh,权限标识,fh,是,fh,无,fh,50Q313596790BZ,fh,String,fh,备注,fh,是,fh,无,fh,255Q313596790','2016-01-15 18:38:40','按钮管理');

/*Table structure for table `SYS_DEPARTMENT` */

DROP TABLE IF EXISTS `SYS_DEPARTMENT`;

CREATE TABLE `SYS_DEPARTMENT` (
  `DEPARTMENT_ID` varchar(100) NOT NULL,
  `NAME` varchar(30) DEFAULT NULL COMMENT '名称',
  `NAME_EN` varchar(50) DEFAULT NULL COMMENT '英文',
  `BIANMA` varchar(50) DEFAULT NULL COMMENT '编码',
  `PARENT_ID` varchar(100) DEFAULT NULL COMMENT '上级ID',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  `HEADMAN` varchar(30) DEFAULT NULL COMMENT '负责人',
  `TEL` varchar(50) DEFAULT NULL COMMENT '电话',
  `FUNCTIONS` varchar(255) DEFAULT NULL COMMENT '部门职能',
  `ADDRESS` varchar(255) DEFAULT NULL COMMENT '地址',
  PRIMARY KEY (`DEPARTMENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `SYS_DEPARTMENT` */

insert  into `SYS_DEPARTMENT`(`DEPARTMENT_ID`,`NAME`,`NAME_EN`,`BIANMA`,`PARENT_ID`,`BZ`,`HEADMAN`,`TEL`,`FUNCTIONS`,`ADDRESS`) values 
('0956d8c279274fca92f4091f2a69a9ad','销售会计','xiaokuai','05896','d41af567914a409893d011aa53eda797','','','','',''),
('3e7227e11dc14b4d9e863dd1a1fcedf6','成本会计','chengb','03656','d41af567914a409893d011aa53eda797','','','','',''),
('5cccdb7c432449d8b853c52880058140','B公司','b','002','0','冶铁','李四','112','冶铁','河北'),
('83a25761c618457cae2fa1211bd8696d','销售B组','xiaob','002365','cbbc84eddde947ba8af7d509e430eb70','','李四','','',''),
('8f8b045470f342fdbc4c312ab881d62b','销售A组','xiaoA','0326','cbbc84eddde947ba8af7d509e430eb70','','张三','0201212','',''),
('a0982dea52554225ab682cd4b421de47','1队','yidui','02563','8f8b045470f342fdbc4c312ab881d62b','','小王','12356989','',''),
('a6c6695217ba4a4dbfe9f7e9d2c06730','A公司','a','001','0','挖煤','张三','110','洼煤矿','山西'),
('cbbc84eddde947ba8af7d509e430eb70','销售部','xiaoshoubu','00201','5cccdb7c432449d8b853c52880058140','推销商品','小明','11236','推销商品','909办公室'),
('d41af567914a409893d011aa53eda797','财务部','caiwubu','00101','a6c6695217ba4a4dbfe9f7e9d2c06730','负责发工资','王武','11236','管理财务','308办公室');

/*Table structure for table `SYS_DICTIONARIES` */

DROP TABLE IF EXISTS `SYS_DICTIONARIES`;

CREATE TABLE `SYS_DICTIONARIES` (
  `DICTIONARIES_ID` varchar(100) NOT NULL,
  `NAME` varchar(30) DEFAULT NULL COMMENT '名称',
  `NAME_EN` varchar(50) DEFAULT NULL COMMENT '英文',
  `BIANMA` varchar(50) DEFAULT NULL COMMENT '编码',
  `ORDER_BY` int(11) NOT NULL COMMENT '排序',
  `PARENT_ID` varchar(100) DEFAULT NULL COMMENT '上级ID',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  `TBSNAME` varchar(100) DEFAULT NULL COMMENT '排查表',
  PRIMARY KEY (`DICTIONARIES_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `SYS_DICTIONARIES` */

insert  into `SYS_DICTIONARIES`(`DICTIONARIES_ID`,`NAME`,`NAME_EN`,`BIANMA`,`ORDER_BY`,`PARENT_ID`,`BZ`,`TBSNAME`) values 
('096e4ec8986149d994b09e604504e38d','黄浦区','huangpu','0030201',1,'f1ea30ddef1340609c35c88fb2919bee','黄埔',''),
('12a62a3e5bed44bba0412b7e6b733c93','北京','beijing','00301',1,'be4a8c5182c744d28282a5345783a77f','北京',''),
('507fa87a49104c7c8cdb52fdb297da12','宣武区','xuanwuqu','0030101',1,'12a62a3e5bed44bba0412b7e6b733c93','宣武区',''),
('8994f5995f474e2dba6cfbcdfe5ea07a','语文','yuwen','00201',1,'fce20eb06d7b4b4d8f200eda623f725c','语文',''),
('8ea7c44af25f48b993a14f791c8d689f','分类','fenlei','001',1,'0','分类',''),
('be4a8c5182c744d28282a5345783a77f','地区','diqu','003',3,'0','地区',''),
('d428594b0494476aa7338d9061e23ae3','红色','red','00101',1,'8ea7c44af25f48b993a14f791c8d689f','红色',''),
('de9afadfbed0428fa343704d6acce2c4','绿色','green','00102',2,'8ea7c44af25f48b993a14f791c8d689f','绿色',''),
('f1ea30ddef1340609c35c88fb2919bee','上海','shanghai','00302',2,'be4a8c5182c744d28282a5345783a77f','上海',''),
('fce20eb06d7b4b4d8f200eda623f725c','课程','kecheng','002',2,'0','课程','');

/*Table structure for table `SYS_FHBUTTON` */

DROP TABLE IF EXISTS `SYS_FHBUTTON`;

CREATE TABLE `SYS_FHBUTTON` (
  `FHBUTTON_ID` varchar(100) NOT NULL,
  `NAME` varchar(30) DEFAULT NULL COMMENT '名称',
  `QX_NAME` varchar(50) DEFAULT NULL COMMENT '权限标识',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`FHBUTTON_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `SYS_FHBUTTON` */

insert  into `SYS_FHBUTTON`(`FHBUTTON_ID`,`NAME`,`QX_NAME`,`BZ`) values 
('3542adfbda73410c976e185ffe50ad06','导出EXCEL','toExcel','导出EXCEL'),
('46992ea280ba4b72b29dedb0d4bc0106','发邮件','email','发送电子邮件'),
('4efa162fce8340f0bd2dcd3b11d327ec','导入EXCEL','FromExcel','导入EXCEL到系统用户'),
('cc51b694d5344d28a9aa13c84b7166cd','发短信','sms','发送短信'),
('da7fd386de0b49ce809984f5919022b8','站内信','FHSMS','发送站内信');

/*Table structure for table `SYS_FHSMS` */

DROP TABLE IF EXISTS `SYS_FHSMS`;

CREATE TABLE `SYS_FHSMS` (
  `FHSMS_ID` varchar(100) NOT NULL,
  `CONTENT` varchar(1000) DEFAULT NULL COMMENT '内容',
  `TYPE` varchar(5) DEFAULT NULL COMMENT '类型',
  `TO_USERNAME` varchar(255) DEFAULT NULL COMMENT '收信人',
  `FROM_USERNAME` varchar(255) DEFAULT NULL COMMENT '发信人',
  `SEND_TIME` varchar(100) DEFAULT NULL COMMENT '发信时间',
  `STATUS` varchar(5) DEFAULT NULL COMMENT '状态',
  `SANME_ID` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`FHSMS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `SYS_FHSMS` */

insert  into `SYS_FHSMS`(`FHSMS_ID`,`CONTENT`,`TYPE`,`TO_USERNAME`,`FROM_USERNAME`,`SEND_TIME`,`STATUS`,`SANME_ID`) values 
('05879f5868824f35932ee9f2062adc03','你好','2','admin','san','2016-01-25 14:05:31','1','b311e893228f42d5a05dbe16917fd16f'),
('2635dd035c6f4bb5a091abdd784bd899','你好','2','san','admin','2016-01-25 14:05:02','2','1b7637306683460f89174c2b025862b5'),
('52378ccd4e2d4fe08994d1652af87c68','你好','1','admin','san','2016-01-25 16:26:44','1','920b20dafdfb4c09b560884eb277c51d'),
('77ed13f9c49a4c4bb460c41b8580dd36','gggg','2','admin','san','2016-01-24 21:22:43','2','dd9ee339576e48c5b046b94fa1901d00'),
('98a6869f942042a1a037d9d9f01cb50f','你好','1','admin','san','2016-01-25 14:05:02','2','1b7637306683460f89174c2b025862b5'),
('9e00295529014b6e8a27019cbccb3da1','柔柔弱弱','1','admin','san','2016-01-24 21:22:57','1','a29603d613ea4e54b5678033c1bf70a6'),
('d3aedeb430f640359bff86cd657a8f59','你好','1','admin','san','2016-01-24 21:22:12','1','f022fbdce3d845aba927edb698beb90b'),
('e5376b1bd54b489cb7f2203632bd74ec','管理员好','2','admin','san','2016-01-25 14:06:13','2','b347b2034faf43c79b54be4627f3bd2b'),
('e613ac0fcc454f32895a70b747bf4fb5','你也好','2','admin','san','2016-01-25 16:27:54','2','ce8dc3b15afb40f28090f8b8e13f078d'),
('f25e00cfafe741a3a05e3839b66dc7aa','你好','2','san','admin','2016-01-25 16:26:44','1','920b20dafdfb4c09b560884eb277c51d');

/*Table structure for table `SYS_GROUP` */

DROP TABLE IF EXISTS `SYS_GROUP`;

CREATE TABLE `SYS_GROUP` (
  `GROUP_ID` varchar(8) NOT NULL,
  `GROUP_NAME` varchar(50) DEFAULT NULL,
  `REMARK` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`GROUP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `SYS_GROUP` */

insert  into `SYS_GROUP`(`GROUP_ID`,`GROUP_NAME`,`REMARK`) values 
('100','BM','经理'),
('101','PM','经理'),
('102','CRM','个人组'),
('103','GROUP','集团组'),
('104','BOSS','账务组'),
('105','CMOS','客服组'),
('106','O&S','运维组'),
('140','PROD','产品部'),
('150','OTH','其他');

/*Table structure for table `SYS_MENU` */

DROP TABLE IF EXISTS `SYS_MENU`;

CREATE TABLE `SYS_MENU` (
  `MENU_ID` int(11) NOT NULL,
  `MENU_NAME` varchar(255) DEFAULT NULL,
  `MENU_URL` varchar(255) DEFAULT NULL,
  `PARENT_ID` varchar(100) DEFAULT NULL,
  `MENU_ORDER` varchar(100) DEFAULT NULL,
  `MENU_ICON` varchar(60) DEFAULT NULL,
  `MENU_TYPE` varchar(10) DEFAULT NULL,
  `MENU_STATE` int(1) DEFAULT NULL,
  PRIMARY KEY (`MENU_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `SYS_MENU` */

insert  into `SYS_MENU`(`MENU_ID`,`MENU_NAME`,`MENU_URL`,`PARENT_ID`,`MENU_ORDER`,`MENU_ICON`,`MENU_TYPE`,`MENU_STATE`) values 
(1,'系统管理','#','0','1','menu-icon fa fa-desktop blue','2',1),
(2,'权限管理','#','1','1','menu-icon fa fa-lock black','1',1),
(6,'信息管理','#','0','6','menu-icon fa fa-credit-card green','2',1),
(7,'图片管理','pictures/list.do','6','1','menu-icon fa fa-folder-o pink','2',1),
(8,'性能监控','druid/index.html','9','1','menu-icon fa fa-tachometer red','1',1),
(9,'系统工具','#','0','4','menu-icon fa fa-cog black','2',1),
(10,'接口测试','tool/interfaceTest.do','9','2','menu-icon fa fa-exchange green','1',1),
(11,'发送邮件','tool/goSendEmail.do','9','3','menu-icon fa fa-envelope-o green','1',1),
(12,'置二维码','tool/goTwoDimensionCode.do','9','4','menu-icon fa fa-barcode green','1',1),
(14,'地图工具','tool/map.do','9','6','menu-icon fa fa-globe black','1',1),
(15,'微信管理','#','0','5','menu-icon fa fa-comments purple','2',1),
(16,'文本回复','textmsg/list.do','15','2','menu-icon fa fa-comment green','2',1),
(17,'应用命令','command/list.do','15','4','menu-icon fa fa-comment grey','2',1),
(18,'图文回复','imgmsg/list.do','15','3','menu-icon fa fa-comment pink','2',1),
(19,'关注回复','textmsg/goSubscribe.do','15','1','menu-icon fa fa-comment orange','2',1),
(20,'在线管理','onlinemanager/list.do','1','6','menu-icon fa fa-laptop green','1',1),
(21,'打印测试','tool/printTest.do','9','7','menu-icon fa fa-hdd-o grey','1',1),
(22,'一级菜单','#','0','7','menu-icon fa fa-fire orange','2',1),
(23,'二级菜单','#','22','1','menu-icon fa fa-leaf black','1',1),
(24,'三级菜单','#','23','1','menu-icon fa fa-leaf black','1',1),
(30,'四级菜单','#','24','1','menu-icon fa fa-leaf black','1',1),
(31,'五级菜单1','#','30','1','menu-icon fa fa-leaf black','1',1),
(32,'五级菜单2','#','30','2','menu-icon fa fa-leaf black','1',1),
(33,'六级菜单','#','31','1','menu-icon fa fa-leaf black','1',1),
(34,'六级菜单2','login_default.do','31','2','menu-icon fa fa-leaf black','1',1),
(35,'四级菜单2','login_default.do','24','2','menu-icon fa fa-leaf black','1',1),
(36,'角色(基础权限)','role.do','2','1','menu-icon fa fa-key orange','1',1),
(37,'按钮权限','buttonrights/list.do','2','2','menu-icon fa fa-key green','1',1),
(38,'菜单管理','menu/listAllMenu.do','1','3','menu-icon fa fa-folder-open-o brown','1',1),
(39,'按钮管理','fhbutton/list.do','1','2','menu-icon fa fa-download orange','1',1),
(40,'用户管理','#','0','2','menu-icon fa fa-users blue','2',1),
(41,'系统用户','user/listUsers.do','40','1','menu-icon fa fa-users green','1',1),
(42,'会员管理','happuser/listUsers.do','40','2','menu-icon fa fa-users orange','1',1),
(43,'数据字典','dictionaries/listAllDict.do?DICTIONARIES_ID=0','1','4','menu-icon fa fa-book purple','1',1),
(44,'代码生成','createCode/list.do','9','0','menu-icon fa fa-cogs brown','1',1),
(45,'七级菜单1','#','33','1','menu-icon fa fa-leaf black','1',1),
(46,'七级菜单2','#','33','2','menu-icon fa fa-leaf black','1',1),
(47,'八级菜单','login_default.do','45','1','menu-icon fa fa-leaf black','1',1),
(48,'图表报表','tool/fusionchartsdemo.do','9','5','menu-icon fa fa-bar-chart-o black','1',1),
(49,'组织机构','department/listAllDepartment.do?DEPARTMENT_ID=0','1','5','menu-icon fa fa-users blue','1',1),
(50,'站内信','fhsms/list.do','6','2','menu-icon fa fa-envelope green','1',1),
(51,'员工管理','#','0','3','menu-icon fa fa-heart-o red','2',1),
(52,'员工独白','monologue/list.do','51','1','menu-icon fa fa-book green','1',1),
(53,'员工风采','aspirations/list.do','51','2','menu-icon fa fa-tachometer orange','1',1);

/*Table structure for table `SYS_PARAM` */

DROP TABLE IF EXISTS `SYS_PARAM`;

CREATE TABLE `SYS_PARAM` (
  `P_CODE` varchar(10) NOT NULL,
  `P_VALUE` varchar(20) NOT NULL,
  `P_NAME` varchar(50) DEFAULT NULL,
  `P_DES` varchar(100) DEFAULT NULL,
  `STATUS` char(1) DEFAULT '0' COMMENT '0-不使用 1-使用',
  `START_DATE` date DEFAULT NULL,
  `END_DATE` date DEFAULT NULL,
  `REMARK` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`P_CODE`,`P_VALUE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `SYS_PARAM` */

insert  into `SYS_PARAM`(`P_CODE`,`P_VALUE`,`P_NAME`,`P_DES`,`STATUS`,`START_DATE`,`END_DATE`,`REMARK`) values 
('100','0','女',NULL,'1',NULL,NULL,NULL),
('100','1','男',NULL,'1',NULL,NULL,NULL);

/*Table structure for table `SYS_ROLE` */

DROP TABLE IF EXISTS `SYS_ROLE`;

CREATE TABLE `SYS_ROLE` (
  `ROLE_ID` varchar(100) NOT NULL,
  `ROLE_NAME` varchar(100) DEFAULT NULL,
  `RIGHTS` varchar(255) DEFAULT NULL,
  `PARENT_ID` varchar(100) DEFAULT NULL,
  `ADD_QX` varchar(255) DEFAULT NULL,
  `DEL_QX` varchar(255) DEFAULT NULL,
  `EDIT_QX` varchar(255) DEFAULT NULL,
  `CHA_QX` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `SYS_ROLE` */

insert  into `SYS_ROLE`(`ROLE_ID`,`ROLE_NAME`,`RIGHTS`,`PARENT_ID`,`ADD_QX`,`DEL_QX`,`EDIT_QX`,`CHA_QX`) values 
('1','系统管理组','18014397469286342','0','1','1','1','1'),
('3264c8e83d0248bb9e3ea6195b4c0216','一级权限','18014397469286342','1','2251798773489606','2251798773489606','1125898866646982','2251798773489606'),
('46294b31a71c4600801724a6eb06bb26','职位组','','0','0','0','0','0'),
('68f8e4a39efe47c7bb869e9d15ab925d','二级权限','17437222582116288','1','0','0','2251798773489606','0'),
('8aec4e5581e74c39ae4f804b0d71edce','经理','','46294b31a71c4600801724a6eb06bb26','0','0','0','0'),
('9b33b3ca02a5466aa7a7e2b8b63a47d0','产品部','','46294b31a71c4600801724a6eb06bb26','0','0','0','0'),
('9c847ecddfa54494a1824ce863ce7444','会员组','','2','0','0','0','0'),
('a8cbf2e4f27549e5a37710387fc200e3','组员','','46294b31a71c4600801724a6eb06bb26','0','0','0','0'),
('be0afc85ae4648969922c0528ae5de43','组长','','46294b31a71c4600801724a6eb06bb26','0','0','0','0'),
('de9de2f006e145a29d52dfadda295353','三级权限','18014397469286342','1','0','0','0','3298534883328');

/*Table structure for table `SYS_ROLE_FHBUTTON` */

DROP TABLE IF EXISTS `SYS_ROLE_FHBUTTON`;

CREATE TABLE `SYS_ROLE_FHBUTTON` (
  `RB_ID` varchar(100) NOT NULL,
  `ROLE_ID` varchar(100) DEFAULT NULL,
  `BUTTON_ID` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`RB_ID`),
  KEY `角色表外键` (`ROLE_ID`) USING BTREE,
  KEY `fbutton` (`BUTTON_ID`),
  CONSTRAINT `fbutton` FOREIGN KEY (`BUTTON_ID`) REFERENCES `sys_fhbutton` (`FHBUTTON_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `frole` FOREIGN KEY (`ROLE_ID`) REFERENCES `sys_role` (`ROLE_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `SYS_ROLE_FHBUTTON` */

insert  into `SYS_ROLE_FHBUTTON`(`RB_ID`,`ROLE_ID`,`BUTTON_ID`) values 
('14b5c28ea6ae4508b57d2d272ab3d5f1','3264c8e83d0248bb9e3ea6195b4c0216','46992ea280ba4b72b29dedb0d4bc0106'),
('15e945eece734617b69c424c6b0db00b','be0afc85ae4648969922c0528ae5de43','4efa162fce8340f0bd2dcd3b11d327ec'),
('36657be7855141fcb71a3a03c9947564','8aec4e5581e74c39ae4f804b0d71edce','da7fd386de0b49ce809984f5919022b8'),
('3768e60edd1c4b5c9f1dd861188ae2f9','3264c8e83d0248bb9e3ea6195b4c0216','cc51b694d5344d28a9aa13c84b7166cd'),
('74bee581d6c641c1bb6b4883dafd0508','be0afc85ae4648969922c0528ae5de43','3542adfbda73410c976e185ffe50ad06'),
('8231c216fb514b4188e4162e629c6237','3264c8e83d0248bb9e3ea6195b4c0216','4efa162fce8340f0bd2dcd3b11d327ec'),
('940230e6552e454a923bfe36a4cdf9f4','3264c8e83d0248bb9e3ea6195b4c0216','3542adfbda73410c976e185ffe50ad06'),
('9412d1d05162464c83658c7f89ab03f0','68f8e4a39efe47c7bb869e9d15ab925d','3542adfbda73410c976e185ffe50ad06'),
('96567633dd3548c9b75d28f430adf5a3','3264c8e83d0248bb9e3ea6195b4c0216','da7fd386de0b49ce809984f5919022b8'),
('a1478f27c852459fa9cad04b642f4fb7','de9de2f006e145a29d52dfadda295353','3542adfbda73410c976e185ffe50ad06'),
('b68cd33266c7427f8360d4cd059114f3','8aec4e5581e74c39ae4f804b0d71edce','46992ea280ba4b72b29dedb0d4bc0106'),
('bb5a37d13e8d473480986269b26018b0','8aec4e5581e74c39ae4f804b0d71edce','3542adfbda73410c976e185ffe50ad06'),
('e75ac15007d84ee2856c01408b494548','8aec4e5581e74c39ae4f804b0d71edce','4efa162fce8340f0bd2dcd3b11d327ec'),
('f49cc0763a834c599c4882713e6018aa','8aec4e5581e74c39ae4f804b0d71edce','cc51b694d5344d28a9aa13c84b7166cd');

/*Table structure for table `SYS_USER` */

DROP TABLE IF EXISTS `SYS_USER`;

CREATE TABLE `SYS_USER` (
  `USER_ID` varchar(100) NOT NULL,
  `USERNAME` varchar(255) NOT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `SEX` char(1) DEFAULT '1',
  `RIGHTS` varchar(255) DEFAULT NULL,
  `ROLE_ID` varchar(100) DEFAULT NULL,
  `GROUP_ID` varchar(5) DEFAULT NULL,
  `STATUS` varchar(32) DEFAULT NULL,
  `NUMBER` varchar(100) DEFAULT NULL,
  `PHONE` varchar(32) DEFAULT NULL,
  `PHONE1` varchar(32) DEFAULT NULL,
  `EMAIL` varchar(32) DEFAULT NULL,
  `LC_IP` varchar(15) DEFAULT NULL,
  `MAC` varchar(18) DEFAULT NULL,
  `IP` varchar(15) DEFAULT NULL,
  `LAST_LOGIN` varchar(255) DEFAULT NULL,
  `SKIN` varchar(100) DEFAULT NULL,
  `BZ` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `SYS_USER` */

insert  into `SYS_USER`(`USER_ID`,`USERNAME`,`PASSWORD`,`NAME`,`SEX`,`RIGHTS`,`ROLE_ID`,`GROUP_ID`,`STATUS`,`NUMBER`,`PHONE`,`PHONE1`,`EMAIL`,`LC_IP`,`MAC`,`IP`,`LAST_LOGIN`,`SKIN`,`BZ`) values 
('025b97e385bd47259bd21cdc07c744eb','zhangwen5','2b45248f9f81f59e21a9cd67804e3dae5c380fe2','张文','1','','de9de2f006e145a29d52dfadda295353','103','0','40641','15122085886','15122085886','zhangwen5@asiainfo.com','','','','','default',NULL),
('05c4b5601fd24c278e08aa581c42b003','wangyw7','c9fb0ee34d835dcdfc00dbafa341c2f69f2279e4','王岳伟','1','','de9de2f006e145a29d52dfadda295353','103','0','76942','18526089129','18526089129','wangyw7@asiainfo.com','','','','','default',NULL),
('0a308d4d7aa242a2a1c6648a0d974476','cuirz','436027327f9f2907a2f6ac1d1ae2a28b9007309d','崔润泽','1','','de9de2f006e145a29d52dfadda295353','104','0','73381','15022763608','15022763608','cuirz@asiainfo.com','10.143.186.48','','','','default',NULL),
('0c1b87e0aa624e13a087a48b098b966d','fuyn3','dd1cc89fa605e73d8eb7c8ce2ed1f6ee280b21ed','付雅楠','1','','de9de2f006e145a29d52dfadda295353','102','0','77544','15210343475','15210343475','fuyn3@asiainfo.com','','','','','default',NULL),
('0f152e8414314179841daa716d948edc','wanglong8','250c526b9c378762cf0befac026a41bef1b396d6','王龙','1','','de9de2f006e145a29d52dfadda295353','103','0','71491','18622324621','18622324621','wanglong8@asiainfo.com','10.143.186.49','','','','default',NULL),
('1','admin','e7eec152835fb7ebab4a3701d2327247b9403cc3','系统管理员','0','1133671055321055258374707980945218933803269864762743594642571294','1','101','0','001','13672049605','141232','admin@asiainfo.com',NULL,'W1-34-22-33-1','169.254.46.246','2018-07-27 17:04:29','default','开发工程师'),
('1122d50dabf34601bf3e89ff9710ec34','zhangjian3','e75d6f607dcb2e3f9a914b2e37840ded6518aba5','张健','1','','de9de2f006e145a29d52dfadda295353','102','0','20420','18611010295','18611010295','zhangjian3@asiainfo.com','','','','','default',NULL),
('1536580b640c4a768313badfc1956a34','lizhu','d1a1e722e89cc661a9b8dd0303f0d55f875dfce1','李柱','1','','de9de2f006e145a29d52dfadda295353','104','0','76510','15022500112','15022500112','lizhu@asiainfo.com','','','','','default',NULL),
('1ab1e18217e848f6b7835286df2050ae','yangld','a4452cb8a3b1cf3c0b352ff4273c6fc440409df4','杨利东','1','','de9de2f006e145a29d52dfadda295353','103','0','17441','18652327585','18652327585','yangld@asiainfo.com','','','','','default',NULL),
('1e7e62c07ce647848079aef4a0cde1c9','wangcan5','894bad777ef689f58b17fd0764ff222c0483ebcd','王灿','1','','de9de2f006e145a29d52dfadda295353','103','0','73658','15902209610','15902209610','wangcan5@asiainfo.com','10.143.186.51','','','','default',NULL),
('1ea33bf977b046b7b97a6fc7512dc0fa','qifei','1927e888535d56a4e76f4e35262ba3a919e2f406','齐飞','1','','de9de2f006e145a29d52dfadda295353','103','0','69634','13821131569','13821131569','qifei@asiainfo.com','10.143.186.28','','','','default',NULL),
('237d5ad7180b47a1b68e1b07bbaa11f0','fenglu','d88eea212cbc8c77cf192de65a6b054e3c698643','冯璐','0','','de9de2f006e145a29d52dfadda295353','150','0','64782','13821953076','13821953076','fenglu@asiainfo.com','10.143.186.6','','','','default',''),
('2cc0d946bac4451a97c4fd3dd43718c8','wukun3','c69e4c7e066eb509f5e20fc26baec06c5f226510','吴堃','1','','de9de2f006e145a29d52dfadda295353','102','0','73899','13803065552','13803065552','wukun3@asiainfo.com','10.143.186.55','','','','default',NULL),
('2e96726f3992462c870b111bcf360968','xiajl','0ec7566b2ef4004df56a6d87dcdfe12490f82b6e','夏津龙','1','','de9de2f006e145a29d52dfadda295353','103','0','73879','18622724026','18622724026','xiajl@asiainfo.com','10.143.186.54','','','','default',NULL),
('397ce983e18f4fd19236172517e60736','liangjy','03a97157e7c15a843e42271db6672c2d7511a7f4','梁金玉','1','','de9de2f006e145a29d52dfadda295353','150','0','65483','13672049605','13672049605','liangjy@asiainfo.com','10.143.186.22','','169.254.46.246','2018-07-27 17:04:12','default',NULL),
('3a3c423766024e10b386683ddd29af3a','mapl','ec611c105bbab46cca8728bc13f6cf16a6d18768','马培伦','1','','de9de2f006e145a29d52dfadda295353','105','0','77705','13662033885','13662033885','mapl@asiainfo.com','','','','','default',NULL),
('46084e9ca176469ca5c74c1e31b2ae09','sungy6','b7b4dd05350af8fd976dd666ef1723bfd1bc1588','孙广迎','1','','de9de2f006e145a29d52dfadda295353','104','0','73145','18722184804','18722184804','sungy6@asiainfo.com','10.143.186.44','','','','default',NULL),
('4cb060f1d65a4a459cb6a68923d94ae4','liugj','c36e1dada80137c05f94fbf735e2ffba901b9647','刘广锦','0','','de9de2f006e145a29d52dfadda295353','104','0','77822','18602698566','18602698566','liugj@asiainfo.com','','','','','default',NULL),
('50d256a6c6de4385b55dc1ba3f2eed2d','yangpc','780995d62c83d3adeb9cd26826a001dfcdaee800','杨鹏程','1','','de9de2f006e145a29d52dfadda295353','102','0','70062','13642121069','13642121069','yangpc@asiainfo.com','10.143.186.31','','','','default',NULL),
('6a72fd21b08b42bb9d26895b691fa9eb','xiejn','827c5d47173889d81746ecbea67df5184327adc5','解际宁','1','','de9de2f006e145a29d52dfadda295353','104','0','40813','18354681889','18354681889','xiejn@asiainfo.com','','','','','default',NULL),
('7141094de46c419e8a26f6109847bbc1','tiankai5','fc9f4305c07599b91f0df7d1e881725ed813ccc0','田恺','1','','de9de2f006e145a29d52dfadda295353','103','0','76449','13821328176','13821328176','tiankai5@asiainfo.com','','','','','default',NULL),
('7296189c2aa24758ac535acc32a79569','xingpt','84e2d7a2186e1c8bc2e8548f9a17a9a930f585a1','邢鹏涛','1','','de9de2f006e145a29d52dfadda295353','102','0','29472','15320029452','15320029452','xingpt@asiainfo.com','10.143.186.59','','','','default',NULL),
('76d06412b6ed4805b293badb6c295ab8','wangyb9','1d90b4c247104a2cfae7e95016f837338b589913','王彦斌','1','','de9de2f006e145a29d52dfadda295353','105','0','23089','18622767596','18622767596','wangyb9@asiainfo.com','','','','','default',NULL),
('76e8ae1cd825405c935f6c56bcf349f9','wangjue3','c1307de8d53162a926e6adbdba2eb573db9d9c2f','王珏','1','','de9de2f006e145a29d52dfadda295353','103','0','75266','18235139653','18235139653','wangjue3@asiainfo.com','10.143.186.65','','','','default',NULL),
('7e9882de2e8c4f8eb99c45933a4370cd','majz','d8ff9e37f715a02366350c8d56b3522cf45d4e0b','马纪志','1','','de9de2f006e145a29d52dfadda295353','102','0','77165','13821864308','13821864308','majz@asiainfo.com','','','','','default',NULL),
('88ea474568904256b955d412099b7eb4','sunpf','5126a3367d3885a791316844eaaec96533ef8e28','孙鹏飞','1','','de9de2f006e145a29d52dfadda295353','105','0','73784','18322412289','18322412289','sunpf@asiainfo.com','10.143.186.52','','','','default',NULL),
('8ad4e07520bc4154aa29f543ac1e74fc','majl','c91f7ac51f401cd6f230b8c516303751a25974f7','马且伦','1','','de9de2f006e145a29d52dfadda295353','102','0','77674','15302159208','15302159208','majl@asiainfo.com','','','','','default',NULL),
('8b246185fe05482a93af06761987e694','yanyu3','7bb83b88e35548b80edbc4dfeff4dc171db35af9','闫宇','0','','de9de2f006e145a29d52dfadda295353','103','0','76530','13102103316','13102103316','yanyu3@asiainfo.com','','','','','default',NULL),
('8c3832e05f8e41518ff2e17e26374d5e','zhuhao5','84f590bd60964dee33ba47cf102f57268f043783','朱浩','1','','de9de2f006e145a29d52dfadda295353','102','0','70256','15122540280','15122540280','zhuhao5@asiainfo.com','10.143.186.33','','','','default',NULL),
('8cb7baf329bb476c897c38d91cd9cd0b','zhangds','feb4d6b844b8a4a5312e95e82dc03598bf6f8c86','张大松','1','','de9de2f006e145a29d52dfadda295353','106','0','68448','15922057408','15922057408','zhangds@asiainfo.com','10.143.186.25','','','','default',NULL),
('8fa868f53d634bcfa0b21859f68c4731','kanliang','581200c84d7fd044b972da850138e17992a7c529','阚亮','1','','de9de2f006e145a29d52dfadda295353','104','0','68633','15822187326','15822187326','kanliang@asiainfo.com','10.143.186.26','','','','default',NULL),
('909555be32524b5c873357bb80ab9f0d','zhangkx','ca434073d5e3dcd0bd390075619c376813a66aae','张可欣','0','','de9de2f006e145a29d52dfadda295353','102','0','76723','13612185899','13612185899','zhangkx@asiainfo.com','','','','','default',NULL),
('94a657dc3ea04017bbd9038df2be3ce6','wanfr','e7b2fabf3a7d5ffddfd883f9bcf62011875c877d','万福瑞','1','','de9de2f006e145a29d52dfadda295353','104','0','73492','15005176574','15005176574','wanfr@asiainfo.com','10.143.186.50','','','','default',NULL),
('953d7b7afb74463b8819ddab685ec44d','liull7','74d26d7b602a543cc3551284b3cbff882befcba7','刘丽丽','0','','de9de2f006e145a29d52dfadda295353','104','0','76932','18522719358','18522719358','liull7@asiainfo.com','','','','','default',NULL),
('97cec572c280451a84d5952f0b071177','konglx','a7951446124d57d27767f8d9f4b652b4975cbeb8','孔令玺','1','','de9de2f006e145a29d52dfadda295353','102','0','64778','13622050798','13622050798','konglx@asiainfo.com','10.143.186.21','','','','default',NULL),
('98b6050f0fb14ecdaad79b7e3fc12f57','jinxing5','c6a38e41edf5ccc05a5c9a9db9789e6cd962122b','金星','1','','de9de2f006e145a29d52dfadda295353','102','0','75267','15034767471','15034767471','jinxing5@asiainfo.com','10.143.186.115','','','','default',NULL),
('9accc403307649f3b8fe97426821dc11','tianxj','4ba652c5aa71887a82ba24e5af99740e83f67e4a','田秀杰','0','','de9de2f006e145a29d52dfadda295353','105','0','73285','15222481690','15222481690','tianxj@asiainfo.com','10.143.186.46','','','','default',NULL),
('a0d3cc65e4894a748715565fb5b0cba3','wenyx','94c2a8214e06f1a6632613f6ea993f756cf23c63','温云仙','0','','de9de2f006e145a29d52dfadda295353','102','0','28450','18511336054','18511336054','wenyx@asiainfo.com','','','','','default',NULL),
('a20d5919f0b242b3b3aee6f67776e53e','liujun3','290cb3f2b3a8b073aae9bf2999a35a59ad2946c8','刘军','1','','de9de2f006e145a29d52dfadda295353','104','0','64785','13820137521','13820137521','liujun3@asiainfo.com','10.143.186.15','','','','default',''),
('a4f61c103b7f48a48abd8de4d91da57f','oumx','36a128392132212c509e1f3c68e59df8e2ba3951','欧明喜','1','','de9de2f006e145a29d52dfadda295353','103','0','76724','18143096182','18143096182','oumx@asiainfo.com','','','','','default',NULL),
('b17748faf28f41b8b6703af5fad7f470','zhanyang','ef4183874f228de3299260e196ccc7cb3aaf6182','战阳','0','','de9de2f006e145a29d52dfadda295353','104','0','72328','17615196366','17615196366','zhanyang@asiainfo.com','','','','','default',NULL),
('b3c7f8a39e504c6ba93a8188a7c98af3','xupeng','30e9dcc7d0f5b5e2e1b6749e97c001d0ab9531f7','徐鹏','1','','de9de2f006e145a29d52dfadda295353','106','0','66210','15002204862','15002204862','xupeng@asiainfo.com','10.143.186.23','','','','default',NULL),
('b68fd6dae541496e91af8a5b2fbf7305','zouyong','9f48592bee50c23daddf7796e3add840f182bb3d','邹勇','1','','de9de2f006e145a29d52dfadda295353','104','0','77837','18622206271','18622206271','zouyong@asiainfo.com','','','','','default',NULL),
('ba3b35896bd642c0adf7ab7de966c748','yanhl','f8c428bcf007c1cff99302e93c35d9c7f61e28a7','闫海亮','1','','de9de2f006e145a29d52dfadda295353','106','0','69673','13752390703','13752390703','yanhl@asiainfo.com','10.143.186.29','','','','default',NULL),
('bcb670bcb2644a91898dbf91803c176c','xuhx','3cc82e0e02144781193923600cdd737611c32c27','徐红星','1','','de9de2f006e145a29d52dfadda295353','101','0','62519','13820117577','13820117577','xuhx@asiainfo.com','10.143.186.17','','','','default',''),
('bf3b6b25b80f4b4ba1851a5eec56d92e','shencq','817b90aa645dcb16a75ac49a753bd29a54312275','申翠芹','0','','de9de2f006e145a29d52dfadda295353','102','0','62535','18686093113','18686093113','shencq@asiainfo.com','','','','','default',NULL),
('c0ef9303b96647cabc0f0c109a7596b2','niugang','beac2345d0e862fd1fd21ac295a411b9b68b0fcf','牛刚','1','','de9de2f006e145a29d52dfadda295353','101','0','25731','18601044032','18601044032','niugang@asiainfo.com','','','','','default',NULL),
('c143b5147d554348b683d0b4ea9e0beb','wanghao5','2ac52f371427a3dae9ec279a84710bed277f23bb','王灏','1','','de9de2f006e145a29d52dfadda295353','104','0','73227','15122053281','15122053281','wanghao5@asiainfo.com','10.143.186.45','','','','default',NULL),
('c43b88dc483a4ae88a74ba1c88a792cf','lijian3','c4552215065d3eeaebfe57898c0206758cecf395','李健','1','','de9de2f006e145a29d52dfadda295353','102','0','77177','18649071261','18649071261','lijian3@asiainfo.com','','','','','default',NULL),
('c468b13fe40247a89d9df00c299d580d','wangyg3','8a1553243d1ef60492f71cf2ff13d4423efa99e9','汪映功','1','','de9de2f006e145a29d52dfadda295353','100','0','61754','13602017334','13602017334','wangyg3@asiainfo.com','10.143.186.14','','','','default',''),
('ce016b800d51484ea7b5b1a867337b11','jiaohj','fcb8a23fbdff113bd707d71574acfdcb7c68c4b3','焦海江','1','','de9de2f006e145a29d52dfadda295353','103','0','18427','18322315901','18322315901','jiaohj@asiainfo.com','10.143.186.34','','','','default',NULL),
('d0db768d73dd41978f31036a9534e13b','lijq3','3c727ea757fb41668fd8377ec92965e2a267781e','李建全','1','','de9de2f006e145a29d52dfadda295353','102','0','14035','15022060068','15022060068','lijq3@asiainfo.com','10.143.186.32','','','','default',NULL),
('d1fd3bd8cc87476f97aaa85d79cbb4bb','wangchao11','d3b62527cd8e11307547c8dd3b130a3223b38441','王超','1','','de9de2f006e145a29d52dfadda295353','103','0','33308','18824900821','18824900821','wangchao11@asiainfo.com','','','','','default',NULL),
('d82cbd7316e4461db0b20b1c19c034bc','linb','6bb4c9387be24e8346962174dd20a1cef0b10049','李宁波','1','','de9de2f006e145a29d52dfadda295353','101','0','61572','13502145491','13502145491','linb@asiainfo.com','10.143.186.12','','','','default',''),
('dcf7e936ca524980b43441986305d567','shangshuai','9c143e2197a30a29dc037813960240368b2bd03d','尚帅','1','','de9de2f006e145a29d52dfadda295353','103','0','77841','15122917133','15122917133','shangshuai@asiainfo.com','','','','','default',NULL),
('dfc40ca4bf05406c9ffbe9b77ec23901','liangzs','2ccfc9c9fd9ddcd67ad1fd2bbcc959d4c0ddcc7f','梁子三','1','','de9de2f006e145a29d52dfadda295353','104','0','70686','13672039009','13672039009','liangzs@asiainfo.com','10.143.186.39','','','','default',NULL),
('e1b6642bcc9e49beabf64edf4b0ad44b','liuyu5','1ad59282fc56b4fbf02e5dc24777996f2293fc00','刘昱','1','','de9de2f006e145a29d52dfadda295353','103','0','72765','13352089626','13352089626','liuyu5@asiainfo.com','10.143.186.41','','','','default',NULL),
('ea8b3857e84e460dbe9b3383468f3d98','wanglx3','d9b71b31732588889ea0849074b4bb7b66a66933','王鲁星','1','','de9de2f006e145a29d52dfadda295353','104','0','73284','13622046292','13622046292','wanglx3@asiainfo.com','10.143.186.47','','','','default',NULL),
('f00f133ea6694a9c8ab7b1f0829d0741','wangchao10','ea698afd18099c40b581f5aa44128e0fcaf1cd27','王超','1','','de9de2f006e145a29d52dfadda295353','106','0','69693','15922275326','15922275326','wangchao10@asiainfo.com','10.143.186.30','','','','default',NULL),
('f70bb6d8d2724fc48d9b169aed3cfa64','zhanghz','25fb7ce3970dae6fad08bfee0f577d8514acc9f4','张海舟','1','','de9de2f006e145a29d52dfadda295353','102','0','68029','13821832475','13821832475','zhanghz@asiainfo.com','10.143.186.24','','','','default',NULL),
('f73a8920ceee43119bb43f987a5736f5','sunyx','9375df49131bf38837086adbd50c683b8473adbb','孙永兴','1','','de9de2f006e145a29d52dfadda295353','104','0','70932','18202554705','18202554705','sunyx@asiainfo.com','10.143.186.38','','','','default',NULL),
('fde548829d33471097ecb39298a60076','zhangwx6','62b12aa193b6244a0fbe1c0ddffca5bbf2ee5547','张维新','1','','de9de2f006e145a29d52dfadda295353','103','0','73130','13752742412','13752742412','zhangwx6@asiainfo.com','10.143.186.43','','','','default',NULL),
('fe419e890df44285845d112bddfe7bde','chest','5f710981df9eae56c5a56b75d480cbf098682f49','车思韬','1','','de9de2f006e145a29d52dfadda295353','103','0','72888','18722107392','18722107392','chest@asiainfo.com','10.143.186.42','','','','default',NULL),
('fe4cbf044d4247878cdb6f032cc7451a','yutao','95d6facf7236bc217a4e862f708fdd605b1d5099','于涛','1','','de9de2f006e145a29d52dfadda295353','102','0','11672','18202582410','18202582410','yutao@asiainfo.com','10.143.186.35','','','','default',NULL);

/*Table structure for table `TB_MONOLOGUE` */

DROP TABLE IF EXISTS `TB_MONOLOGUE`;

CREATE TABLE `TB_MONOLOGUE` (
  `TAG_ID` varchar(20) NOT NULL,
  `TAG_NAME` varchar(1000) DEFAULT NULL,
  `START_DATE` date DEFAULT NULL,
  `END_DATE` date DEFAULT NULL,
  `STATUS` char(1) DEFAULT '0' COMMENT '0:未解决，1：已解决',
  `TAG_AUTHOR` varchar(50) DEFAULT NULL,
  `REMARK` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`TAG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `TB_MONOLOGUE` */

insert  into `TB_MONOLOGUE`(`TAG_ID`,`TAG_NAME`,`START_DATE`,`END_DATE`,`STATUS`,`TAG_AUTHOR`,`REMARK`) values 
('201807260000011','正当芍药盛开，燕子飞来；正当玫瑰含笑，樱桃熟了，一年中最好的时节！芍药不及你美，樱桃不及你红，小弟小妹，儿童节快乐',NULL,'2018-07-26','1','liangjy',''),
('2018072600000110','眼睛要多看些美丽的风景，耳朵要多听些动听的声音，最重要的是要用心多体验些美好的事情，我们的心才不会累，愿你永远快乐，天天都有好心情！',NULL,NULL,'1','liangjy',''),
('201807260000012','每一秒时间流动，每一份思念传送，都代表着我想要送你的每一个祝福：幸福快乐。',NULL,NULL,'1','liangjy',''),
('201807260000013','知心朋友心连心，离山离海不离心，真正友谊靠真心，心心相惜是知心，千金难买友谊心，友谊一世不悔心，祝你天天都开心！',NULL,NULL,'0','liangjy',''),
('201807260000014','好事连连，好梦圆圆',NULL,NULL,'0','liangjy',''),
('201807260000015','你把月光般的关怀给我；我将太阳般的热情给你。朋友，希望我们的情谊如同日月经天，恒久不变。',NULL,NULL,'1','liangjy',''),
('201807260000016','请已随风去，何苦仍相依  夜等不归人，心痛至无期。请已随风去，何苦仍相依。',NULL,NULL,'1','liangjy',''),
('201807260000017','蔬菜营养的高低遵循由深到浅的规律，排列顺序总趋势：黑色、紫色、绿色、红色、黄色、白色。而在同一种类的蔬菜中，深色品种比浅色品种更有营养',NULL,NULL,'1','liangjy',''),
('201807260000018','友谊是一杯愈陈愈香的酒，其中酒溶液的分子就是你和我，一种亲和力将我们结合在一起。友谊是一棵树，它的成长需要阳光、热情与真挚，也同样需要土壤、朴实和坦诚',NULL,NULL,'1','liangjy',''),
('201807260000019','风霜雪雨走一路，日夜兼程不停步，笑泪各半掩双目，前途坎坷当散步，一程山水艰难赴，山穷水尽看萍浮，晨有朝霞夕落幕，潇洒走过就是福，仕途高低别在乎，工作舒心赚财富，我的问候似火炉，生日快乐常守护！\r\n',NULL,NULL,'0','liangjy','');

/*Table structure for table `TB_PICTURES` */

DROP TABLE IF EXISTS `TB_PICTURES`;

CREATE TABLE `TB_PICTURES` (
  `PICTURES_ID` varchar(100) NOT NULL,
  `TITLE` varchar(255) DEFAULT NULL COMMENT '标题',
  `NAME` varchar(255) DEFAULT NULL COMMENT '文件名',
  `PATH` varchar(255) DEFAULT NULL COMMENT '路径',
  `CREATETIME` varchar(100) DEFAULT NULL COMMENT '创建时间',
  `MASTER_ID` varchar(255) DEFAULT NULL COMMENT '属于',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`PICTURES_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `TB_PICTURES` */

insert  into `TB_PICTURES`(`PICTURES_ID`,`TITLE`,`NAME`,`PATH`,`CREATETIME`,`MASTER_ID`,`BZ`) values 
('36304210895645a3a53b2ff727480f86','sd','530505558e6a440a97e5122997b2676d.jpg','20180723/530505558e6a440a97e5122997b2676d.jpg','2018-07-23 15:01:27','1','qweq'),
('5a0ff61d70614283a8f00dd2357adf47','张三','83f88a4f9f1a47acaa5e4a02c1717b72.png','20180720/83f88a4f9f1a47acaa5e4a02c1717b72.png','2018-07-20 16:48:09','1','自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 '),
('606b6c2ce76f4ba39de8e399e67be8d8','李四','c67165a156cf489989d5518d24a1f6e2.jpg','20180720/c67165a156cf489989d5518d24a1f6e2.jpg','2018-07-20 16:48:49','1','自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 自我介绍 '),
('affb2b5c0c054e4b84c9da5cfeda2105','该死的发送到','d1cb61b9fddd4f9ebdd77f3c6abc9e84.jpg','20180723/d1cb61b9fddd4f9ebdd77f3c6abc9e84.jpg','2018-07-23 15:13:02','1','地方个人威尔士的冯绍峰的威尔士的肤色认为'),
('ce5495051c644befb7eea4f0a094092e','22','13e84e76002a4b7fb413728e87ef0f21.jpg','20180723/13e84e76002a4b7fb413728e87ef0f21.jpg','2018-07-23 15:01:12','1','331'),
('e0f77a441e474860bb449cda5bfb4fa8','尔特人生','cead63e53b5944f59050bc215be5f9ee.jpg','20180723/cead63e53b5944f59050bc215be5f9ee.jpg','2018-07-23 15:37:45','1','僧多粥少人生巅峰僧多粥少人生巅峰僧多粥少人生巅峰僧多粥少人生巅峰僧多粥少人生巅峰僧多粥少人生巅峰僧多粥少人生巅峰僧多粥少人生巅峰僧多粥少人生巅峰僧多粥少人生巅峰僧多粥少人生巅峰僧多粥少人生巅峰僧多粥少人生巅峰僧多粥少人生巅峰僧多粥少人生巅峰'),
('f6e142ea6c084437abda87ac3e1f1c96','尔特人生','fc63608bb2c64de7ab84cf610f56194d.jpg','20180723/fc63608bb2c64de7ab84cf610f56194d.jpg','2018-07-23 15:37:56','1','僧多粥少人生巅峰僧多粥少人生巅峰僧多粥少人生巅峰僧多粥少人生巅峰僧多粥少人生巅峰僧多粥少人生巅峰僧多粥少人生巅峰僧多粥少人生巅峰僧多粥少人生巅峰僧多粥少人生巅峰僧多粥少人生巅峰僧多粥少人生巅峰僧多粥少人生巅峰僧多粥少人生巅峰僧多粥少人生巅峰');

/*Table structure for table `WEIXIN_COMMAND` */

DROP TABLE IF EXISTS `WEIXIN_COMMAND`;

CREATE TABLE `WEIXIN_COMMAND` (
  `COMMAND_ID` varchar(100) NOT NULL,
  `KEYWORD` varchar(255) DEFAULT NULL COMMENT '关键词',
  `COMMANDCODE` varchar(255) DEFAULT NULL COMMENT '应用路径',
  `CREATETIME` varchar(255) DEFAULT NULL COMMENT '创建时间',
  `STATUS` int(1) NOT NULL COMMENT '状态',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`COMMAND_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `WEIXIN_COMMAND` */

insert  into `WEIXIN_COMMAND`(`COMMAND_ID`,`KEYWORD`,`COMMANDCODE`,`CREATETIME`,`STATUS`,`BZ`) values 
('2636750f6978451b8330874c9be042c2','锁定服务器','rundll32.exe user32.dll,LockWorkStation','2015-05-10 21:25:06',1,'锁定计算机'),
('46217c6d44354010823241ef484f7214','打开浏览器','C:/Program Files/Internet Explorer/iexplore.exe','2015-05-09 02:43:02',1,'打开浏览器操作'),
('576adcecce504bf3bb34c6b4da79a177','关闭浏览器','taskkill /f /im iexplore.exe','2015-05-09 02:36:48',2,'关闭浏览器操作'),
('854a157c6d99499493f4cc303674c01f','关闭QQ','taskkill /f /im qq.exe','2015-05-10 21:25:46',1,'关闭QQ'),
('ab3a8c6310ca4dc8b803ecc547e55ae7','打开QQ','D:/SOFT/QQ/QQ/Bin/qq.exe','2015-05-10 21:25:25',1,'打开QQ');

/*Table structure for table `WEIXIN_IMGMSG` */

DROP TABLE IF EXISTS `WEIXIN_IMGMSG`;

CREATE TABLE `WEIXIN_IMGMSG` (
  `IMGMSG_ID` varchar(100) NOT NULL,
  `KEYWORD` varchar(255) DEFAULT NULL COMMENT '关键词',
  `CREATETIME` varchar(100) DEFAULT NULL COMMENT '创建时间',
  `STATUS` int(11) NOT NULL COMMENT '状态',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  `TITLE1` varchar(255) DEFAULT NULL COMMENT '标题1',
  `DESCRIPTION1` varchar(255) DEFAULT NULL COMMENT '描述1',
  `IMGURL1` varchar(255) DEFAULT NULL COMMENT '图片地址1',
  `TOURL1` varchar(255) DEFAULT NULL COMMENT '超链接1',
  `TITLE2` varchar(255) DEFAULT NULL COMMENT '标题2',
  `DESCRIPTION2` varchar(255) DEFAULT NULL COMMENT '描述2',
  `IMGURL2` varchar(255) DEFAULT NULL COMMENT '图片地址2',
  `TOURL2` varchar(255) DEFAULT NULL COMMENT '超链接2',
  `TITLE3` varchar(255) DEFAULT NULL COMMENT '标题3',
  `DESCRIPTION3` varchar(255) DEFAULT NULL COMMENT '描述3',
  `IMGURL3` varchar(255) DEFAULT NULL COMMENT '图片地址3',
  `TOURL3` varchar(255) DEFAULT NULL COMMENT '超链接3',
  `TITLE4` varchar(255) DEFAULT NULL COMMENT '标题4',
  `DESCRIPTION4` varchar(255) DEFAULT NULL COMMENT '描述4',
  `IMGURL4` varchar(255) DEFAULT NULL COMMENT '图片地址4',
  `TOURL4` varchar(255) DEFAULT NULL COMMENT '超链接4',
  `TITLE5` varchar(255) DEFAULT NULL COMMENT '标题5',
  `DESCRIPTION5` varchar(255) DEFAULT NULL COMMENT '描述5',
  `IMGURL5` varchar(255) DEFAULT NULL COMMENT '图片地址5',
  `TOURL5` varchar(255) DEFAULT NULL COMMENT '超链接5',
  `TITLE6` varchar(255) DEFAULT NULL COMMENT '标题6',
  `DESCRIPTION6` varchar(255) DEFAULT NULL COMMENT '描述6',
  `IMGURL6` varchar(255) DEFAULT NULL COMMENT '图片地址6',
  `TOURL6` varchar(255) DEFAULT NULL COMMENT '超链接6',
  `TITLE7` varchar(255) DEFAULT NULL COMMENT '标题7',
  `DESCRIPTION7` varchar(255) DEFAULT NULL COMMENT '描述7',
  `IMGURL7` varchar(255) DEFAULT NULL COMMENT '图片地址7',
  `TOURL7` varchar(255) DEFAULT NULL COMMENT '超链接7',
  `TITLE8` varchar(255) DEFAULT NULL COMMENT '标题8',
  `DESCRIPTION8` varchar(255) DEFAULT NULL COMMENT '描述8',
  `IMGURL8` varchar(255) DEFAULT NULL COMMENT '图片地址8',
  `TOURL8` varchar(255) DEFAULT NULL COMMENT '超链接8',
  PRIMARY KEY (`IMGMSG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `WEIXIN_IMGMSG` */

insert  into `WEIXIN_IMGMSG`(`IMGMSG_ID`,`KEYWORD`,`CREATETIME`,`STATUS`,`BZ`,`TITLE1`,`DESCRIPTION1`,`IMGURL1`,`TOURL1`,`TITLE2`,`DESCRIPTION2`,`IMGURL2`,`TOURL2`,`TITLE3`,`DESCRIPTION3`,`IMGURL3`,`TOURL3`,`TITLE4`,`DESCRIPTION4`,`IMGURL4`,`TOURL4`,`TITLE5`,`DESCRIPTION5`,`IMGURL5`,`TOURL5`,`TITLE6`,`DESCRIPTION6`,`IMGURL6`,`TOURL6`,`TITLE7`,`DESCRIPTION7`,`IMGURL7`,`TOURL7`,`TITLE8`,`DESCRIPTION8`,`IMGURL8`,`TOURL8`) values 
('380b2cb1f4954315b0e20618f7b5bd8f','首页','2015-05-10 20:51:09',1,'图文回复','图文回复标题','图文回复描述','http://a.hiphotos.baidu.com/image/h%3D360/sign=c6c7e73ebc389b5027ffe654b535e5f1/a686c9177f3e6709392bb8df3ec79f3df8dc55e3.jpg','www.baidu.com','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

/*Table structure for table `WEIXIN_TEXTMSG` */

DROP TABLE IF EXISTS `WEIXIN_TEXTMSG`;

CREATE TABLE `WEIXIN_TEXTMSG` (
  `TEXTMSG_ID` varchar(100) NOT NULL,
  `KEYWORD` varchar(255) DEFAULT NULL COMMENT '关键词',
  `CONTENT` varchar(255) DEFAULT NULL COMMENT '内容',
  `CREATETIME` varchar(100) DEFAULT NULL COMMENT '创建时间',
  `STATUS` int(2) DEFAULT NULL COMMENT '状态',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`TEXTMSG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `WEIXIN_TEXTMSG` */

insert  into `WEIXIN_TEXTMSG`(`TEXTMSG_ID`,`KEYWORD`,`CONTENT`,`CREATETIME`,`STATUS`,`BZ`) values 
('63681adbe7144f10b66d6863e07f23c2','你好','你也好','2015-05-09 02:39:23',1,'文本回复'),
('695cd74779734231928a253107ab0eeb','吃饭','吃了噢噢噢噢','2015-05-10 22:52:27',1,'文本回复'),
('d4738af7aea74a6ca1a5fb25a98f9acb','关注','这里是关注后回复的内容','2015-05-11 02:12:36',1,'关注回复');



DROP TABLE IF EXISTS `TB_BK`;
CREATE TABLE TB_BK(
  `BK_ID` varchar(20) NOT NULL,
  `BK_TITLE` varchar(100) DEFAULT NULL,
  `BK_PROCESS_P` varchar(10) DEFAULT NULL,
  `BK_REPORT_P` varchar(10) DEFAULT NULL,
  `BK_TIME` date DEFAULT NULL,
  `BK_SUBSYS` varchar(50) DEFAULT NULL,
  `BK_REP_STATUS` char(1) DEFAULT '0' COMMENT '0:故障报告登记，1：提交审核,2:审核不通过，3,审核通过',
  `BK_DETAIL_DESCI` varchar(1000) DEFAULT NULL,
  `BK_INFLU` varchar(1000) DEFAULT NULL,
  `BK_PROCE_PROCE` varchar(1000) DEFAULT NULL,
  `BK_ANALYSISANDSUMMARY` varchar(1000) DEFAULT NULL,
  `BK_AFTERANDARRANGE` varchar(1000) DEFAULT NULL,
  `BK_AUDITOPINION` varchar(1000) DEFAULT NULL,
  `BK_PANELAUDITOR` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`BK_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO  `TB_BK`(`BK_ID`,`BK_TITLE`,`BK_PROCESS_P`,`BK_REPORT_P`,`BK_TIME`,`BK_SUBSYS`,`BK_REP_STATUS`,`BK_DETAIL_DESCI`,`BK_INFLU`,`BK_PROCE_PROCE`,`BK_ANALYSISANDSUMMARY`,`BK_AFTERANDARRANGE`,`BK_AUDITOPINION`,`BK_PANELAUDITOR`) values('20180830523','web调用esp超时','liangjy','cuirz','2018-08-30','15','0','2018-08-30 9点~11点左右，web调用esp超时。','前台','之前加固起的主机防火墙服务，业务服务请求过多，会导致iptables系统服务的内存溢出，已经临时关掉了--方瑞','无','无','无',NULL);

DROP TABLE IF EXISTS `SYS_SUBSYS`;
CREATE TABLE SYS_SUBSYS(
`SYBSYS_ID` CHAR(2)  NOT NULL,
`SYBSYS_NAME` varchar(10) NOT NULL,
PRIMARY KEY (`SYBSYS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `SYS_SUBSYS`(`SYBSYS_ID`,`SYBSYS_NAME`)VALUES ('1','NG框架'),('2','集团业务'),('3','个人业务'),('4','一级BOSS'),('5','电子渠道'),('6','携号转网'),('7','营销系统'),('8','资源系统'),('9','计费系统'),('10','统计'),('11','账务管理'),('12','信用控制'),('13','客户管理'),('14','客服系统'),('15','外围接口'),('16','账务处理'),('17','渠道系统'),('18','结算系统'),('19','其他系统');

DROP TABLE IF EXISTS `TB_CUT`;
CREATE TABLE TB_CUT(
  `CUT_ID` varchar(20) NOT NULL,
  `CUT_TITLE` varchar(100) DEFAULT NULL,
  `CUT_RESP_P` varchar(10) DEFAULT NULL,
  `IT_CUT_RESP_P` varchar(10) DEFAULT NULL,
  `CUT_TIME` date DEFAULT NULL,
  `CUT_MEMBER` varchar(300) DEFAULT NULL,
  `CUT_IT_VERIFIER` varchar(10) DEFAULT NULL,
  `CUT_DETAIL_DESCI` varchar(1000) DEFAULT NULL,
  `CUT_INFLU` varchar(1000) DEFAULT NULL,
  `CUT_PROCE_PROCE` varchar(1000) DEFAULT NULL,
  `CUT_ANALYSISANDSUMMARY` varchar(1000) DEFAULT NULL,
  `CUT_AFTERANDARRANGE` varchar(1000) DEFAULT NULL,
  `CUT_REPORT_RESP_P` varchar(10) DEFAULT NULL,
  `CUT_REPORT_BUILD_TIME` date DEFAULT NULL,
  PRIMARY KEY (`CUT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO  `TB_CUT`(`CUT_ID`, `CUT_TITLE` ,`CUT_RESP_P`, `IT_CUT_RESP_P` , `CUT_TIME`, `CUT_MEMBER` , `CUT_IT_VERIFIER` , `CUT_DETAIL_DESCI`  ,`CUT_INFLU` , `CUT_PROCE_PROCE`, `CUT_ANALYSISANDSUMMARY`, `CUT_AFTERANDARRANGE`  ,`CUT_REPORT_RESP_P`  , `CUT_REPORT_BUILD_TIME`)values ('2018091300000170','1234','cuirz','zhangjian3','2018-09-18','1111','liangjy','111','11','11','强强强强','111','admin','2018-09-12');


DROP TABLE IF EXISTS `TB_SORTPLAN`;
CREATE TABLE `TB_SORTPLAN` (
  `SP_ID` varchar(100) NOT NULL,
  `SP_TITLE` varchar(255) DEFAULT NULL COMMENT '标题',
  `SP_CONTENT` varchar(1000) DEFAULT NULL COMMENT '内容',
  `SP_PERSON` varchar(10) DEFAULT NULL,
  `SP_STARTTIME` date DEFAULT NULL COMMENT '开始时间',
  `SP_ENDTIME` date DEFAULT NULL COMMENT '结束时间',
  PRIMARY KEY (`SP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `TB_SORTPLAN`(`SP_ID`,`SP_TITLE`,`SP_CONTENT`,`SP_PERSON`, `SP_STARTTIME`,`SP_ENDTIME`)values ('11','11111','去去去11','liangjy','2018-09-12','2018-09-30');




DROP TABLE IF EXISTS `TL_SORTPLAN`;
CREATE TABLE `TL_SORTPLAN` (
  `TL_USERNAME` varchar(100),
  `TL_SP_ID` varchar(255) ,
  `TL_TIME` date ,
  PRIMARY KEY (`TL_USERNAME`,`TL_SP_ID`,`TL_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT  INTO  `TL_SORTPLAN` ( `TL_USERNAME`, `TL_SP_ID`, `TL_TIME`)values ('admin','11','2018-09-19');



