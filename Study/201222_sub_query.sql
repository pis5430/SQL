/*seb Query 서브 쿼리*/

--‘Den’ 보다 급여를 많은 사람의 이름과 급여는?
-- -->10000 보다 급여를 많은 사람의 이름과 급여는?
select  employee_id,
        first_name,
        salary
from employees
where salary > 11000;


--‘Den’ 보다 급여를 많은 사람의 이름과 급여는?
--1. 'Den' 보다 급여
select  employee_id,
        first_name,
        salary
from employees
where first_name = 'Den'; --> 11000

--2. 'Den' 보다 급여 높은사람
select  employee_id,
        first_name,
        salary
from employees
where salary > 11000;

--3. 위 1,2번을 1개의 질문으로 해결
select  employee_id,
        first_name,
        salary
from employees
where salary > (select salary
                from employees
                where first_name = 'Den'); --서브쿼리부분 (질문안의 질문)        

--예제)                
--급여를 가장 적게 받는 사람의 이름, 급여, 사원번호는? 
--1.가장 적은 급여 액수 -->2100
--2.2100을 받는 직원의 이름 ,급여, 사원번호는?

--1.가장 적은 급여 액수 -->2100
select min(salary)
from employees;

--2.2100을 받는 직원의 이름 ,급여, 사원번호는?
select employee_id,
        first_name,
        salary
from employees
where salary > (select min(salary)
                from employees);
                
                
--평균 급여보다 적게 받는 사람의 이름, 급여를 출력하세요?
--1. 평균급여 구하기
--2. 평균 급여보다 적게 잗는 사람의 이름 급여 출력

--1. 평균급여 구하기
select avg(salary) -->6461.8317
from employees;

--2. 평균 급여보다 적게 잗는 사람의 이름 급여 출력
select  first_name,
        salary
from employees
where salary < (select avg(salary)
                from employees);

--예제
--부서번호가 110인 직원의 급여와 같은 모든 직원의 
--사번, 이름, 급여를 출력하세요
--1.부서번호 110인 직원의 이름, 급여,...리스트

select  firet_name,
        salary,
        department_id
from employees
where department_id = 110;

--2.전체직원 중 급여가 12008, 8300인 직원
select  employee_id,
        first_name,
        salary
from employees
where salary = 12008
or salary = 8300; 


--단일행/다중행 (다중행에는 in을 자주씀)
select  employee_id,
        first_name,
        salary
from employees
where salary in(select salary
                from employees
                where department_id = 110);
                
--예제
--각 부서별로 최고급여를 받는 사원을 출력하세요

--1. 부서별 최고 급여 얼마인지? 누구인지는 못구함(현재)
select  --employee_id --누구는 못구함
        department_id,
        max(salary)
from employees
group by department_id;

--2. 전체사원테이블에서 부서번호와 급여가 같은 사람을 찾는다
-- 부서별 최고급여 리스트를 기준으로 
select first_name,
        employee_id,
        salary,
        department_id
from employees
where department_id = 100
and salary = 12008;

--최종 결과
select first_name,
        employee_id,
        salary,
        department_id
from employees
where (department_id ,salary) in(select department_id,
                                        max(salary)
                                from employees
                                group by department_id)
order by salary desc;


--예제
--부서번호가 110인 직원의 급여 보다 큰 모든 직원의 
--사번, 이름, 급여를 출력하세요.(or연산--> 8300보다 큰)

--부서번호 100인 직원의 급여 리스트
select salary
from employees
where department_id = 110; --12008,8300

select *
from employees
where salary > 12008;

select *
from employees
where salary > 8300;    

-- (부호)any 문법 (or) -->중복값은 걸러줌
select employee_id,
        first_name,
        salary
from employees
where salary > any(select salary
                    from employees
                    where department_id = 110); 
                    
-- (부호)all 문법 
select employee_id,
        first_name,
        salary
from employees
where salary > all(select salary
                    from employees
                    where department_id = 110);   
                    
--sub Queary 로 테이블만들기 --> join으로 사용                    
--각 부서별로 최고급여를 받는 사원을 출력하세요
-- 1.각 부서별로 최고 급여 테이블(select구문 자체를 테이블로 사용)
select  department_id,
        max(salary)
from employees
group by department_id;
   
   
--2. 직원테이블 (1)테이블을 join한다.
select  e.employee_id,
        e.first_name,
        e.salary eSalary,
        e.department_id ed_id
from employees e , (select  department_id,
                             max(salary) as salary -- 별명을 지어줘야함 , as 생략가능
                     from employees
                     group by department_id) s
where e.department_id = s.department_id
and e.salary = s.salary;

                    