create database db_vdep;
create database airflow;

create user lydemere with password 'easy12345';
create user airflow with password 'easy12345';
grant all on database db_vdep to lydemere;
grant all on database airflow to airflow;
alter database airflow owner to airflow;
alter database db_vdep owner to lydemere;

\c airflow;

grant all on schema public to airflow;
alter schema public owner to airflow;

\c db_vdep;

create schema if not exists s_vdep;

grant all on schema s_vdep to lydemere;

set search_path to s_vdep, public;

create table if not exists s_vdep.t_usertable (
    id bigint generated always as identity (start with 1 increment by 1 no maxvalue) primary key,
    user_uuid uuid not null,
    insertion_date timestamp not null,
    entered_user varchar not null);
create index if not exists idx_t_usertable on s_vdep.t_usertable(user_uuid);

alter table s_vdep.t_usertable owner to lydemere;

grant all on all tables in schema s_vdep to lydemere;
alter default privileges in schema s_vdep grant all on tables to lydemere;

insert into s_vdep.t_usertable (user_uuid, insertion_date, entered_user) select gen_random_uuid(), clock_timestamp(), current_user;
analyze s_vdep.t_usertable;
