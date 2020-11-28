create database zxksglxtWeb
go
use zxksglxtWeb
go

--�û���Ϣ��
create table userInfo
(
code nvarchar(20) not null primary key,		  --�˺�
password nvarchar(100) not null,	          --����
name nvarchar(20) not null,			          --����
userType nvarchar(20) not null,		          --�û����ϵͳ����Ա��ѧ������ʦ
imageUrl nvarchar(200) null,                  --�û�ͷ��
sfzh nvarchar(18) NOT NULL,                   --���֤��
phone nvarchar(20) null                       --��ϵ�绰
)
go
insert into userInfo(code,password,name,userType,sfzh)
values('admin','123456','admin',N'ϵͳ����Ա','100000000000000000')
go
--ID��
create table IdKey
(
	type nvarchar(20) not null primary key,   --����
	id int not null                           --idֵ
)
go
--�Ծ�
create table examDescription
(
id int identity(1,1) not null primary key,    --����������
title nvarchar(100) not null,                 --����
costTime int not null,                        --ʱ������
passScore int not null,                       --�����
isPublished int not null,                     --�Ƿ��ѷ��� 0δ���� 1�ѷ�����ֻ���ѷ������Ծ�������ߴ��⣩
)
go
--���
create table exam
(
id int identity(1,1) not null primary key,    --����������
examDescription_id INT NOT NULL,              --�Ծ�ID
title nvarchar(500) not null,                 --��Ŀ
type nvarchar(20) not null,                   --��ѡ�⡢��ѡ��
resultA nvarchar(500) not null,               --Aѡ��
resultB nvarchar(500) not null,               --Bѡ��
resultC nvarchar(500) null,					  --Cѡ��
resultD nvarchar(500) null,                   --Dѡ��
correctResult nvarchar(20) not null,          --��ȷ��A��B��C��D������Ƕ�ѡ���ö��Ÿ���
score int not NULL,                           --��ֵ
orderNo int not null                          --��ţ���1��ʼ
)
go
--���Խ��
create table examResult
(
id int identity(1,1) not null primary key,    --������ID
scode nvarchar(20) not null ,                 --ѧ��
examDescription_id int not null,              --�Ծ�ID
kszt nvarchar(20) not null,                   --����״̬���ѿ��Ϳգ����ѧ����������״̬����Ϊ�ѿ�������ȱ����״̬Ϊ�գ�����
kssj datetime null,                           --ʵ�ʿ���ʱ��
score int null,                               --���Է���
jssj datetime null                            --ʵ�ʽ���ʱ��
)
go
--���Խ����ϸ
create table examResultDetail
(
id int identity(1,1) not null primary key,    --������ID
pid int not null,                             --���ID
exam_id int not null,                         --����ID
chooseResult nvarchar(20) not null,           --ѡ��Ľ��A��B��C��D������Ƕ�ѡ���ö��Ÿ���
isCorrect int default 0 not null,			  --�Ƿ���ȷ��1��ȷ 0����ȷ
score int default 0 not null				  --�÷�
)
go