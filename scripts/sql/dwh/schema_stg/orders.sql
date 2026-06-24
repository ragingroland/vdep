create table if not exists stg.orders (
    xdate date not null,
    order_guid uuid not null,
    customer_guid uuid not null,
    employee_guid uuid not null,
    product_guid uuid not null,
    quantity int not null);
create index if not exists idx_r_sale on stg.orders(xdate, order_guid) using btree;

alter table stg.orders add constraint fk_t_orders_customer_guid foreign key (customer_guid) references stg.customer(customer_guid);
alter table stg.orders add constraint fk_t_orders_employee_guid foreign key (employee_guid) references dm.employee(employee_guid);
alter table stg.orders add constraint fk_t_orders_product_guid foreign key (product_guid) references stg.product(product_guid);
