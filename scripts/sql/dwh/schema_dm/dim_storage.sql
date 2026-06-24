create table if not exists dm.dim_storage (
    storage_guid uuid not null,
    storage_name text not null)
create index if not exists idx_t_storage on dm.dim_storage(xdate, storage_guid) using btree;
