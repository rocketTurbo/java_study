# 0 大纲

> mysql的学习，分为2大块：
>
> ​	a. 基本的操作：建库，建表，对表中记录的增删改
>
> ​        b. 对表中记录的查询，是核心内容。没啥诀窍，多写而已。





# 1-基本操作

### 1-1 建库

```
创建一个名字叫"school"的数据库
```

###  1-2 建表

```
在"school"数据库中，创建学生表
   	学生表，有下列字段：
   		id  学号，主键，自增
   		name  姓名, 最长10个字符
   		sex   性别
   		age  年龄
```

### 1-3 操作表

```
1- 使用一条sql语句，插入一个学生数据
    张三，男，20 

2- 使用一条sql语句，插入三个学生数据
	李四，男，21    王五， 女， 23     赵六， 女 ， 19
	
3- 修改张三的年龄为18岁

4-删除年龄小于20岁的学生



```



# 2-单表查询

### 2-1 准备数据

```
前提：
	a. 使用"hello"数据库
	b. 创建表，并准备初始化数据(请直接拷贝，并执行)
		* 学生表student：学号sid, 性别sex, 名字name, 年龄age, 成绩score, 类型type

-- 使用hello数据库
use hello;

-- 建表
create table student(sid int primary key auto_increment, sex char(4),
          name char(10), age int , score int, type char(10));
          
 -- 插入原始数据         
 insert into student values(null,"小明","男",17, 81, "第一组");
 insert into student values(null,"小王","男",19, 82, "第一组");
 insert into student values(null,"小花","女",19, 95, "第一组");
 insert into student values(null,"小赵","女",42, 99, "第一组");
 insert into student values(null,"张三","男",23, 56, "第二组");
 insert into student values(null,"张四","女",17, 80, "第二组");
 insert into student values(null,"张五哥","男",22, 99, null);
 insert into student values(null,"李明","男",15, 88, "第二组");
 insert into student values(null,"王三","女",17, 66, "第三组");
 insert into student values(null,"李四","男",16, 80, "第三组");
 insert into student values(null,"老明","男",34, 90, "第三组");
 
 -- 查看添加数据
 select * from student;

```



### 2-2 查询操作实战

###### 2-2-1 基础

```
--  基础
1. 全表查询：查询所有的学生信息
select *from student; 

2. 全表查询：查询学生的学号，年龄，性别

3. 别名查询：查询学生的学号，年龄，性别，使用别名，在查询结果中使用中文显示。

4. 运算查询：把男生的成绩查询出来，并每人减去20分，显示

5. 运算查询：查询所有不及格的学生，并显示其差多少分及格

6. 去重查询：把学生所有的年龄查询出来，重复的就不显示。

7. 去重查询：把所有的不同的年龄和性别组合查询出来。

```

###### 2-2-2 条件

```
-- 条件

8. 查询姓名是2个字，并且姓“张”的

9. 查询名字包含“张”的

10. 查询名字是2个字，并且包含“张”的

11. 查询不属于任何一组的学生

12. 查询年龄是12,20,22,这个3个值的所有男生。

13. 查询男生中，年龄大于20岁的。

14. 查询男生中，年龄大于20岁，或者成绩高于80分的。

15. 查询年龄不是在18岁到20岁的所有学生。

16. 查询年龄不是在18岁到20岁的所有女生。

```

###### 2-2-3 统计查询（重点，难点）

```
-- 统计查询  where group by  having 
17. 查询年龄最大的学生，是多少岁

18. 查询各组，成绩最高的值是多少。

19. 查询第一组的平均成绩，总成绩，成绩最高的，成绩最低的

20. 分别查询男生，女生的平均成绩。

21. 查询每组中，年龄最小的年龄是多少

22. 查询某组，该组学生的平均成绩大于80分。

23. 查询某组，该组学生中，平均年龄大于20岁，最高成绩超过90分。

24. 查询某组，该组学生中，年龄超过30岁的男生，超过2人。

25. 查询某个性别，该性别中，人数超过5人，并且平均年龄小于20岁。

26. 查询某个性别，该性别中，年龄小于18的人数超过2人
```

### 2-3 讲解：查询的写法

###### 2-3-1 查询的基本技巧

第一步：整理表结构：student (sid--id, sex--性别,  name--姓名, age--年龄 ,score--成绩 ,type--类型 );



第二步：理解where的筛选。

```
 例如：select * from student where sex ='男';

 看到上述sql语句，我们大脑里面，建立的想象是：

   把student表中，所有的记录一条条的拿出来，然后，根据每条记录的sex属性的值，是否是'男'，如果'是'，放入结果集；否则，丢弃。

```



###### 2-3-2 分组查询

> 分组查询，是单表查询的难点。

a. 分组查询的核心思想

```
* 分组之后，数据的基本单位：不是一条记录，而是多条记录组成的一组记录。（最核心的一句话）
* 即：分组之后，失去了个性，没有自我，只作为群体的一部分存在。在群体里面，无法查询个性化的信息。

例如： 
  假设学生表有50名学生，男生30个，女生20个。
  根据'性别'分组，分组之后，学生表的记录，就不是50条，而是2条，更加准确的来说是2组。
  1组，是'男生'，由30个男生的记录组成。
  另外1组，是'女生'，由20个女生的记录组成。

     对于'男生'这组记录，去查询个性化信息，是没有意义，也是错误的。例如：查询'年龄'属性，因为30个男生的年龄是不同的，查询是没有意义的。
     
    注意：查询性别有意义，因为30个男生的性别相同。
 
   对于分组之后的数据，一般使用统计查询，即：查询'男生'这组的，年龄的最大值，最小值，平均值，等等。
```



b. 3个关键字的理解：where，  group by ，having



```
在理解上述核心思想的基础上，在回顾3个关键字的使用：

要点：记住3个语句的执行顺序
	a. 	where,group by, having三者的执行顺序
		where：	第1个执行，即在group by分组之前执行
		group by:第2个执行，按照指定的字段（属性）分组
		having:  第3个执行，即在group by分组之后执行
	
	b.where和having的区别
		* where：分组之前筛选，因没有分组，故where语句不能使用统计函数。
		* having:分组之后筛选，因已经分组，故having语句可以使用统计函数。

```

c. 实战讲解

```
23. 查询某组，该组学生中，平均年龄大于20岁，最高成绩超过90分。

 平均年龄大于20岁：
     平均年龄，是统计数据，需要分组之后，通过having 筛选
 最高成绩超过90分：
     最高成绩，是统计数据，需要分组之后，通过having筛选



24. 查询某组，该组学生中，年龄超过30岁的男生，超过2人。

 年龄超过30岁的男生：
     年龄，是个体数据，分组之前，使用where筛选
     
 超过2人：
     超过2人，是统计数据，需要分组之后，通过having筛选




25. 查询某个性别，该性别中，人数超过5人，并且平均年龄小于20岁。

 人数超过5人：
     人数超过5人，是统计数据，需要分组之后，通过having筛选
     
 平均年龄小于20岁：
     平均年龄，是统计数据，需要分组之后，通过having筛选


26. 查询某个性别，该性别中，年龄小于18的人数超过2人
 年龄小于18：
     年龄，，是个体数据，分组之前，使用where筛选
     
 超过2人：
    超过2人，是统计数据，需要分组之后，通过having筛选

```





# 3 多表查询与子查询理论

### 3-1 多表查询

###### 3-1-1 基础：拆表

a.  拆表的原因

> 参考讲师笔记：单表的缺陷

b. 外键的作用

> 拆表后，使用外键，表示表与表的关系。



###### 3-1-2 步骤

```
多表查询的秘诀
    a. 先确定数据要用到哪些表
    b. 将第一步确定的表，进行交叉查询产生的结果(笛卡尔积)，看做是一个新表【一个虚拟表，数据更多，存在无效数据】
    c. 去掉不符合逻辑的数据	 【提示：根据表与表的关系去掉，优先考虑外键】
    d. 把处理后的新表，看作单表，按照单表查询的规则，添加的查询条件。
```



### 3-2 子查询

###### 3-2-1 子查询的3种结果

a. 子查询的结果是一个值的情况

```
子查询结果只要是单行单列，肯定在WHERE后面作为条件，父查询使用：比较运算符，如：> 、<、<>、= 等

例如：
  SELECT 查询字段 FROM 表 WHERE 字段 =（子查询）;
  
```

b.子查询的结果是单列多行的情况

```
子查询结果是单例多行，结果集类似于一个数组，父查询使用:IN运算符

例如：
SELECT 查询字段 FROM 表 WHERE 字段  in （子查询）;

```

c. 子查询的结果是多行多列的情况

```
子查询结果只要是多列，肯定在FROM后面作为表; 子查询作为表需要取别名，否则这张表没有名称则无法访问表中的字段

例如：
SELECT 查询字段 FROM （子查询） 表别名 WHERE 条件;
```



### 3-3 猫论

###### 3-3-1 基础

> 不管白猫黑猫，抓到老鼠，就是好猫。在很多情况下，子查询和多表查询，都可以获取正确的结果，一般来说，子查询的逻辑更加清晰。



# 4 多表查询实战

### 4-1 基础

###### 4-1-1 准备数据

```
drop database  homework1;
create database homework1;
use homework1;

-- 创建表,留意建表顺序
create table teacher(tid int primary key,
         name char(20));

create table student(sid int primary key auto_increment,
		name char(10), age int, fk_tid int,
         foreign key (fk_tid) references teacher(tid)
         );

-- 插入原始数据
insert into teacher values(1, "小毕");
insert into teacher values(2, "老姚");
insert into teacher values(3, "老毕");

insert into student values(null,"黎明1",33,1);
insert into student values(null,"黎明2",23,1);
insert into student values(null,"黎明3",13,1);
insert into student values(null,"黎明4",43,1);
insert into student values(null,"小楼1",23,2);
insert into student values(null,"小楼2",23,2);
insert into student values(null,"小楼3",22,2);
insert into student values(null,"小楼4",27,2);
insert into student values(null,"小楼5",18,2);
insert into student values(null,"小楼6",16,2);
insert into student values(null,"赵四1",36,3);
insert into student values(null,"赵四2",37,3);
insert into student values(null,"赵四3",38,3);

```

###### 4-1-2 实战

```
1. 查询“老毕”老师，教授的所有学生的姓名和年龄。

2. 查询“小楼1”同学的老师姓名。

3. 查询“老姚”老师，所有学生的平均年龄。

4. 查询老师名字里面包含“毕”字的，其教授学生最大年龄。

5. 查询“老毕”老师的学生中，年龄比其平均年龄小的学生的姓名和年龄。

6. 查询“老姚”老师中，学生的年龄比“小毕”老师年龄最小的还要小的学生姓名。

7. 查询“老姚”老师的所有学生的姓名和年龄，并按照年龄从小到大排序，显示

8. 查询“小毕”和“老毕”2位老师的所有学生中，年龄最大的2位的年龄和姓名。
```



### 4-2 体会:子查询与多表查询

###### 4-2-1 准备数据

```
数据同上一题
```

###### 4-2-2 实战

```
体会：* “子查询”和“多表连接查询”，很多时候，可以互相代替

* 下列查询，要求：“多表查询”和“子查询”分别完成一次
	
3. 习题
	* 查询“老毕”老师，教授的所有学生的姓名和年龄。
```



### 4-3 扩展

###### 4-3-1 准备数据

```
-- 新建数据库
drop database  homework2;
create database homework2;
use homework2;

-- 创建表,留意建表顺序
 -- 老师表:老师id, 姓名
create table teacher(tid int primary key,
         name char(20));
         
 -- 课程表：课程id, 课程名称，老师id
create table course(cid int primary key,
		name char(10), 
		fk_tid int,
         foreign key (fk_tid) references teacher(tid)
     );
 
 -- 学生表：学生id, 姓名
create table student(sid int primary key,
		name char(10));
		
 -- 选课表：学生id, 课程id, 成绩
create table sc(
		fk_sid int, 
		fk_cid int,
		score int,
         foreign key (fk_sid) references student(sid),
         foreign key (fk_cid) references course(cid)    
     ); 

-- 插入原始数据
-- 老师表
insert into teacher values(1001, "毕老师");
insert into teacher values(1002, "石老师");
insert into teacher values(1003, "王老师");

-- 课程表
insert into course values(2001, "语文",1001);
insert into course values(2002, "英语",1001);
insert into course values(2003, "数学",1002);
insert into course values(2004, "地理",1003);
insert into course values(2005, "历史",1003);

-- 学生表
insert into student values(3001,"张三");
insert into student values(3002,"李四");
insert into student values(3003,"王五");
insert into student values(3004,"赵六");
insert into student values(3005,"田七");

-- 选课表：主键id, 学生id, 课程id, 成绩

insert into sc values(3001,2001,66);
insert into sc values(3001,2002,77);
insert into sc values(3001,2004,88);
insert into sc values(3001,2005,88);

insert into sc values(3002,2001,66);
insert into sc values(3002,2003,67);

insert into sc values(3003,2003,80);
insert into sc values(3003,2004,81);

insert into sc values(3004,2001,82);
insert into sc values(3004,2003,83);
insert into sc values(3004,2004,84);
insert into sc values(3004,2005,85);

insert into sc values(3005,2002,86);
insert into sc values(3005,2003,87);
insert into sc values(3005,2004,88);

```

###### 4-3-2 实战

```
* 表信息：
teacher(tid, name) 老师表
course(cid, name, fk_tid) 课程表
student(sid, name) 学生表
sc(fk_sid, fk_cid,score) 选课表


-- 第一部分：找找感觉（2表查询）

1. 查询"毕老师"教授的课程名称

2. 查询学生“张三”的选课数量。

3. 查询“英语”课的平均成绩


-- 第二部分：不要慌，道理是一样的（道理：多表查询的规则）

4. 查询所有选修“英语”课的学生姓名  （3表查询）

5. 查询选修“石老师”的学生的id. (3表查询)

6. 查询选修“石老师”的学生的id和姓名. (4表查询)


-- 第三部分：高级：体会：子查询的结果不唯一。

7. 查询选修“毕老师”教授课程的所有学生的id.

	提示：第7题有难度
		* 查询了选修课程编号2001或者2002的所有学生id。再次提示(in)

8. 查询选修“毕老师”教授课程的所有学生的id和姓名。


-- 第四部分：高级：自连接，自己连接自己。
	* 提示：自己连接自己

9. 查询英语成绩比语文成绩高的学生id

10. 查询英语成绩比语文成绩高的学生的id和姓名。
```



### 4-4 讲解：自连接

> 自连接，是一种特殊的多表查询。其特点是：自己连接自己，即查询的2个表，是同一个表。
>
> 核心理念：需要一种“精神分裂”，人为的把一个表，看做是2个表。例如：上题中，把成绩表，强制看成2个表：一个是：英语成绩表，一个是语文成绩表。









