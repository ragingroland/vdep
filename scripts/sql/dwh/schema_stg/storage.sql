create table if not exists stg.storage (
    xdate date not null,
    storage_guid uuid not null,
    product_guid uuid not null,
    quantity int not null);
create index if not exists idx_t_storage on stg.storage(xdate, storage_guid, product_guid) using btree;
