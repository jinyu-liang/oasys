-- ----------------------------
-- Table structure for "C##NEWO"."${tabletop}${objectNameUpper}"
-- ----------------------------
-- DROP TABLE "C##NEWO"."${tabletop}${objectNameUpper}";
CREATE TABLE "C##NEWO"."${tabletop}${objectNameUpper}" (
<#list fieldList as var>
	<#if var[1] == 'Integer'>
	"${var[0]}" NUMBER(${var[5]}) NULL ,
	<#else>
	"${var[0]}" VARCHAR2(${var[5]} BYTE) NULL ,
	</#if>
</#list>
	"${objectNameUpper}" VARCHAR2(100 BYTE) NOT NULL 
)
LOGGING
NOCOMPRESS
NOCACHE
;

<#list fieldList as var>
COMMENT ON COLUMN "C##NEWO"."${tabletop}${objectNameUpper}"."${var[0]}" IS '${var[2]}';
</#list>
COMMENT ON COLUMN "C##NEWO"."${tabletop}${objectNameUpper}"."${objectNameUpper}" IS 'ID';

-- ----------------------------
-- Indexes structure for table ${tabletop}${objectNameUpper}
-- ----------------------------

-- ----------------------------
-- Checks structure for table "C##NEWO"."${tabletop}${objectNameUpper}"

-- ----------------------------

ALTER TABLE "C##NEWO"."${tabletop}${objectNameUpper}" ADD CHECK ("${objectNameUpper}" IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table "C##NEWO"."${tabletop}${objectNameUpper}"
-- ----------------------------
ALTER TABLE "C##NEWO"."${tabletop}${objectNameUpper}" ADD PRIMARY KEY ("${objectNameUpper}");
