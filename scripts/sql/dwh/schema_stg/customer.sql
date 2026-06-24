create table if not exists stg.customer (
    customer_guid uuid not null,
    customer_name text not null,
    bdate date,
    contact_info text,
    club_card text,
    club_card_lvl integer);
create index if not exists idx_t_customer on stg.customer(xdate, customer_guid) using btree;
