create schema if not exists raw;
create schema if not exists stg;
create schema if not exists dm;

create table if not exists raw.customer (
    xdate date not null,
    customer_guid uuid not null,
    customer_1name text not null,
    customer_2name text not null,
    customer_pname text not null,
    bdate date,
    phone_number text,
    phone_number_2 text,
    email text,
    id generated always as identity (start with 1 increment by 1 no maxvalue) primary key);
create index if not exists idx_r_customer on raw.customer(xdate, customer_guid) using btree;

create table if not exists stg.customer (
    customer_guid uuid not null,
    customer_name text not null,
    bdate date,
    contact_info text,
    club_card text,
    club_card_lvl integer,
    id generated always as identity (start with 1 increment by 1 no maxvalue) primary key);
create index if not exists idx_t_customer on stg.customer(xdate, customer_guid) using btree;

create table if not exists raw.product (
    xdate date not null,
    product_guid uuid not null,
    product_name text not null,
    article text not null,
    price numeric(18, 2) not null,
    quantity int not null,
    id generated always as identity (start with 1 increment by 1 no maxvalue) primary key);
create index if not exists idx_r_product on raw.product(xdate, product_guid) using btree;

create table if not exists dm.product (
    product_guid uuid not null,
    product_name text not null,
    article text not null,
    id generated always as identity (start with 1 increment by 1 no maxvalue) primary key);
create index if not exists idx_t_product on stg.product(xdate, product_guid) using btree;

create table if not exists stg.product (
    xdate date not null,
    product_guid uuid not null,
    price numeric(18, 2) not null,
    id generated always as identity (start with 1 increment by 1 no maxvalue) primary key);
create index if not exists idx_t_product on stg.product(xdate, product_guid) using btree;

create table if not exists dm.storage (
    storage_guid uuid not null,
    storage_name text not null,
    id generated always as identity (start with 1 increment by 1 no maxvalue) primary key)
create index if not exists idx_t_storage on stg.storage(xdate, storage_guid) using btree;

create table if not exists stg.storage (
    xdate date not null,
    storage_guid uuid not null,
    product_guid uuid not null,
    quantity int not null,
    id generated always as identity (start with 1 increment by 1 no maxvalue) primary key)
create index if not exists idx_t_storage on stg.storage(xdate, storage_guid, product_guid) using btree;

create table if not exists stg.orders (
    xdate date not null,
    order_guid uuid not null,
    customer_guid uuid not null,
    employee_guid uuid not null,
    product_guid uuid not null,
    quantity int not null,
    id generated always as identity (start with 1 increment by 1 no maxvalue) primary key);
create index if not exists idx_r_sale on raw.sale(xdate, order_guid) using btree;

alter table stg.orders add constraint fk_t_orders_customer_guid foreign key (customer_guid) references stg.customer(customer_guid);
alter table stg.orders add constraint fk_t_orders_employee_guid foreign key (employee_guid) references dm.employee(employee_guid);
alter table stg.orders add constraint fk_t_orders_product_guid foreign key (product_guid) references stg.product(product_guid);

create table if not exists dm.employee (
    employee_guid uuid not null,
    employee_name text not null,
    id generated always as identity (start with 1 increment by 1 no maxvalue) primary key);
create index if not exists idx_r_employee on raw.employee(xdate, employee_guid) using btree;
