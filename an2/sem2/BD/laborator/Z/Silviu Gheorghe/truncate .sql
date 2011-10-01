
select * from temp_tranz;

insert into temp_tranz values(3);

commit;



drop table temp_tranz;


select * from temp_sesiune;

insert into temp_sesiune values(3);

commit;

drop table temp_sesiune;

truncate table temp_sesiune;