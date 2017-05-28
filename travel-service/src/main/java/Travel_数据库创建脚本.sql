-- 删除数据库
DROP DATABASE IF EXISTS travel ;
-- 创建数据库
CREATE DATABASE travel CHARACTER SET UTF8 ;
USE travel ;
-- 1、创建部门信息表
CREATE TABLE dept (
   did                  bigint	AUTO_INCREMENT ,
   dname                varchar(50),
   eid			varchar(50),
   CONSTRAINT pk_did1 primary key (did)
) engine='innodb';
-- 2、创建职位信息表
CREATE TABLE level (
   lid                  varchar(50) ,
   title                varchar(50),
   level                int,
   CONSTRAINT pk_lid2 PRIMARY KEY (lid)
) engine='innodb';
-- 3、创建雇员信息表
CREATE TABLE emp (
   eid                  varchar(50) not null,
   lid                  varchar(50),
   did                  bigint,
   ename                varchar(50),
   sal			double ,
   phone                varchar(20),
   password             varchar(32),
   photo                varchar(200),
   note                 text,
   hiredate             date,
   ineid                varchar(50) ,
   locked		int default 0 ,
   CONSTRAINT pk_eid3 PRIMARY KEY (eid) ,
   CONSTRAINT fk_lid3 FOREIGN KEY(lid) REFERENCES level(lid) ,
   CONSTRAINT fk_did3 FOREIGN KEY(did) REFERENCES dept(did) 
) engine='innodb';
-- 4、创建角色信息表
CREATE TABLE role (
   rid                  varchar(50) ,
   title                varchar(50),
   CONSTRAINT pk_rid4 PRIMARY KEY (rid)
) engine='innodb';
-- 5、创建权限信息表
CREATE TABLE action (
   actid                varchar(50),
   rid                  varchar(50),
   title                varchar(50),
   CONSTRAINT pk_actid5 PRIMARY KEY (actid) ,
   CONSTRAINT fk_rid5 FOREIGN KEY(rid) REFERENCES role(rid) 
) engine='innodb';
-- 6、创建职务角色关系表
CREATE TABLE dept_role(
   did                  bigint,
   rid                  varchar(50),
   CONSTRAINT fk_did6 FOREIGN KEY(did) REFERENCES dept(did) ,
   CONSTRAINT fk_rid6 FOREIGN KEY(rid) REFERENCES role(rid) 
) engine='innodb';
-- 7、业务分类表
CREATE TABLE item (
   iid                  bigint  AUTO_INCREMENT ,
   title                varchar(50),
   CONSTRAINT pk_iid7 PRIMARY KEY (iid)
) engine='innodb';
-- 8、财务支出分类
CREATE TABLE type(
   tpid                 bigint  AUTO_INCREMENT ,
   title                varchar(50),
   CONSTRAINT pk_tpid8 PRIMARY KEY (tpid)
) engine='innodb';
-- 9、差旅安排表
CREATE TABLE travel (
   tid                  bigint auto_increment,
   seid                 varchar(50),
   aeid                 varchar(50),
   iid                  bigint,
   title                varchar(50),
   sdate                date,
   edate                date,
   subdate              date,
   dest			varchar(200),
   audit                int,
   note                 text,
   auddate              date,
   anote                text,
   ecount               int,
   total                double,
   CONSTRAINT pk_tid9 PRIMARY KEY (tid) ,
   CONSTRAINT fk_seid9 FOREIGN KEY(seid) REFERENCES emp(eid) ,
   CONSTRAINT fk_aeid9 FOREIGN KEY(aeid) REFERENCES emp(eid) ,
   CONSTRAINT fk_iid9 FOREIGN KEY(iid) REFERENCES item(iid) 
) engine='innodb';
--  10、差旅费用
CREATE TABLE travel_cost(
   tcid                  bigint   auto_increment,
   tpid                 bigint,
   tid                  bigint,
   price                double,
   title                varchar(200),
   CONSTRAINT pk_tcid10 PRIMARY KEY (tcid) ,
   CONSTRAINT fk_tpid10 FOREIGN KEY(tpid) REFERENCES type(tpid) ,
   CONSTRAINT fk_tid FOREIGN KEY(tid) REFERENCES travel(tid) ON DELETE CASCADE
) engine='innodb';
-- 11、人员安排
CREATE TABLE travel_emp(
   teid                 bigint auto_increment,
   tid                  bigint,
   eid                  varchar(50),
   CONSTRAINT pk_teid11 PRIMARY KEY (teid) ,
   CONSTRAINT fk_tid11 FOREIGN KEY(tid) REFERENCES travel(tid)  ON DELETE CASCADE,
   CONSTRAINT fk_eid FOREIGN KEY(eid) REFERENCES emp(eid) 
) engine='innodb';

-- 增加测试数据
-- 增加员工等级信息
-- INSERT INTO level(lid,title,level) VALUES ('president','总裁',0) ;
INSERT INTO level(lid,title,level) VALUES ('chief','总监',1) ;
INSERT INTO level(lid,title,level) VALUES ('manager','部门经理',2) ;
INSERT INTO level(lid,title,level) VALUES ('staff','普通员工',3) ;
-- 增加部门信息
INSERT INTO dept (dname) VALUES ('管理部') ;
INSERT INTO dept (dname) VALUES ('人事部') ;
INSERT INTO dept (dname) VALUES ('财务部') ;
INSERT INTO dept (dname) VALUES ('市场部') ;
INSERT INTO dept (dname) VALUES ('开发一部') ;
INSERT INTO dept (dname) VALUES ('开发二部') ;
INSERT INTO dept (dname) VALUES ('开发三部') ;
-- 增加员工信息
-- 管理部总监，用户名：mldn-chief / 密码：hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate) VALUES ('mldn-chief','chief',1,'老李','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-10-10') ;

-- 人事部经理，用户名：mldn-human / 密码：hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate) VALUES ('mldn-human','manager',2,'老张','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-10-11') ;

-- 财务部经理，用户名：mldn-finance / 密码：hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn-finance','manager',3,'老王','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-10-12','mldn-human') ;

-- 市场部经理，用户名：mldn-market / 密码：hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn-market','manager',4,'老林','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-10-13','mldn-human') ;

-- 开发一部经理，用户名：mldn-dev1 / 密码：hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn-dev1','manager',5,'老赵','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-10-14','mldn-human') ;

-- 开发二部经理，用户名：mldn-dev2 / 密码：hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn-dev2','manager',6,'老孙','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-10-15','mldn-human') ;

-- 开发三部经理，用户名：mldn-dev3 / 密码：hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn-dev3','manager',7,'老孙','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-10-16','mldn-human') ;

-- 增加部门经理信息
UPDATE dept SET eid='mldn-chief' WHERE did=1 ;
UPDATE dept SET eid='mldn-human' WHERE did=2 ;
UPDATE dept SET eid='mldn-finance' WHERE did=3 ;
UPDATE dept SET eid='mldn-market' WHERE did=4 ;
UPDATE dept SET eid='mldn-dev1' WHERE did=5 ;
UPDATE dept SET eid='mldn-dev2' WHERE did=6 ;
UPDATE dept SET eid='mldn-dev3' WHERE did=7 ;

-- 增加普通员工信息
-- 增加人事部普通员工：mldn1 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn1','staff',2,'魔乐科技-1','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-11-11','mldn-human') ;

-- 增加人事部普通员工：mldn2 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn2','staff',2,'魔乐科技-2','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-11-11','mldn1') ;

-- 增加财务部员工：mldn3 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn3','staff',3,'魔乐科技-3','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-11-12','mldn1') ;

-- 增加财务部员工：mldn4 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn4','staff',3,'魔乐科技-4','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-11-12','mldn1') ;

-- 增加财务部员工：mldn5 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn5','staff',3,'魔乐科技-5','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-11-12','mldn1') ;

-- 增加财务部员工：mldn6 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn6','staff',4,'魔乐科技-6','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-11-13','mldn1') ;

-- 增加财务部员工：mldn7 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn7','staff',4,'魔乐科技-7','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-11-13','mldn1') ;

-- 增加市场部员工：mldn8 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn8','staff',4,'魔乐科技-8','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-11-15','mldn1') ;

-- 增加市场部员工：mldn9 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn9','staff',4,'魔乐科技-9','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-11-15','mldn1') ;

-- 增加市场部员工：mldn10 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn10','staff',4,'魔乐科技-10','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-11-15','mldn1') ;

-- 增加市场部员工：mldn11 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn11','staff',4,'魔乐科技-11','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-11-15','mldn1') ;

-- 增加市场部员工：mldn12 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn12','staff',4,'魔乐科技-12','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-11-15','mldn1') ;


-- 增加开发一部员工：mldn13 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn13','staff',5,'魔乐科技-13','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-11-15','mldn2') ;

-- 增加开发一部员工：mldn14 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn14','staff',5,'魔乐科技-14','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-11-15','mldn2') ;

-- 增加开发一部员工：mldn15 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn15','staff',5,'魔乐科技-15','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-11-15','mldn2') ;

-- 增加开发一部员工：mldn16 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn16','staff',5,'魔乐科技-16','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-11-15','mldn2') ;

-- 增加开发一部员工：mldn17 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn17','staff',5,'魔乐科技-17','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-11-15','mldn2') ;

-- 增加开发二部员工：mldn18 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn18','staff',6,'魔乐科技-18','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-11-15','mldn2') ;

-- 增加开发二部员工：mldn19 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn19','staff',6,'魔乐科技-19','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-11-15','mldn2') ;

-- 增加开发二部员工：mldn20 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn20','staff',6,'魔乐科技-20','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-11-15','mldn2') ;

-- 增加开发二部员工：mldn21 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn21','staff',6,'魔乐科技-21','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-11-15','mldn2') ;

-- 增加开发二部员工：mldn22 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn22','staff',6,'魔乐科技-22','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-11-15','mldn2') ;

-- 增加开发二部员工：mldn23 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn23','staff',6,'魔乐科技-23','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-11-15','mldn2') ;


-- 增加开发二部员工：mldn24 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn24','staff',6,'魔乐科技-24','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-11-15','mldn2') ;

-- 增加开发二部员工：mldn25 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn25','staff',6,'魔乐科技-25','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-11-15','mldn2') ;

-- 增加开发三部员工：mldn26 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn26','staff',7,'魔乐科技-26','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加开发三部员工：mldn27 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn27','staff',7,'魔乐科技-27','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加开发三部员工：mldn28 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn28','staff',7,'魔乐科技-28','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加开发三部员工：mldn29 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn29','staff',7,'魔乐科技-29','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加开发三部员工：mldn30 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn30','staff',7,'魔乐科技-30','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加开发三部员工：mldn31 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn31','staff',7,'魔乐科技-31','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加开发三部员工：mldn32 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn32','staff',7,'魔乐科技-32','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加开发三部员工：mldn33 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn33','staff',7,'魔乐科技-33','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加开发三部员工：mldn34 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn34','staff',7,'魔乐科技-34','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加开发三部员工：mldn35 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn35','staff',7,'魔乐科技-35','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加开发三部员工：mldn36 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn36','staff',7,'魔乐科技-36','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加开发三部员工：mldn37 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn37','staff',7,'魔乐科技-37','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加开发三部员工：mldn38 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn38','staff',7,'魔乐科技-38','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加开发三部员工：mldn39 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn39','staff',7,'魔乐科技-39','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-12-16','mldn2') ;

-- 增加开发三部员工：mldn40 / hello
INSERT INTO emp (eid,lid,did,ename,phone,password,photo,note,hiredate,ineid) VALUES ('mldn40','staff',7,'魔乐科技-40','01051283346','2E866BF58289E01583AD418F486A69DF','nophoto.png','很好的员工','2010-12-16','mldn2') ;

UPDATE emp SET sal=888.99 ;

-- 增加出差支出项
INSERT INTO type(title) VALUES ('住宿费') ;
INSERT INTO type(title) VALUES ('餐费') ;
INSERT INTO type(title) VALUES ('交通费') ;
INSERT INTO type(title) VALUES ('油费') ;
INSERT INTO type(title) VALUES ('其它') ;

-- 增加出差业务类型
INSERT INTO item(title) VALUES ('扩展新客户') ;
INSERT INTO item(title) VALUES ('驻外开发') ;
INSERT INTO item(title) VALUES ('项目维护') ;
INSERT INTO item(title) VALUES ('系统升级') ;
INSERT INTO item(title) VALUES ('项目部署') ;

-- 增加角色信息
INSERT INTO role(rid,title) VALUES ('emp','【人事部】雇员信息管理') ;
INSERT INTO role(rid,title) VALUES ('travel','【所有部门】差旅安排') ;
INSERT INTO role(rid,title) VALUES ('travelaudit','【人事部】差旅安排') ;
INSERT INTO role(rid,title) VALUES ('empshow','【管理部】雇员信息浏览') ;


-- 增加权限信息
INSERT INTO action(actid,rid,title) VALUES ('dept:list','emp','部门列表') ;
INSERT INTO action(actid,rid,title) VALUES ('dept:edit','emp','部门编辑') ;
INSERT INTO action(actid,rid,title) VALUES ('emp:list','emp','雇员列表') ;
INSERT INTO action(actid,rid,title) VALUES ('emp:add','emp','雇员增加') ;
INSERT INTO action(actid,rid,title) VALUES ('emp:edit','emp','雇员编辑') ;
INSERT INTO action(actid,rid,title) VALUES ('emp:delete','emp','雇员删除') ;
INSERT INTO action(actid,rid,title) VALUES ('emp:get','emp','雇员查看') ;
INSERT INTO action(actid,rid,title) VALUES ('travel:add','travel','出差申请') ;
INSERT INTO action(actid,rid,title) VALUES ('travel:edit','travel','出差申请修改') ;
INSERT INTO action(actid,rid,title) VALUES ('travel:self','travel','我的申请') ;
INSERT INTO action(actid,rid,title) VALUES ('travel:submit','travel','提交申请') ;
INSERT INTO action(actid,rid,title) VALUES ('travel:delete','travel','删除申请') ;
INSERT INTO action(actid,rid,title) VALUES ('travelaudit:list','travelaudit','差旅申请列表') ;
INSERT INTO action(actid,rid,title) VALUES ('travelaudit:prepare','travelaudit','待审核申请列表') ;
INSERT INTO action(actid,rid,title) VALUES ('travelaudit:handle','travelaudit','申请处理') ;

INSERT INTO action(actid,rid,title) VALUES ('deptshow:list','empshow','部门列表') ;
INSERT INTO action(actid,rid,title) VALUES ('empshow:list','empshow','雇员列表') ;
INSERT INTO action(actid,rid,title) VALUES ('empshow:get','empshow','雇员查看') ;



-- 部门与角色关联
INSERT INTO dept_role(did,rid) VALUES (1,'travel') ;
INSERT INTO dept_role(did,rid) VALUES (2,'travel') ;
INSERT INTO dept_role(did,rid) VALUES (3,'travel') ;
INSERT INTO dept_role(did,rid) VALUES (4,'travel') ;
INSERT INTO dept_role(did,rid) VALUES (5,'travel') ;
INSERT INTO dept_role(did,rid) VALUES (6,'travel') ;
INSERT INTO dept_role(did,rid) VALUES (7,'travel') ;
INSERT INTO dept_role(did,rid) VALUES (1,'empshow') ;
INSERT INTO dept_role(did,rid) VALUES (2,'emp') ;
INSERT INTO dept_role(did,rid) VALUES (2,'travelaudit') ;

