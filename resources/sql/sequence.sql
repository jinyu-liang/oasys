
--第一步：创建--SEQUENCE 管理表  ``

DROP TABLE IF EXISTS SEQUENCE; 
CREATE TABLE SEQUENCE ( 
NAME VARCHAR(50) NOT NULL, 
CURRENT_VALUE INT NOT NULL, 
INCREMENT INT NOT NULL DEFAULT 1, 
PRIMARY KEY (NAME) 
) ENGINE=InnoDB;

--第二步：创建--取当前值的函数
DROP FUNCTION IF EXISTS currval; 
DELIMITER $ 
CREATE FUNCTION currval (seq_name VARCHAR(50)) 
     RETURNS INTEGER
     LANGUAGE SQL 
     DETERMINISTIC 
     CONTAINS SQL 
     SQL SECURITY DEFINER 
     COMMENT ''
BEGIN
     DECLARE value INTEGER; 
     SET value = 0; 
     SELECT current_value INTO value 
          FROM SEQUENCE
          WHERE name = seq_name; 
     RETURN value; 
END
$ 
DELIMITER ; 

--第三步：创建--取下一个值的函数
DROP FUNCTION IF EXISTS nextval; 
DELIMITER $ 
CREATE FUNCTION nextval (seq_name VARCHAR(50)) 
     RETURNS INTEGER
     LANGUAGE SQL 
     DETERMINISTIC 
     CONTAINS SQL 
     SQL SECURITY DEFINER 
     COMMENT ''
BEGIN
     UPDATE SEQUENCE
          SET current_value = current_value + increment 
          WHERE name = seq_name; 
     RETURN currval(seq_name); 
END
$ 
DELIMITER ; 

--第四步：创建--更新当前值的函数
DROP FUNCTION IF EXISTS setval; 
DELIMITER $ 
CREATE FUNCTION setval (seq_name VARCHAR(50), value INTEGER) 
     RETURNS INTEGER
     LANGUAGE SQL 
     DETERMINISTIC 
     CONTAINS SQL 
     SQL SECURITY DEFINER 
     COMMENT ''
BEGIN
     UPDATE SEQUENCE
          SET current_value = value 
          WHERE name = seq_name; 
     RETURN currval(seq_name); 
END
$ 
DELIMITER ; 



INSERT INTO SEQUENCE VALUES ('ID', 0, 1);----添加一个SEQUENCE名称和初始值，以及自增幅度
SELECT SETVAL('ID', 10);---设置指定SEQUENCE的初始值
SELECT CURRVAL('ID');--查询指定SEQUENCE的当前值
SELECT NEXTVAL('ID');--查询指定SEQUENCE的下一个值