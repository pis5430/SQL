--서브쿼리(SUBQUERY) SQL 문제입니다.
/*practice04*/

/*
문제1.
평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요.
(56건)
*/
--평균급여
select avg(salary)
from employees;

--평균급여보다 적은 급여를 받는 직원의 급여()
select salary
from employees
where salary < (select avg(salary)
                from employees);

--결과 : 평균 급여보다 적은 급여을 받는 직원은 몇명?
select count(salary)|| '명' as count 
from employees
where salary in(select salary
                from employees
                where salary < (select avg(salary)
                               from employees));


/*
문제2. 
평균급여 이상, 최대급여 이하의 월급을 받는 
사원의 직원번호(employee_id), 이름(first_name), 급여(salary), 
평균급여, 최대급여를 급여의 오름차순으로 정렬하여 출력하세요 
(51건)
*/
--1 평균급여 이상, 최대급여 이하
--평균급여 --6461.8317... (평균급여 이상 52명)
select avg(salary)
from employees;
--최대급여 -- 24000 (최대급여 1명)
select max(salary)
from employees;

--확인
select *
from employees;

--2 사원의 직원번호(employee_id), 이름(first_name), 급여(salary), 
--평균급여, 최대급여를 급여의 오름차순으로 정렬하여 출력
--1
select  employee_id 직원번호,
        first_name 이름,
        salary 급여,
        avg(salary) as 평균급여,
        max(salary) as 최대급여
from employees 
where salary > all (select avg(salary)
                    from employees)
group by employee_id,first_name,salary 
order by salary asc;

--2 (평균급여, 최대급여를 전체평균, 최대급여로 나타낼수 있는지)
select  em.employee_id 직원번호,
        em.first_name 이름,
        em.salary 급여,
        round(av.average,3) as 평균급여,
        ma.maximum as 최대급여
from employees em , (select avg(salary) average
                    from employees) av,
                    (select max(salary) maximum
                    from employees) ma
where em.salary > all (select avg(salary)
                    from employees)
order by salary asc;

/*
문제3.
직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 
있는 곳의 주소를 알아보려고 한다.  -->스티븐킹의 주소가 아니기 때문에 조금더 간단해도됨
도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 
도시명(city), 주(state_province), 나라아이디(country_id) 를 출력하세요
(1건)
*/
--1 Steven(first_name) king(last_name) 직원 정보
select  department_id,
        employee_id
from employees
where first_name = 'Steven'
and last_name = 'King';

--2 Steven(first_name) king(last_name)이 소속된 부서(departments)명 --> 비교값인 도시아이디로 변경해서 적용
select department_id
from departments
where department_id in (select  department_id
                        from employees
                        where first_name = 'Steven'
                        and last_name = 'King') ;

--3 도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 
--도시명(city), 주(state_province), 나라아이디(country_id) 를 출력
--방법1
select location_id 도시아이디,
        street_address 거리명,
        postal_code 우편번호,
        city 도시명,
        state_province 주,
        country_id 나라아이디
from locations
where location_id = (select location_id
                    from departments
                    where department_id in (select  department_id
                                            from employees
                                            where first_name = 'Steven'
                                            and last_name = 'King')) ;
                                            
--방법2
select  de.location_id 도시아이디,
        lo.street_address 거리명,
        lo.postal_code 우편번호,
        lo.city 도시명,
        lo.state_province 주,
        lo.country_id 나라아이디
from departments de , locations lo
where de.location_id = lo.location_id
and de.department_id =(select  department_id
                        from employees
                        where first_name = 'Steven'
                        and last_name = 'King');


/*
문제4.
job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의 사번,이름,급여를 급여의 
내림차순으로 출력하세요  -ANY연산자 사용
(74건)
*/

--job_id 가 'ST_MAN' 인 직원의 급여 (5800,6500,7900,8200,8000)
select salary
from employees
where job_id = 'ST_MAN';

--job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의 사번,이름,급여를 급여의 내림차순으로 출력하세요
select employee_id 사번,
        first_name 이름,
        salary 급여
from employees
where salary < any(select salary
                    from employees
                    where job_id = 'ST_MAN')
order by salary desc;

/*
문제5. 
각 부서별로 최고의 급여를 받는 사원의 
직원번호(employee_id), 이름(first_name)과 급여(salary) 부서번호(department_id)를 조회하세요 
단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 
조건절비교, 테이블조인 2가지 방법으로 작성하세요
(11건)
*/
--부서별 최고급여
select  department_id,
        max(salary)
from employees
group by department_id;

--직원번호(employee_id), 이름(first_name)과 급여(salary) 부서번호(department_id)를 조회하세요 
select employee_id 직원번호,
        first_name 이름,
        salary 급여,
        department_id 부서번호
from employees;

--조건절비교
select employee_id 직원번호,
        first_name 이름,
        salary 급여,
        department_id 부서번호
from employees
where (department_id , salary) in (select  department_id,
                                            max(salary)
                                    from employees
                                    group by department_id);

--테이블조인 (조건을 비교할 테이블을 따로 하나 만듬 )
select  em.employee_id 직원번호,
        em.first_name 이름,
        em.salary 급여,
        em.department_id 부서번호
from employees em , (select  department_id,
                             max(salary) maxsala                          
                      from employees
                      group by department_id) em_s
where em.department_id = em_s.department_id
and em.salary = em_s.maxsala;


/*
문제6.
각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다. 
연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오 
(19건)
*/
-- 각 업무(job) 별로 연봉(salary)의 총합 -- 연봉총합이 가장 높은 업무 (내림차순)
select job_id,
        sum(salary)
from employees
group by job_id
order by sum(salary) desc;

--연봉총합이 가장 높은 업무부터 (내림차순) 업무명(job_title)과 연봉 총합을 조회
select  jo.job_title 업무명,
        su.sumsala 연봉총합
from jobs jo , (select job_id,
                        sum(salary) sumsala
                from employees
                group by job_id) su
where jo.job_id = su.job_id;

/*
문제7.
자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 직원번호(employee_id), 
이름(first_name)과 급여(salary)을 조회하세요 
(38건)
*/

--부서평균연봉
select department_id,
        avg(salary)
from employees
group by  department_id;

--자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 직원번호(employee_id), 
--이름(first_name)과 급여(salary)을 조회

select em.employee_id 직원번호,
        em.first_name 이름,
        em.salary 급여
from employees em , (select department_id,
                            avg(salary) avsala
                    from employees
                    group by department_id) deav
where em.salary > deav.avsala
and em.department_id = deav.department_id;


/*
문제8.
직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 입사일 순서로 출력하세요
*/

--(1) 직원 입사일 순서대로 정렬된 테이블 -- o
select employee_id,
       first_name,
       salary,
       hire_date
from employees
order by hire_date asc;

--(2)(1)테이블에 가상의 일렬번호 부여된 테이블  -- rt
select rownum rowname,
       o.employee_id,
       o.first_name,
       o.salary,
       o.hire_date
from (select employee_id,
             first_name,
             salary,
             hire_date
      from employees
      order by hire_date asc) o;

--(3) 직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 입사일 순서로 출력하세요
select rt.rowname,
       rt.employee_id,
       rt.first_name,
       rt.salary,
       rt.hire_date
from (select rownum rowname,
             o.employee_id,
             o.first_name,
             o.salary,
             o.hire_date
      from (select employee_id,
                   first_name,
                   salary,
                   hire_date
            from employees
            order by hire_date asc) o
       )rt
where rt.rowname >= 11
and rt.rowname <= 15;




/**/