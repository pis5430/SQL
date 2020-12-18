/*그룹함수*/

--오류발생 -->이유 공부해둘것
select  avg(salary)
        --first_name --오류발생 (그룹함수와 함께 쓰이지 못함, 하나의 row로 표현불가)
from employees;

--그룹함수 avg() / 평균값을 반환
select  avg(salary)
from employees;

--그룹함수 count(컬럼명) / 총 건 수를 반환
select  count(*) --null값 포함
from employees;

select  count(commission_pct) -- commission_pct 컬럼의 null포함하지 않는다
from employees;

select count(*) -- 조건절 추가
from employees
where salary > 16000;

--그룹함수 , 일반컬럼 못옴
--그룹함수 , 그룹함수 표현가능

--그룹함수 sum() 합계를 반환
select  sum(salary),
        count(*)
from employees;

--그룹함수 - avg() null일때 0으로 변환
--1. null값을 0으로 변환하지 않고 평균을 냈을때
select count(*),
        sum(commission_pct),
        avg(commission_pct)
from employees;
--> 결과값 0.2228571428571428571428571428571428571429

--2. null값을 0으로 변환하고 평균을 냈을때
select count(*),
        sum(commission_pct),
        avg(nvl(commission_pct,0))
from employees;
--> 결과값 0.072897196261682242990654205607476635514

--그룹함수 / max() 최대값 반환, min() 최소값 반환
select max(salary)
from employees;

select min(salary)
from employees;

--정렬이 필요한 경우 많은 연산을 수행해야 한다.
select  max(salary),
        min(salary),
        count(*)
from employees;

/*group by절*/

select  department_id
        -- avg(salary) --오류 , department_id와 같이 하나의 row로 표현불가
from employees;

select  department_id,
        avg(salary)
from employees
group by department_id; -- group by 사용시 위의 문제 해결

--GROUP BY 절 – 자주하는 오류
--정상
select  department_id, 
        count(*),
        sum(salary)
from employees
group by department_id;

--표현안되는 경우
select  department_id, 
        count(*),
        sum(salary)
        --job_id -- group by 사용해도 오류발생
from employees
group by department_id;

--해결
select  department_id, 
        count(*),
        sum(salary),
        job_id -- 컬럼 추가시 group by에도 추가
from employees
group by department_id , job_id -- group by 에 job_id 추가하기
order by department_id asc;

/* 1. 연봉(salary)의 합계가 20000 이상인 부서의 
   2. 부서 번호와 , 인원수, 급여합계를 출력하세요*/
select department_id,
        count(*),
        sum(salary)
from employees
-- whrer salary >=20000 --> 그룹함수는 where 못씀, 오류남
group by department_id;

--having 절
select department_id,
        count(*),
        sum(salary)
from employees
group by department_id
having sum(salary) >= 20000 --having 절에는 그룹함수와 group by에 참여한 컬럼만 사용가능
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

/*직원의 이름, 부서, 팀을 출력하세요
팀은 코드로 결정하며 
부서코드가 10~50 이면 ‘A-TEAM’
          60~100이면 ‘B-TEAM’  
          110~150이면 ‘C-TEAM’ 
나머지는 ‘팀없음’ 으로 출력하세요.*/

select  first_name,
        department_id,
        case when department_id >= 10 and department_id <= 50 then 'A-TEAM'
             when department_id >= 60 and department_id <= 100 then 'B-TEAM'
             when department_id >= 110 and department_id <= 150 then 'C-TEAM'
             else '팀없음'
        end as team
from employees;



