--from절 where절 표현방법 , (+)<__오라클
left/right/full outer join ~ on

inner join --> null은제외
 inner join ~ on

select first_name, em.department_id, 
       department_name, de.department_id
from   employees em, departments de
where  em.department_id = de.department_id;

select *
from employees em inner join departments de
on em.department_id = de.department_id;


outer join --> 기준이 되는 족은 포함, 비교되는쪽은 null로 표시
 left outer join ~ on
 right outer join ~ on --> left outer join ~ on
 full outer join ~ on
