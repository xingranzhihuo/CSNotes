
&&&&&&&&&&&&&&&&&&单表查询&&&&&&&&&&&&&&&&&&&&&&&
******************************************************************************//建立关系模式,create table;
 CREATE TABLE Student
(Name	VARCHAR(15) NOT NULL,
 SSN	CHAR(9) NOT NULL,
 Year	INTEGER,
 Speciality		VARCHAR(30),
 Department VARCHAR(30),
 Primary key (SSN))
CREATE TABLE Grade
(SSN	CHAR(9) NOT NULL,
 CNO	CHAR(7) NOT NULL,
 Score	INTEGER,
 Primary key (SSN,CNO),
 foreign key (SSN) references Student)
******************************************************************************//修改关系模式,alter table;
ALTER TABLE Student ADD Age INTEGER
ALTER TABLE Student DROP Age
******************************************************************************//删除关系模式,alter table;
DROP TABLE Student
******************************************************************************//建立索引，create index;
CREATE UNIQUE INDEX SSN_INDEX ON Student(SSN ASC) CLUSTER
******************************************************************************//删除索引，drop index;
DROP INDEX SSN_INDEX
111111111111111111111111111111111111111111111111111111111111111111111111111111//查询全体学生姓名和学号
Select Sname,Sno
From Student;
222222222222222222222222222222222222222222222222222222222222222222222222222222//查询全体学生姓名和出生年份
Select Sname,2020-Sage
From Student;
//使用列别名改变查询结果标题
Select Sname NAME,2020-Sage BIRTHDAY,LOWER(Sdept) Department
From Student;
333333333333333333333333333333333333333333333333333333333333333333333333333333//查询选修过课的学生学号
Select distinct Sno//distinct消除重复数据
From SC;
444444444444444444444444444444444444444444444444444444444444444444444444444444//查询年龄在9-21之间的学生姓名及性别
Select Sname,Ssex
From Student 
Where Sage>=19 and Sage<=21;
------------------------------------------------------------------------------
Select Sname,Ssex
From Student
Where Sage between 19 and 21;
555555555555555555555555555555555555555555555555555555555555555555555555555555//查询姓“欧阳”的学生
Select *
From Student
Where Sname='欧阳';//查询叫“欧阳”的学生
//Where Cname like '欧阳%';
***************查询以“DB_”开头，且倒数第三个字符为i的课程详细情况
Select *
From Course 
Where  Cname like 'DB\_%i__' escape '\';
//'''
**************查询以“DBi_”开头，且倒数第三个字符为i的课程详细情况
Select *
From Course
Where Cname like 'DBi\__' escape '\'
	  or Cname like 'DBi\_%i__' escape '\';
//'''
666666666666666666666666666666666666666666666666666666666666666666666666666666//查询数学系和计算机系的学生
Select *
From Student
Where Sdept='MA' or Sdept='CS';
//Where Sdept in('MA','CS');//为了加快查找速度，建立索引，HASH索引
77777777777777777777777777777777777777777777777777777777777777777777777777777//查询结果排序，查询选修了3号课程的学生的学号及其成绩，查询结果按分数叫序排列
Select Sno,Grade
From SC
Where Cno='3'
Order by Grade DESC;
8888888888888888888888888888888888888888888888888888888888888888888888888888//聚集函数
count(*)//统计元组个数
sum()//求和函数
avg()//计算均值
max()//求最大值
min()//求最小值
***********统计学生总人数
Select count(*)
From Student;
***********查询选修了课程的学生人数
Select count(distinct Sno)
From SC；
999999999999999999999999999999999999999999999999999999999999999999999999999//对查询结果进行分组
***********分组聚集group by,使用having短语筛选出最终结果。//当使用group by短语时，Select子句后面只能跟聚集函数或者分组属性
***********having和where子句区别：having短语作用于分组，从中选出满足条件的分组；
where子句作用于基表或者视图，从中选择满足条件的元组。
***********根据不同部门名字分组选出25岁以上的最高薪资和组名
Select dept_name,Max(salary)
From Employee
Where age>=25
Group by dept_name;
例：
Select dept_name,Max(salary)
From Employee
Where age>=23
Group by dept_name
Having Max(salary)>=8000;
***********查询各个课程号与相应的选课人数
Select Cno,count(distinct Sno)
From SC
Group by Cno;
***********查询所有选课学生的学号和平均分
Select Sno,avg(Grade)
From SC
Group by Sno;
***********查询选修了4门课以上的学生的学号
Select Sno
From SC
Group by Sno
Having count(*)>4;
***********查询有3门以上课程90分以上的学生的学号及90分以上的课程数
Select Sno,count(*)
From SC
Where Grade>90
Group by Sno
Having  count(*)>3;
***********查询各个课程号及相应的课程成绩在90分以上的学生人数
Select Cno,count(Sno)
From SC
Where Grade>90
Group by Cno;
***********查询银行中有多少存款用户
depositor(c_name,account_number)
Select count(distinct c_name)
From depositor;
example:查询银行中有多余3个存款帐号的存款用户名
Select c_name
From depositor
Group by c_name 
Having count(account_number)>3;
***********查询每一个年龄上人数超过20的男同学的具体人数，并按照从小到大的顺序排列
Select  Sage,count(*) 
From Student
Where Ssex='男'
Group by Sage Having count(*)>20
Order by Sage ASC;
&&&&&&&&&&&&&&&&连接查询&&&&&&&&&&&&&&&&&&
广义笛卡尔积
Select *
From R,S;
*********查询所有学生及其选课情况
Select Student.*,SC.*
From Student,SC
Where Student.Sno=SC.Sno;//连接条件
————————————————————————————————
Select *
From Student join SC on Student.Sno=SC.Sno;
example:小于21岁的同学及其选课情况
Select *
From Student join SC 
on Student.Sno=SC.Sno
Where Sage<21;
-------------------------------
去除重复属性（自然连接）
Select Student.Sno,Sname,Sage,Sdept,Cno,Grade
From Student,SC
Where Student.Sno=SC.Sno;
//采用natural join 关键词
Select *
From Student natural join SC;
*********R和S的同名属性集合为{A1,A2,A3...Ak,B1,B2...Bm},将R和S中B1,...,Bm视为不同属性进行自然连接
Select *
From R join S using(A1,...Ak);
自连接
（需要给表起别名以示区分）
*********查询每一门课的间接先修课（先修课的先修课）关系模式：Course(Cno,Cname,Cpno,Ccredit)
Select First.Cno,Second.Cpno
From Course First,Course Second
Where First.Cpno=Second.Cno; 
外连接
//处理任意连接条件
R left/right/full outer join S on 连接条件
//处理同名属性上的等值连接
R natural left/right/full outer join S
R left/right/full outer join S using(A1,...,Ak)
*********查询所有学生选课信息，保留未选课的学生信息
111111
Select *
From Student left outer join SC
on (Student.Sno=SC.Sno);
222222
Select *
From Student natural left outer join SC;
333333
Select *
From Student left outer join SC
using (Sno); 
内连接
inner join = join
多表连接
111111
From R1,R2,R3,...,Rk;
222222
From R1 natural join R2 ... natural join Rk;
333333
From R1,R2,R3,...,Rk,S1 natural join S2...natural join Sn;
********查询选修2号课且成绩在90以上学生姓名
Select Sname
From Student join SC 
Where Grade>90 and Cno='2';
___________________________
Select Sname
From Student,SC
Where Grade>90 and Cno='2' and Student.Sno=SC.Sno;
*******查询每个学生的学号，姓名，选修的课程名以及成绩
关系模式：Course(Cno,Cname,Cpno,Ccredit)
         Student(Sno,Sname,Ssex,Sage,Sdept)
         SC(Sno,Cno,Grade)
Select Sno,Sname,Cname,Grade
From Student,SC,Course
Where Student.Sno=SC.Sno and SC.Cno=Course.Cno;
******查询每个系每门课程的平均成绩*********************************************************
Select Sdept,Cname,avg(Grade)
From Student,SC,Course
Where Student.Sno=SC.Sno and SC.Cno=Course.Cno
Group by Sdept,Cname;
&&&&&&&&&&&&&&&嵌套查询&&&&&&&&&&&&&&
注意：子查询不能使用order by 子句
*******查询与“刘晨”在同一个系学习的学生（要求用自连接方式完成）******************************************
Select First.Sno,First.Sname,First.Ssex,First.Sage,First.Sdept
From Student First,Student Second
Where First.Sdept=Second.Sdept and Second.Sname='刘晨'；
********查询选修了“数据库”课程的学生学号和姓名
Select Sno,Sname
From Student,SC,Course
Where Student.Sno=SC.Sno and SC.Cno=Course.Cno and Course.Cname='数据库';
-----------------------------------------------------------------------------
Select Sno,Sname
From Student 
Where Sno in 
(Select Sno
 From SC 
 Where Cno in
 (Select Cno
  From Course
  Where Cname='数据库') 
 );
**********查询选修了1号课程的学生姓名*************************************************
相关子查询，子查询的查询条件依赖于外层父查询的某个属性值
Select Sname
From Student S
Where exists 
(
Select *
From SC
Where Sno=S.Sno and Cno='1'
)
example：查询与‘刘晨’不在同一个系学习的学生//带有in谓词的子查询
Select *
From Student 
Where Sdept not in
(
Select Sdept
From Student
Where Sname='刘晨'
);
**********查询与‘刘晨’在同一个系学习的学生//带有比较运算符的子查询
Select Sno,Sname,Sdept
From Student
Where Sdept=(
Select Sdept
From Student
Where Sname='刘晨'
);
注意：子查询一定在比较符后面
**********找出每个学生超过他自己平均成绩的课程号(相关子查询)***********************************
Select Sno,Cno
From SC X
Where Grade>
(
Select AVG(Grade)
From SC Y 
Where Y.Sno=X.Sno
);
**********查询其他系中比计算机系某一学生年龄小的学生姓名和年龄
Select Sname,Sage
From Student 
Where Sage<ANY
(
Select Sage
From Student 
Where Sdept='CS'
) AND Sdept<>'CS';
*********查询选修了全部课程的学生姓名*******************************************
Select Sname
From Student
Where not exists
(
Select *
From Course
Where not exists
	(
	 Select *
	 From SC
	 Where Sno=Student.Sno AND Cno=Course.Cno
	)
);
***********查询至少选修了学生201215122选修的全部课程的学生学号*******************************************
Select Sno
From Student X
Where not exists
(
Select *
From SC Y
Where Y.Sno='201215122' AND not exists
(
Select *
From SC Z
Where Z.Sno=X.Sno AND Z.Cno=Y.Cno
)); 
***********查询所有平均成绩超过90分的学生号码和平均成绩
Select Sno,AVG(Grade)
From SC X
Where not exists
(
Select *
From SC Y
Where Sno=X.Sno
)
********with子句查询
With High_Grade AS
(Select Sno,AVG(Grade) AS AVG_Grade
 From SC
 Group by Sno
 Having AVG_Grade>90
 )
Select Sname,AVG_Grade
From Student natural join High_Grade;
*********标量子查询
略
*********集合查询
查询CS系和年龄不大于19岁的学生
Select *
From Student
Where Sdept='CS'
UNION
Select *
From Student
Where Sage<=19;
查询CS系的年龄不大于19岁的学生
Select *
From Student
Where Sdept='CS' AND Sage<='19';
//OR
Select *
From Student 
Where Sdept='CS'
INTERSECT
Select *
From 
Where Sage<=19;
********查询CS系年龄不小于19岁的学生
Select *
From Student
Where Sdept='CS'
EXCEPT
Select *
From Student 
Where Sage<19;
*********数据插入
INSERT 
INTO SC(Sno,Cno)
VALUES('200215123','1');
********数据更新
将学号为200215122的学生改为22岁
UPDATE Student
SET Sage=22
Where Sno='200215122';
将所有的学生年龄增加1岁
UPDATE Student
SET Sage=Sage+1;
将CS系所有学生成绩置零
UPDATE SC
SET Grade=0
Where Sno in
(
Select Sno
From Student
Where Sdept='CS'
);
注意：外键表信息不允许被修改
********删除数据
DELETE
From Student
Where Sno='242542525';
********定义视图
注意:子查询不含oder by 和 distinct短语的select语句
建立计算机系视图
CREATE VIEW CS_Student
AS
Select Sno,Sname,Sage
From Student
Where Sdept='CS';
&&&&&&&&注意视图消解概念