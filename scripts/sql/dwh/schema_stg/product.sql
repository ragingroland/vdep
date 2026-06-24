create table if not exists stg.product (
    xdate date not null,
    product_guid uuid not null,
    price numeric(18, 2) not null);
create index if not exists idx_t_product on stg.product(xdate, product_guid) using btree;
