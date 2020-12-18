/*그룹함수*/

--오류발생 -->이유 공부해둘것
select  avg(salary)
        --first_name --오류발생 (그룹함수와 함께 쓰이지 못함, 하나의 row로 표현불가)
from employees;

--그룹함수 avg()
select  avg(salary)
from employees;

--그룹함수 count()
select  count(*) --null값 포함
from employees;

select  count(commission_pct)--commission_pct 컬럼의 null포함하지 않는다
from employees;

select count(*) -- 조건절 추가
from employees
where salary > 16000;

--그룹함수 , 일반컬럼 못옴
--그룹함수 , 그룹함수 표현가능
--그룹함수 sum()
select sum(salary) , count(*)
from employees;

--그룹함수 - avg() null일때 0으로 변환
select count(*),
        sum(salary),
        avg(salary)
from employees;

select count(*),
        sum(salary),
        avg(nvl(salary,0))
from employees;

--그룹함수 -max() min()
select max(salary)
from employees;

select min(salary)
from employees;

--정렬이 필요한 경우 많은 연산을 수행해야 한다.
select max(salary),
        min(salary),
        count(*)
from employees;

/*group by절*/

select  department_id,
        avg(salary) --오류
from employees;

select  department_id,
        avg(salary)
from employees
group by department_id;

--GROUP BY 절 – 자주하는 오류
select  department_id, 
        count(*),
        sum(salary)
from employees
group by department_id;

select  department_id, 
        count(*)
        --job_id --오류발생
from employees
group by department_id;

select  department_id, 
        count(*),
        job_id
from employees
group by department_id , job_id
order by department_id asc;

/* 1. 연봉(salary)의 합계가 20000 이상인 부서의 
   2. 부서 번호와 , 인원수, 급여합계를 출력하세요*/
select department_id,
        count(*),
        sum(salary)
from employees
-- whrer salary >=20000 --> 그룹함수는 where 못씀, 오류남
group by department_id;

--having절
select department_id,
        count(*),
        sum(salary)
from employees
group by department_id
having sum(salary) >= 20000;

select department_id,
        count(*),
        sum(salary)
from employees
group by department_id
having sum(salary) >= 20000
and departmer_id = 100;

/*CASE ~ END 문*/
select employee_id,
        salary,
        job_id,
        case when job_id = 'AC_ACCOUNT' then salary*0.1
             when job_id = 'SF_REP' then salary*0.2
             when job_id = 'ST_CLERK' then salary*0.3
             else salary*0
        end bonus
from employees;


select employee_id,
        salary,
        job_id,
        decode(job_id, 'AC_ACCOUNT', salary*0.1,
                       'SA_REP', salary*0.2,
                       'ST_CLRPK', salary*0.3,
                                    salary*0
        ) as bonus
from employees;