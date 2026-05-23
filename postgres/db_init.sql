create database vdep_lh;
create user lydemere;
grant all on vdep_lh to lydemere;
\c vdep_lh;
create schema vdep;
set search_path to vdep, public;
create table vdep.t_table (id int);
