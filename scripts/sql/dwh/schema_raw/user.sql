create table if not exists raw.user (
    xdate date not null,
    user_guid uuid not null,
    first_name text not null,
    last_name text not null,
    middle_name text not null,
    bdate date,
    phone_number text,
    email text
    club_card uuid);
create index if not exists idx_r_user on raw.user(xdate, user_guid) using btree;
