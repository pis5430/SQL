
/*join*/

--카티젼 프로덕트(Cartesian Product) --> where절이 없는 경우
select first_name, department_name
from employees, departments;
--결과 :  두 테이블의 행들의 가능한 모든 쌍이 추출됨
-- 올바른 join조건을 where절에 부여해야함

--equl 조인
select first_name as name,
       department_name,
       e.department_id e_id,
       d.department_id d_id
from employees e, departments d -- 두군데 테이블의 정보를 가지고 올 수 있다. 별명적어줌 ,  as는 적어주면 에러남
where e.department_id = d.department_id; -- 앞에 테이블명(별명으로 대체가능)을 적어줌

--모든 직원이름, 부서이름, 업무명 을 출력하세요
--equl join
select  e.first_name , 
        d.department_id, 
        j.job_title,
        e.job_id,
        j.job_id,
        e.department_id,
        d.department_id
from employees e , departments d , jobs j
where e.department_id = d.department_id 
and e.job_id = j.job_id;

--left조인
--left outer join
--왼쪽 테이블의 모든 row를 결과 테이블에 나타냄
select  e.department_id, 
        e.first_name, 
        d.department_name
from employees e left outer join departments d --왼쪽 테이블을 기준으로 조인
on e.department_id = d.department_id;

--left조인 / (+)기준이 아닌 쪽에 추가(null표시까 포함해서 출력) --> 오라클 표현
select  e.department_id, 
        e.first_name, 
        d.department_name
from employees e , departments d
where e.department_id = d.department_id(+);


--right조인
select  e.department_id, 
        e.first_name, 
        d.department_name
from employees e right outer join departments d -- 오른쪽 테이블을 기준으로 조인
on d.department_id = d.department_id;

--right조인 --> 오라클  표현
select  e.department_id, 
        e.first_name, 
        d.department_name
from employees e ,departments d -- 오른쪽 테이블을 기준으로 조인
where d.department_id(+) = d.department_id;

--right 조인 --> left조인 (테이블 위치를 바꿈)
select  e.department_id, 
        e.first_name, 
        d.department_name
from departments d left outer join employees e
on d.department_id = e.department_id;

--right 조인 --> left조인 (오라클 표현)
select  e.department_id, 
        e.first_name, 
        d.department_name
from departments d , employees e
where d.department_id = e.department_id(+);

--full outer join (+표기 불가능 , 두군데 +표시할시 에러남)
select  e.department_id,
        e.first_name,
        d.department_id,
        d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id;

--full outer join (+ 표기 불가)
select  e.department_id,
        e.first_name,
        d.department_id,
        d.department_name
from employees e ,departments d
where e.department_id(+) = d.department_id(+); -- +표시 양쪽 불가 , 사용 x

--테이블 명 alias 설정하면 계속 사용해야 한다.
--정상
select  e.department_id,
        e.first_name,
        d.department_name,
        d.department_id
from employees e, departments d
where e.department_id = d.department_id
order by e.department_id desc;

--오류
select  employees.department_id, --테이블명 alias사용
        e.first_name,
        d.department_name,
        d.department_id
from employees e, departments d
where e.department_id = d.department_id
order by e.department_id desc;


--join 실행순서 체크
select  e.department_id,
        e.first_name,
        d.department_id,
        d.department_name
from employees e ,departments d
where e.department_id = d.department_id
order by e.department_id desc; --oreder by 부분 다시한번 살펴보기


--self 조인 / alias를 사용할 수 밖에 없음
select  emp.employee_id,
        emp.first_name, 
        emp.manager_id,
        man.first_name manager 
from employees emp, employees man -- 같은 테이블이지만 불러올 값이 다르면 별명을 다르게 설정해줘야함
where emp.manager_id = man.employee_id
order by emp.department_id desc;

--잘못된 사용예
select *
from employees e, locations l
where e.salary = l.location_id;

