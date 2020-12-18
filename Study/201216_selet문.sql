--(단일주석)자바코드에 명령어로 들어감
/*(여러줄 주석)

*/

select * from employees; 
--원하는 컬럼 조회하기
--employee_id , first_name , last_name

select employee_id, 
       first_name, 
       last_name
from employees;
--employees 에서 employee_id, first_name , last_name 만 불러옴
--select * from 테이블명을 먼저 적어서 테이블 명이 맞는지 확인하고 컬럼 입력(오타발생최소)
--절마다 끊어쓰기, 들여쓰기 버릇화하기

--사원의 이름(fisrt_name)과 전화번호 입사일 연봉을 출력하세요
select first_name, 
        phone_number, 
        hire_date, 
        salary
from employees;

--사원의 이름(first_name)과 성(last_name) 급여, 전화번호, 이메일, 입사일을 출력하세요
select first_name, 
        last_name, 
        salary, 
        phone_number,
        email,
        hire_date
from employees;

/*출력할 대 컬럼에 별명 사용하기*/
select employee_id as empNo,
        -- as 뒤에 별명 정해주기
        first_name "f-name",
        -- as 생략가능
        salary "연 봉"
from employees;

--사원의 이름(fisrt_name)과 전화번호 입사일 급여 로 표시되도록 출력하세요
select first_name "이 름",
        phone_number "전화번호", 
        hire_date "입사일",
        salary "급 여"
 from employees;
 
 --사원의 사원번호 이름(first_name) 성(last_name) 급여 전화번호 이메일 입사일로 표시되도록 출력하세요
select employee_id 사원번호,
        first_name 이름, 
        last_name 성,
        salary 급여,
        phone_number 전화번호,
        email 이메일,
        hire_date 입사일
 from employees;
 
 /*연결 연산자 (comcatenation)로 컬럼들 붙이기*/
select first_name || last_name
from employees;

select first_name || ' ' || last_name as name
-- ' ' 공백 문자열이 왜 들어가는지 다시한번 확인해보기(그냥 보기힘들어서)
from employees;

select first_name||' hire date is ' || hire_date
from employees;

--산술 연산자 사용하기
select fist_name, salary
from employees;

select  first_name,
        salary,
        salary*12
        from employees;
        
select  first_name,
        salary,
        salary*12 연봉,
        (salary+300)*12
from employees;

select job_id
-- job_id 필드가 숫자값이 산술연산자랑 사용하면 오류
from employees;

select  first_name ||' - '|| last_name 성명,
        salary 급여,
        salary*12 연봉,
        salary*12+5000 연봉2,
        phone_number 전화번호
from employees;

select employee_id
from employees;

/*selet 문 > where절 */
select first_name
from employees
where department_id = 10;

/*급여가 15000 이상인 사원들의 이름과 급여를 출력하세요*/
select first_name ,
        salary 급여
from employees
where salary >= 15000;

/*07/01/01 일 이후에 입사한 사원들의 이름과 입사일을 출력하세요*/
select first_name ,
        hire_date
from employees
where  hire_date >= '07/01/01';

/*이름이 Lex인 직원의 연봉을 출력하세요*/
select salary
from employees
where  first_name = 'Lex';

--조건이 2개이상 일대 한꺼번에 조회하기
select  first_name,
        salary
from employees
where salary>=14000
and salary<=17000;
--and 둘다만족 , or 둘중에 하나 만족

/*연봉이 14000 이하이거나 17000 이상인 사원의 이름과 연봉을 출력하세요*/
select  first_name,
        salary
from employees
where salary<=14000
or salary>=17000;

/*입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일을 출력하세요*/
select  first_name,
        hire_date
from employees
where hire_date>='04/01/01'
and hire_date<='05/12/31';

select  first_name,
        hire_date
from employees
where hire_date between '04/01/01' and '05/12/31';

/*where절 in 연산자*/
select first_name, last_name, salary
from employees
where first_name in('Neena', 'Lex', 'John');

-- in 같은 표현
select first_name, last_name, salary
from employees
where first_name = 'Neena' 
or first_name ='Lex'
or first_name ='John';

/*연봉이 2100, 3100, 4100, 5100 인 사원의 이름과 연봉을 구하시오*/
select  first_name, 
        salary
from employees
where salary in(2100,3100,4100,5100);

/*where절 like연산자*/
select first_name,
        last_name,
        salary
from employees
where first_name like 'L%';
-- first_name에서 앞글자가 L인 필드 (문자열은 대소문자 구분함)

select first_name,
        last_name,
        salary
from employees
where first_name like '%a%';
-- first_name에서 a값을 포함한 필드(위치상관없음)

select first_name,
        last_name,
        salary
from employees
where first_name like '_a%';
-- _한줄이 한글자, 글자수를 제한할때 사용, 몇번째에 특정 문자열을 검색할때 사용

--이름에 am 을 포함한 사원의 이름과 연봉을 출력하세요
select  first_name,
        salary
from employees
where first_name like '%am%';

--이름의 두번째 글자가 a 인 사원의 이름과 연봉을 출력하세요
select  first_name,
        salary
from employees
where first_name like '_a%';

--이름의 네번째 글자가 a 인 사원의 이름을 출력하세요
select  first_name
from employees
where first_name like '____a';


--이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요
select  first_name,
        salary
from employees
where first_name like '__a_';

/*where절 null*/
--직원테이블에서 급여가 13000에서 15000사이
--직원의 이름, 급여, 커미션% , 급여*커미션 출력하세요
select  first_name, 
        salary, 
        commission_pct, 
        salary*commission_pct
from employees
where salary between 13000 and 15000;

--커미션 비율이 없는 직원을 출력 (커미션에 null값으로 들어가 있는 직원들 , 비어있는 필드)
-- 비어있는 필드는 0으로 표시되지 않고 (null)으로 표시됨 --> 오류안남
select  *
from employees
where commission_pct is null;

select  *
from employees
where commission_pct is not null;

--커미션비율이 있는 사원의 이름과 연봉 커미션비율을 출력하세요
select  first_name, 
        salary,
        commission_pct
from employees
where commission_pct is not null;

--담당매니저가 없고 커미션비율이 없는 직원의 이름을 출력하세요
select  first_name
from employees
where manager_id is null
and commission_pct is null;

--테이블에는 하나의 행만 찾아올수 있는 pk값이 필요함 (null값이 들어가 있으면 안됨)
select  email, 
        employee_id
from employees
where employee_id = 110;

/*order절*/
/*
select문
    select절
    from절
    where절
    order by절 -->정렬
*/

-- 큰것부터 정렬 desc 내림차순
select first_name,
        salary
from employees
where salary >=9000
order by salary desc; -- 반대 차순 asc 작은거부터, 오름차순

select *
from employees
where salary >=9000
order by salary asc; -- 반대 차순 asc 작은거부터, 오름차순


--부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요
select department_id,
        salary,
        first_name
from employees
order by department_id asc;

--급여가 1000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요
select first_name,
        salary
from employees
where salary >=10000
order by salary desc;

--부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호 급여 이름을 출력하세요  
select department_id,
        salary,
        first_name
from employees
where department_id = department_id
order by department_id asc, salary desc;
-- 앞에가 1순위 



select employee_id from employees;
select* from departments;