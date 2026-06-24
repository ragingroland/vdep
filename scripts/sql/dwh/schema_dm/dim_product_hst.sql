create table if not exists dm.dim_product_hst (
    product_guid uuid not null,
    product_name text not null,
    article text not null);
create index if not exists idx_t_product on dm.dim_product_hst(xdate, product_guid) using btree;
