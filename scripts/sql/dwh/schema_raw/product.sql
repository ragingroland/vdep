create table if not exists raw.product (
    xdate date not null,
    product_guid uuid not null,
    product_name text not null,
    article text not null,
    price numeric(18, 2) not null,
    quantity int not null);
create index if not exists idx_r_product on raw.product(xdate, product_guid) using btree;
