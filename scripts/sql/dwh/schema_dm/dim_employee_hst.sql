create table if not exists dm.dim_employee_hst (
    employee_guid uuid not null,
    employee_name text not null);
create index if not exists idx_r_employee on dm.dim_employee_hst(xdate, employee_guid) using btree;
