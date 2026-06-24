create table if not exists raw.customer (
    xdate date not null,
    customer_guid uuid not null,
    first_name text not null,
    last_name text not null,
    middle_name text not null,
    bdate date,
    phone_number text,
    email text);
create index if not exists idx_r_customer on raw.customer(xdate, customer_guid) using btree;
