insert into temp_tranz_pnu values(3);
commit;
select * from temp_tranz_pnu;
drop table temp_tranz_pnu;
insert into temp_sesiune values(3);
commit;
select * from temp_sesiune;
drop table temp_sesiune;
truncate table temp_sesiune;