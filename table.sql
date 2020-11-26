create database OA_OFFICE
go

use OA_OFFICE
go
--�˵���
create table menuInfo
(
id nvarchar(50) not null primary key,  --�˵�ID
pid nvarchar(50) null,                 --���˵�ID
title nvarchar(30) not null,           --����
icon nvarchar(100) null,               --ͼ��class
uri nvarchar(100) null,                --��ַ
seqNo int not null                     --�����
)
go
--��ʼ���˵���Ϣ
delete from menuInfo
go
insert into menuInfo values('addressBook',null,N'ͨѶ¼','fas fa-address-book','AddressBook.aspx',10)

insert into menuInfo values('jcsj',null,N'��������',null,null,30)
insert into menuInfo values('sslwh','jcsj',N'����¥ά��',null,'sslwh.aspx',31)
insert into menuInfo values('sswh','jcsj',N'����ά��',null,'sswh.aspx',32)
insert into menuInfo values('sswh','jcsj',N'����ά��',null,'sswh.aspx',32)

go

--�û���Ϣ��
create table userInfo
(
code nvarchar(20) not null,			--�˺�
password nvarchar(100) not null,	--����
name nvarchar(20) not null,			--����
userType nvarchar(20) not null,		--�û����ϵͳ����Ա��ѧ������ʦ
imageUrl nvarchar(200) null,        --�û�ͷ��
buildNo nvarchar(200) null,         --����¥
phone nvarchar(20) null             --��ϵ�绰
)
go

insert into userInfo(code,password,name,userType)
values('admin','123456','admin',N'ϵͳ����Ա')
go

--ID��
create table IdKey
(
	type nvarchar(20) not null primary key,    --����
	id int not null                            --idֵ
)
go

--��ɫ��
create table role
(
id int identity(1,1) not null primary key,   --��ɫ����
name nvarchar(100) not null,                 --��ɫ��
rights nvarchar(2000) null                   --��ɫȨ��
)
go

delete from role
go
insert into role(name,rights)values(N'ϵͳ����Ա',N'["bmwh","bxsh","bxsq","cwgl","jcsj","jswh","ksdk","lzsh","lzsq","rsgl","rzsh","rzsq","wjgx","wjsc","wjxz","addressBook","kqbk","kqbksh","kqgl","kqjl","ygqj","ygqjsh"]')
go
--�Ծ�
create table examDescription
(
id int identity(1,1) not null primary key,    --����������
name nvarchar(100) not null,                  --����
costTime int not null,                        --ʱ������
passScore int not null,                       --�����
isPublished int not null,                     --�Ƿ��ѷ��� 0δ���� 1�ѷ�����ֻ���ѷ������Ծ�������ߴ��⣩
)
--���
create table exam
(
id int identity(1,1) not null primary key,    --����������
examDescription_id INT NOT NULL,              --�Ծ�ID
title nvarchar(500) not null,                 --��Ŀ
type nvarchar(20) not null,                   --��ѡ�⡢��ѡ��
resultA nvarchar(500) not null,               --Aѡ��
resultB nvarchar(500) not null,               --Bѡ��
resultC nvarchar(500) not null,               --Cѡ��
resultD nvarchar(500) not null,               --Dѡ��
correctResult nvarchar(20) not null,          --��ȷ��A��B��C��D������Ƕ�ѡ���ö��Ÿ���
score int not NULL,                            --��ֵ
orderNo int not null                           --��ţ���1��ʼ
)
--���Խ��
create table examResult
(
id int identity(1,1) not null primary key,   --������ID
scode nvarchar(20) not null ,                --ѧ��
examDescription_id int not null,             --�Ծ�ID
kszt nvarchar(20) not null,                  --����״̬���ѿ��Ϳգ����ѧ����������״̬����Ϊ�ѿ�������ȱ����״̬Ϊ�գ�����
kssj datetime null,                          --ʵ�ʿ���ʱ��
score int null,                              --���Է���
jssj datetime null                           --ʵ�ʽ���ʱ��
)
--���Խ����ϸ
create table examResultDetail
(
id int identity(1,1) not null primary key,   --������ID
pid int not null,                            --���ID
exam_id int not null,                        --����ID
chooseResult nvarchar(20) not null           --ѡ��Ľ��A��B��C��D������Ƕ�ѡ���ö��Ÿ���
)