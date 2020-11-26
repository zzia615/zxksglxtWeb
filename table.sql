create database OA_OFFICE
go

use OA_OFFICE
go
--菜单表
create table menuInfo
(
id nvarchar(50) not null primary key,  --菜单ID
pid nvarchar(50) null,                 --父菜单ID
title nvarchar(30) not null,           --标题
icon nvarchar(100) null,               --图表class
uri nvarchar(100) null,                --网址
seqNo int not null                     --排序号
)
go
--初始化菜单信息
delete from menuInfo
go
insert into menuInfo values('addressBook',null,N'通讯录','fas fa-address-book','AddressBook.aspx',10)

insert into menuInfo values('jcsj',null,N'基础数据',null,null,30)
insert into menuInfo values('sslwh','jcsj',N'宿舍楼维护',null,'sslwh.aspx',31)
insert into menuInfo values('sswh','jcsj',N'宿舍维护',null,'sswh.aspx',32)
insert into menuInfo values('sswh','jcsj',N'宿舍维护',null,'sswh.aspx',32)

go

--用户信息表
create table userInfo
(
code nvarchar(20) not null,			--账号
password nvarchar(100) not null,	--密码
name nvarchar(20) not null,			--姓名
userType nvarchar(20) not null,		--用户类别：系统管理员、学生、老师
imageUrl nvarchar(200) null,        --用户头像
buildNo nvarchar(200) null,         --宿舍楼
phone nvarchar(20) null             --联系电话
)
go

insert into userInfo(code,password,name,userType)
values('admin','123456','admin',N'系统管理员')
go

--ID表
create table IdKey
(
	type nvarchar(20) not null primary key,    --类型
	id int not null                            --id值
)
go

--角色表
create table role
(
id int identity(1,1) not null primary key,   --角色编码
name nvarchar(100) not null,                 --角色名
rights nvarchar(2000) null                   --角色权限
)
go

delete from role
go
insert into role(name,rights)values(N'系统管理员',N'["bmwh","bxsh","bxsq","cwgl","jcsj","jswh","ksdk","lzsh","lzsq","rsgl","rzsh","rzsq","wjgx","wjsc","wjxz","addressBook","kqbk","kqbksh","kqgl","kqjl","ygqj","ygqjsh"]')
go
--试卷
create table examDescription
(
id int identity(1,1) not null primary key,    --自增长主键
name nvarchar(100) not null,                  --名称
costTime int not null,                        --时间限制
passScore int not null,                       --及格分
isPublished int not null,                     --是否已发布 0未发布 1已发布（只有已发布的试卷才能在线答题）
)
--题库
create table exam
(
id int identity(1,1) not null primary key,    --自增长主键
examDescription_id INT NOT NULL,              --试卷ID
title nvarchar(500) not null,                 --题目
type nvarchar(20) not null,                   --单选题、多选题
resultA nvarchar(500) not null,               --A选项
resultB nvarchar(500) not null,               --B选项
resultC nvarchar(500) not null,               --C选项
resultD nvarchar(500) not null,               --D选项
correctResult nvarchar(20) not null,          --正确答案A、B、C、D，如果是多选则用逗号隔开
score int not NULL,                            --分值
orderNo int not null                           --序号，从1开始
)
--考试结果
create table examResult
(
id int identity(1,1) not null primary key,   --自增长ID
scode nvarchar(20) not null ,                --学号
examDescription_id int not null,             --试卷ID
kszt nvarchar(20) not null,                  --考试状态：已考和空，如果学生交卷了则将状态更改为已考，否则按缺考（状态为空）处理
kssj datetime null,                          --实际考试时间
score int null,                              --考试分数
jssj datetime null                           --实际交卷时间
)
--考试结果明细
create table examResultDetail
(
id int identity(1,1) not null primary key,   --自增长ID
pid int not null,                            --结果ID
exam_id int not null,                        --试题ID
chooseResult nvarchar(20) not null           --选择的结果A、B、C、D，如果是多选则用逗号隔开
)