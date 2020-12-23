--혼합 SQL 문제입니다.
/*practice05*/

/*
문제1.
담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의 
이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
(45건)
*/

--담당 매니저가 배정되어잇고 , 커미션비율이 없으며, 월급이 3000 초과인 직원
select  first_name 이름,
        manager_id 매니저아이디,
        commission_pct 커미션비율,
        salary 월급
from employees
where manager_id is not null
and commission_pct is null
and salary > 3000
order by salary asc;


/*
문제2. 
각 부서별로 최고의 급여를 받는 사원의 
직원번호(employee_id), 이름(first_name), 급여(salary), 입사일(hire_date), 
전화번호(phone_number), 부서번호(department_id) 를 조회하세요 
-조건절비교 방법으로 작성하세요 (where)
-급여의 내림차순으로 정렬하세요 (order by salary desc)
-입사일은 2001-01-13 토요일 형식으로 출력합니다.
-전화번호는 515-123-4567 형식으로 출력합니다.
(11건)
*/
--각 부서별로 최고의 급여를 받는 사원
select department_id,
        max(salary)
from employees
group by department_id,first_name;

--직원번호(employee_id), 이름(first_name), 급여(salary), 입사일(hire_date), 
--전화번호(phone_number), 부서번호(department_id) 를 조회
select  employee_id 직원번호,
        first_name 이름,
        salary 급여,
        to_char(hire_date, 'YYYY-MM-DD DAY') 입사일,
        replace(phone_number,'.','-') 전화번호,
        department_id 부서번호
from employees
where (department_id,salary) in (select department_id,
                                        max(salary)
                                 from employees
                                 group by department_id)
order by salary desc;                                 

--조건절비교 방법으로 작성하세요 (where)
--급여의 내림차순으로 정렬하세요 (order by salary desc)
--입사일은 2001-01-13 토요일 형식으로 출력합니다. to_char(hire_date, 'YYYY-MM-DD DAY')
--전화번호는 515-123-4567 형식으로 출력합니다. replace(phone_number,'.','-')


/*
문제3
매니저별로 평균급여 최소급여 최대급여를 알아보려고 한다.
-통계대상(직원)은 2005년 이후의 입사자 입니다. (2005년 1월 1일 이후)
-매니저별 평균급여가 5000이상만 출력합니다.
-매니저별 평균급여의 내림차순으로 출력합니다.
-매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
-출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 
매니저별최소급여, 매니저별최대급여 입니다.
(9건)
*/
--(1)
-- 매니저별로 평균급여 최소급여 최대급여/ 매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
-- 통계대상(직원)은 2005년 이후의 입사자 입니다. 
-- 평균급여 5000이상
select  manager_id 매니저별,
        round(avg(salary), 1) 평균급여,
        min(salary) 최소급여,
        max(salary) 최대급여
from employees
where hire_date >= '05/01/01'
having avg(salary) >= 5000
group by manager_id
order by avg(salary) desc;

--(2)
-- 매니저 이름을 구하는 방법 (pk = fk) (ed.employee_id = de.manager_id 가 일치하는 관리자의 이름)
--(1)번 테이블에 매니저 이름만 추가하면 된다. (1)번을 하나의 테이블로 만들어서 self join

select masal.manager_id,
       em.first_name,
       masal.avsal,
       masal.minsal,
       masal.maxsal 
from(select  manager_id, -- 별명넣으니까 where절에서 오류남
             round(avg(salary), 1) avsal,
             min(salary) minsal,
             max(salary) maxsal 
     from employees
     where hire_date >= '05/01/01'
     having avg(salary) >= 5000
     group by manager_id
     order by avg(salary) desc) masal , employees em
where masal.manager_id = em.employee_id; --매니저 이름을 구하기 위한 비교 테이블
     

/*
문제4.
각 사원(employee)에 대해서 
사번(employee_id), 이름(first_name), 
부서명(department_name), 
매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명)
*/

--(1)각사원의 사번, 이름, 부서명 조회 (107)
select  em.employee_id,
        em.first_name,
        de.department_name
from employees em , departments de
where em.employee_id = de.manager_id(+); 

--(2)(1)번에 매니저의 이름 추가 --1
select  em.employee_id,
        em.first_name,
        de.department_name,
        mn.first_name
from employees em , departments de , employees mn
where em.employee_id = de.manager_id(+)
and em.manager_id = mn.employee_id; --self join(강의다시한번 들어보기)


/*
문제5.
2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의 
사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
*/

--(1)2005년 이후 입사한 직원들의 사번, 이름, 부서명, 급여, 입사일 
select  em.employee_id 사번,
        em.first_name 이름,
        de.department_name 부서명,
        em.hire_date 입사일
from employees em , departments de
where em.hire_date >= '05/01/01'
order by em.hire_date asc;

--(2) (1)테이블을 가지고 정렬 , (2)테이블 만듬
select rownum rn,
       o.employee_id,
       o.first_name,
       o.department_name,
       o.hire_date
from (select  em.employee_id,
              em.first_name,
              de.department_name,
              em.hire_date
      from employees em , departments de
      where em.hire_date >= '05/01/01'
      and em.department_id = de.department_id
      order by em.hire_date asc) o;
      
      
--결과 : 2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의 
--사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
--(2)번을 입사일이 11번째에서 20번째 직원 기준으로 출력
select rt.rown,
       rt.employee_id 사번,
       rt.first_name 이름,
       rt.department_name 부서명,
       rt.hire_date 입사일
from (select  rownum rown,
              o.employee_id,
              o.first_name,
              o.department_name,
              o.hire_date
      from (select  em.employee_id,
                    em.first_name,
                    de.department_name,
                    em.hire_date
            from employees em , departments de
            where em.hire_date >= '05/01/01'
            and em.department_id = de.department_id
            order by em.hire_date asc) o
            )rt
where rt.rown >= 11
and rt.rown <= 20;

/*
문제6.
가장 늦게 입사한 직원의 이름(first_name last_name)과 
연봉(salary)과 근무하는 부서 이름(department_name)은?
*/

-- 가장 늦은 입사일 확인 max(hire_date) -->08/04/21 Sundita , Amit 두명
select hire_date,
       first_name
from employees
order by hire_date desc;

-- 가장 늦은 입사일 조건
select max(hire_date)
from employees

--결과
select  em.first_name || ' ' || em.last_name,
        em.salary,
        de.department_name
from employees em , departments de
where em.department_id = de.department_id
and hire_date = (select max(hire_date)
                   from employees);
                   
/*
문제7.
평균연봉(salary)이 가장 높은 부서 직원들의 
직원번호(employee_id), 이름(firt_name), 
성(last_name)과  업무(job_title), 연봉(salary)을 조회하시오.
*/

--부서별 평균 : 평균연봉이 제일 높은 부서는? --> department_id =90 -- 19333.3333
select department_id,
       avg(salary)
from employees
group by department_id;

-- 평균연봉이 가장 높은 부서 -- max(avg(salary))
select max(avg(salary))
from employees
group by department_id;

--직원번호(employee_id), 이름(firt_name), 성(last_name)과   연봉(salary)을 조회 --> employees
--업무(job_title),을 조회 -->jobs
select em.employee_id 직원번호,
       em.first_name 이름,
       em.last_name 성,
       jo.job_title 업무,
       em.salary 연봉
from employees em , jobs jo
where em.job_id = jo.job_id;

--결과 
--> 평균연봉(salary)이 가장 높은 부서 직원들의 (조건/테이블)
--> 직원번호(employee_id), 이름(firt_name), 성(last_name)과  업무(job_title), 연봉(salary)을 조회 

--1 where (and부분부터 다시해보기)
select em.employee_id 직원번호,
       em.first_name 이름,
       em.last_name 성,
       jo.job_title 업무,
       em.salary 연봉
from employees em , jobs jo
where em.job_id = jo.job_id
and avg(salary) = (select max(avg(salary))
                      from employees
                      group by department_id);


/*
문제8.
평균 급여(salary)가 가장 높은 부서는? 
*/


/*
문제9.
평균 급여(salary)가 가장 높은 지역은? 
*/

/*
문제10.
평균 급여(salary)가 가장 높은 업무는? 
*/
