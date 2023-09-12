-- Denormalized table and insert statements

-- create table customer
-- (
-- customerId int,
-- CustomerName varchar (100),
-- CustomerBillingAddress varchar(255),
-- CustomerMailingAddress varchar(255),
-- CustomerOrder varchar(50),
-- CustomerOrder2 varchar(50),
-- productTypeId int,
-- productTypeDesc varchar(50),
-- productTypeId2 int,
-- productTypeDesc2 varchar(50),
-- productName varchar(50),
-- productName2 varchar(50)
-- );

-- Insert into customer
-- values
-- (1,
-- 'John Doe',
-- '1234 S Memory Lane. Anytown, UT 84001',
-- '27 W Jones Ave. Anytown, UT 84001',
-- 'Purchased Socket Wrench',
-- 'Purchased Hiking Boots',
-- 1,
-- 'Tools',
-- 2,
-- 'Hiking Gear',
-- 'Socket Wrench',
-- 'Hiking Boots'
-- );

-- Insert into customer
-- values
-- (2,
-- 'Jane Smith',
-- '77 N Fremont Dr. Anytown, UT 84001',
-- '9 E Washington Blvd. Anytown, UT 84001',
-- 'Purchased Computer',
-- 'Purchased shoes',
-- 3,
-- 'Computers',
-- 4,
-- 'Athletic Shoes',
-- 'Apple MacBook Pro 13 in',
-- 'Nike running shoe'
-- );

-- Normalized table and insert statements
create table customer
(
customerId int,
CustomerName varchar (100)
);

create table addressType
(
adddressTypeID int,
addressTypeDesc varchar (50)
);

create table address
(
addressId int,
customerId int,
streetAddressLine varchar(100),
city varchar(50),
state varchar(50),
zipCode int,
addressTypeId int 
);

create table productType
(
productTypeId int,
productTypeDesc varchar(50)
);

create table product
(
productId int,
productName varchar(50),
productTypeId int
);

create table customerOrder
(
orderId int,
customerId int,
productId int,
orderDesc varchar(50)
);

Insert into customer
values
(1, 'John Doe'),
(2, 'Jane Smith');

Insert into addressType
values
(1, 'billing'),
(2, 'mailing');

Insert into address
values
(1, 1, '1234 S Memory Lane.', 'Anytown', 'UT', 84001, 1),
(2, 1, '27 W Jones Ave.', 'Anytown', 'UT', 84001, 2),
(3, 2, '77 N Fremont Dr.', 'Anytown', 'UT', 84001, 1),
(4, 2, '9 E Washington Blvd.', 'Anytown', 'UT', 84001, 2);

Insert into productType
values
(1, 'tools'),
(2, 'hiking gear'),
(3, 'Computers'),
(4, 'Athletic Shoes');

Insert into product
values
(1, 'socket wrench', 1),
(2, 'hiking boots', 2),
(3, 'Apple MacBook Pro 13 in', 3),
(4, 'Nike running shoe', 4);

Insert into customerOrder
values
(1, 1, 1, 'Purchased Socket Wrench'),
(2, 1, 2, 'Purchased Hiking Boots'),
(3, 2, 3, 'Purchased Computer'),
(2, 2, 4, 'Purchased shoes');
