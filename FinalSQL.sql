-- Users Table That have the Informations of the Users 

--drop table Users;
/*create table Users(
	Users_id int identity,
	Users_name varchar(15),
	Users_number varchar(11),
	Users_cash int,
	Users_score int default 0,
	primary key(Users_id)
);

insert into Users (Users_name ,Users_number, Users_cash ) values ('Ali Abbasi' , '09112727117' , 20);
insert into Users (Users_name ,Users_number, Users_cash ) values ('Saeed Maruof' , '09155552986' , 35);
insert into Users (Users_name ,Users_number, Users_cash ) values ('Mamad akhgari' , '09212136546' , 50);
insert into Users (Users_name ,Users_number, Users_cash ) values ('Mitra allaei' , '09331756519' , 10);
insert into Users (Users_name ,Users_number, Users_cash ) values ('atefe zare' , '09122654789' , 100);
*/


-- The Goods Table have the Information of the Goods of digikala

--drop table Goods;
/*create table Goods(
	Goods_id int identity,
	Goods_name varchar(15),
	Goods_group int, -- the groups of the goods are in (see the definition of this project)
	Goods_price int,
	Goods_discount int, -- the discount of this Goods
	stock int , -- how many we have
	primary key(Goods_id)
);

insert into Goods(Goods_name ,Goods_group, Goods_price , Goods_discount , stock ) values ('A15' , 1 ,7000 , 15 , 35); --1
insert into Goods(Goods_name ,Goods_group, Goods_price , Goods_discount , stock ) values ('Asus k555l' , 1 ,35000 , 10 , 5); --2
insert into Goods(Goods_name ,Goods_group, Goods_price , Goods_discount , stock ) values ('iPhone X' , 1 ,20000 , 5 , 3); --3
insert into Goods(Goods_name ,Goods_group, Goods_price , Goods_discount , stock ) values ('Moble' , 2 ,8000 , 21 , 2); --4
insert into Goods(Goods_name ,Goods_group, Goods_price , Goods_discount , stock ) values ('Tv' , 2 ,15000 , 32 , 10); --5
insert into Goods(Goods_name ,Goods_group, Goods_price , Goods_discount , stock ) values ('Poofack' , 3 ,5 , 7 , 200); --6
insert into Goods(Goods_name ,Goods_group, Goods_price , Goods_discount , stock ) values ('Chepse' , 3 ,8 , 7 , 200); --7
insert into Goods(Goods_name ,Goods_group, Goods_price , Goods_discount , stock ) values ('HayBay' , 3 ,2 , 7 , 200); --8
insert into Goods(Goods_name ,Goods_group, Goods_price , Goods_discount , stock ) values ('Pepsi' , 3 ,11 , 5 , 120); --9
insert into Goods(Goods_name ,Goods_group, Goods_price , Goods_discount , stock ) values ('Oil' , 3 ,120 , 14 , 50); --10
*/


-- The History Table have the history of buy the goods by users 

--drop table history;
/*create table history(
	His_id int identity,
	Users_id int ,
	Goods_id int ,
	Date_of_buy date ,
	computed char(1) default 'N',
	primary key(His_id),
	foreign key(Users_id) references Users (Users_id),
	foreign key(Goods_id) references Goods (Goods_id),
	CONSTRAINT ck_testbool_ischk CHECK (computed IN ('Y', 'N'))
);

insert into history(Users_id ,Goods_id, Date_of_buy ) values ( 1 , 8 , '2018-10-19');
insert into history(Users_id ,Goods_id, Date_of_buy ) values ( 3 , 7 , '2019-03-27');
insert into history(Users_id ,Goods_id, Date_of_buy ) values ( 3 , 9 , '2019-12-12');
insert into history(Users_id ,Goods_id, Date_of_buy ) values ( 5 , 5 , '2021-11-11');
insert into history(Users_id ,Goods_id, Date_of_buy ) values ( 5 , 6 , '2021-11-11');
insert into history(Users_id ,Goods_id, Date_of_buy ) values ( 5 , 10 , '2021-11-11');
*/



-- The Comments Table have the Comments of each User for a goods

--drop table Comments;
/*create table Comments(
	Com_id int identity,
	Users_id int ,
	Goods_id int ,
	Com_body varchar(150),
	Date_of_Com date ,
	computed char(1) default 'N',
	primary key(Com_id),
	foreign key(Users_id) references Users (Users_id),
	foreign key(Goods_id) references Goods (Goods_id),
	CONSTRAINT ck_testbool_ischkComment CHECK (computed IN ('Y', 'N'))
);

insert into Comments(Users_id ,Goods_id, Com_body ,Date_of_Com ) values ( 1 , 3 , 'it is very expensive' , '2008-11-11');
insert into Comments(Users_id ,Goods_id, Com_body ,Date_of_Com ) values ( 3 , 9 , 'I love coca' , '2020-12-29');
insert into Comments(Users_id ,Goods_id, Com_body ,Date_of_Com ) values ( 2 , 9 , 'CR7 Say Just water' , '2018-01-03');
insert into Comments(Users_id ,Goods_id, Com_body ,Date_of_Com ) values ( 4 , 1 , 'I want it:)' , '2019-11-11');
insert into Comments(Users_id ,Goods_id, Com_body ,Date_of_Com ) values ( 4 , 3 , 'I want it:)' , '2020-11-11');
*/

/*
select *
from Comments

*/

/* 
	set trigger on the history when a user want to buy some goods 
	update the score of user
*/

--drop trigger updateScore
/*create trigger updateScore on history
after insert
as
begin 
	declare @his_id int
	select top 1 @his_id = His_id from  history order by His_id desc
	print @his_id
	if exists (select 1 from inserted)
	begin 
	update Users
	set Users.Users_cash= Users.Users_cash - Goods.Goods_price
	from history left join Goods on(Goods.Goods_id = history.Goods_id)
	where history.Users_id = Users.Users_id and Goods.Goods_id = history.Goods_id 
	update Users
	set Users.Users_score = Users.Users_score + Goods.Goods_group * Goods.Goods_price 
	from history left join Goods on(Goods.Goods_id = history.Goods_id)
	where history.Users_id = Users.Users_id and Goods.Goods_id = history.Goods_id and history.computed = 'N'
	update history
	set history.computed = 'Y'
	where history.His_id = @his_id
	end
end
*/
/*
insert into history (Users_id , Goods_id , Date_of_buy) values ( 2, 8 , '2020-02-02');

select *
from Users
*/





/* 
	set trigger on the history when a user want to buy some goods 
	update the stock of goods
*/

--drop trigger updateStock
/*create trigger updateStock on history
After insert
as
begin 
	declare @his_id int
	select top 1 @his_id = His_id from  history order by His_id desc
	print @his_id
	if exists (select 1 from inserted)
	begin 
	update Goods 
	set Goods.stock = Goods.stock - 1
	from Goods left join history on(Goods.Goods_id = history.Goods_id)
	where history.His_id = @his_id
	end
end



--insert into history (Users_id , Goods_id , Date_of_buy) values ( 1, 4 , '2020-02-02');
select *
from history

*/





/*
	Score because of the comment
*/

--drop trigger commentScore
/*create trigger commentScore on Comments
after insert
as
begin 
	declare @com_id int
	select top 1 @com_id = Com_id from  Comments order by Com_id desc
	print @com_id
	if exists (select 1 from inserted)
	begin 
	update Users
	set Users.Users_score = Users.Users_score + 30
	from Comments left join Users on(Comments.Users_id = Users.Users_id)
	where Comments.Users_id = Users.Users_id and Comments.computed = 'N'
	update Comments
	set Comments.computed = 'Y'
	where Comments.Com_id = @com_id
	end
end
*/






/*
	the Bill of each User that buy some Goods :)
*/

--drop function bill;
/*create function bill(@Users_identification INT)
returns table
as
return 
		select Goods.Goods_name , Goods.Goods_group , Goods.Goods_price , history.Date_of_buy
		from history , Goods
		where history.Users_id = @Users_identification and history.Goods_id = Goods.Goods_id;

select *
from bill(5) -- sar resid marbot be Atefe zare
*/





/*
	set Procedure before buy some goods
	have enough money
*/

--drop procedure enoughMoney
/*create procedure enoughMoney
@user_id int , @good_id int , @can int output
as
--SET NOCOUNT ON;
if exists (select *
from Users , Goods
where Users.Users_id = @user_id and Goods.Goods_id = @good_id and Users.Users_cash >= (Goods.Goods_price-(Goods.Goods_price*Goods_discount/100)))
begin 
	set @can = 1
end
else if exists (select *
from Users , Goods
where Users.Users_id = @user_id and Goods.Goods_id = @good_id and (Users.Users_cash + Users.Users_score) >= (Goods.Goods_price-(Goods.Goods_price*Goods_discount/100)))
begin 
	set @can = 2
end
else 
begin
	set @can = 0
end
*//*
declare @can int
exec enoughMoney 4 , 2,@can output
print @can
*/









/* 
	Procedure to compute the score :)
*/

--drop view ex;
/*create view ex as
select history.Users_id ,  (Goods.Goods_group * Goods.Goods_price) as score
from history , Goods
where Goods.Goods_id = history.Goods_id and history.computed = 'N'
*/

--drop procedure ComputeScore
/*create procedure ComputeScore
@user_id int , @score int output
as
select @score = Sum(ex.score)
from ex
where Users_id = @user_id 
*/

/*select *
from ex

declare @res int
exec ComputeScore 5 , @res output
print @res
*/





/* 
	Use the Score to buy :)
*/
--drop procedure MakeMoney;
/*create procedure MakeMoney
@user_id int , @cash int output
as
begin
--SET NOCOUNT ON;
	begin
		Update Users
		set Users.Users_cash = Users.Users_cash + Users.Users_score
		where Users.Users_id = @user_id
	end
	begin
		Update Users
		set Users.Users_score = 0
		where Users.Users_id = @user_id
	end
	begin
		select @cash = Users.Users_cash
		from Users
		where Users.Users_id = @user_id
	end
end
*/
/*
declare @out int;
exec MakeMoney @user_id = 1 ,@cash = @out OUTPUT;
select @out AS the_output;

select * 
from Users
*/
/*
	All Users Comments
	of users 
*/

--drop function AllComments;
/*create function AllComments(@Users_identification INT)
returns table
as
return 
		select Comments.Com_body , Comments.Date_of_Com
		from Comments 
		where Comments.Users_id = @Users_identification;
*/

--select *
--from AllComments(4) 




/*
	All Comments of the Goods
	that users enter
*/

--drop function Comments_of_Goods;
/*create function Comments_of_Goods(@Goods_identification INT)
returns table
as
return 
		select Comments.Com_body , Comments.Date_of_Com
		from Comments 
		where Comments.Goods_id = @Goods_identification;

		*/
--select *
--from Comments_of_Goods(9) 











/*
	delete the goods where stock is 0 :||
*/

/*
delete 
from Goods
where (stock = 0)
*/




