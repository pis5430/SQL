/*rownum*/

--급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오
--*일렬번호를 쓰는경우 3단구성
--reownum 이 order by보다 먼저 생겨서 번호가 섞인다.
select  rownum, -- 가상의 일렬번호
        employee_id,
        first_name,
        salary
from employees
order by salary desc;

select  *
from employees;

--정렬하고 rownum 사용

select  rownum, -- 가상의 일렬번호
        o.employee_id,
        o.first_name,
        o.salary
from (select employee_id, --salary로 정렬되어 있는 테이블 사용(이 자체로 o의 이름을가진 테이블)
             first_name, 
             salary
       from employees emp
       order by salary desc) o
where rownum >= 11 --1이 아닐때는 값이 안나옴 , where절 조건이 2부터 값이없음
and rownum <=20;
      
      
--일련번호주고 바로 조건을 판단해서  
--오라클 기준
select  ro.rnum,
        ro.employee_id,
        ro.first_name,
        ro.salary
from (select  rownum rnum, -- 별명을 써줘야함
              o.employee_id,
              o.first_name,
              o.salary
      from (select emp.employee_id, --salary로 정렬되어 있는 테이블 사용(이 자체로 o의 이름을가진 테이블)
                   emp.first_name, 
                   emp.salary
            from employees emp
            order by salary desc) o
        ) ro
where rnum >= 11 --1이 아닐때는 값이 안나옴 , where절 조건이 2부터 값이없음
and rnum <=20; 
--> 정렬이 되어있는 테이플의 갯수의 범위를 지정해야함


select *
from () ro
where rownum >= 1 --1이 아닐때는 값이 안나옴
and rownum <=5;       
       
       
select emp.employee_id,
        emp.first_name,
        emp.salary
from employees emp;

/*예제 07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은? */

--07년에 입사한 직원 테이블 (1)
--1
select hire_date,
        first_name,
        salary
from employees
where hire_date between '07/01/01'
and '07/12/31'
order by salary desc;

--2
select hire_date,
        first_name,
        salary
from employees
where hire_date like '07%'
order by salary desc;

--(1)직원 테이블 에서 3~7등의 이름 급여 입사일은?
select rt.rnum,
       rt.first_name,
       rt.salary,
       rt.hire_date
from (select rownum rnum,
             o.hire_date,
             o.first_name,
             o.salary
      from (select hire_date,
                   first_name,
                   salary
               from employees
              where hire_date like '07%'
             order by salary desc) o -- 정렬이 들어간 테이블은 o로 (or안됨)
      ) rt -- 가상의 일렬번호 테이블은 rt
 where rnum >= 2
 and rnum <= 7;

