/*12.17 함수소개*/
/*단일행 함수*/
-- 문자함수 – INITCAP(컬럼명) 맨앞글자만 대문자로, 나머지는 소문자로
select  email,
        initcap(email),
        department_id
from employees
where department_id = 100;

--문자함수 – LOWER(컬럼명),값을 전부 소문자 / UPPER(컬럼명) ,값을 전부 대문자
select first_name,
        lower(first_name),
        upper(first_name)
from employees
where department_id=100;

--문자함수 – SUBSTR(컬럼명, 시작위치, 글자수)
select  first_name,
        substr(first_name,3),
        substr(first_name,2,10),
        substr(first_name,-3,2)
from employees
where department_id = 100;


--문자함수 
-- LPAD(컬럼명, 자리수, ‘채울문자’) , 자리수에 맞춰서 출력, 자리수가 안되는 문자는 채울문자로 채워줌(앞에)
-- RPAD(컬럼명, 자리수, ‘채울문자’) , 자리수에 맞춰서 출력, 자리수가 안되는 문자는 채울문자로 채워줌(뒤에)
select first_name,
        lpad(first_name,10,'*'),
        rpad(first_name,10,'*')
from employees;

--문자함수 – REPLACE (컬럼명, 문자1, 문자2)
select first_name,
        replace(first_name,'nc','*'),
        department_id
from employees
where department_id = 100;

--함수조합
select  first_name,
        replace(first_name,'a','*'),
        substr(first_name,2,3),
        replace(first_name,substr(first_name,2,4),'****')
from employees
where department_id = 100;

-- 숫자함수 – ROUND(숫자, 출력을 원하는 자리수) 
select round(123.456,2) r2,
        round(123.656,0) r0,
        round(123.456,-1) "r-1"
from dual;
-- dual -->가상의 테이블
-- selct/from은 빠지면 에러남

--숫자함수 – TRUNC(숫자, 출력을 원하는 자리수) 
select  trunc(123.456,2) as r2,
        trunc(123.456,0) as r0,
        trunc(123.456,2) as r2
from dual;  

--날짜함수 – SYSDATE   -- >()값이 없음
select sysdate
from dual;

-- sysdate열이 추가됨
select first_name ||'   '|| sysdate,
        first_name
from employees;

--날짜함수 – MONTH_BETWEEN(d1, d2) 
select  sysdate,
        hire_date,
        months_between(sysdate, hire_date) as "workMonth",
        trunc(months_between(sysdate, hire_date),0) "근무개월"
from employees
where department_id = 100;

--날짜함수 - LAST_DAY(d1) 
select last_day('19/02/06'),
        last_day(sysdate)
from dual;

--변환함수>TO_CHAR(날짜, ‘출력모양’)  날짜문자형으로 변환하기
-- to_char -->출력모양은 문자숫자에 맞게
select  first_name 이름,
        salary 급여,
        salary*12 연봉,
        to_char(salary*12,'$999,999.00'), 
        to_char(salary*12,'999,999.00'), 
        to_char(salary*12,'999,999'), 
        to_char(salary*12,'099.999'), 
        to_char(salary*12,'999999') 
from employees
where department_id = 100;

--변환함수>TO_CHAR(날짜, ‘출력모양’)  날짜문자형으로 변환하기
select  sysdate,
        to_char(sysdate, 'YYYY') "YYYY(연도)",
        to_char(sysdate, 'YY') "YY(연도)",
        to_char(sysdate, 'MM') MM,
        to_char(sysdate, 'MONTH') MONTH,
        to_char(sysdate, 'DD') DD,
        to_char(sysdate, 'DAY') DAY,
        to_char(sysdate, 'HH') HH,
        to_char(sysdate, 'HH24') HH24,
        to_char(sysdate, 'MI') MI,
        to_char(sysdate, 'SS') SS
from dual;


--년월일 시분초
select sysdate, 
       to_char(sysdate, 'YYYY"년"-MM"월"-DD"일" HH:MI:SS')
from dual;

select first_name,
        hire_date,
        to_char(hire_date,'YYYY-MM-DD HH24:MI:SS')
        -- hire_date 실제값에 시분초가 안들어가 있어서 00:00:00 으로 출력됬음
from employees;


--일반함수>NVL(컬럼명, null일때값)/NVL2(컬럼명, null아닐때값, null일때 값)
select first_name,
        commission_pct,
        NVL(commission_pct, 100),
        NVL(commission_pct, '100'),
        NVL2(commission_pct, 100 , 0),
        NVL2(commission_pct, '100' , 0),
        NVL2(commission_pct, 100 , '0')
from employees;
-- NVL2(commission_pct, null이 아닐때의 값 , null일때의 값) // '0' 값을 넣어줬을때 정렬이 다르게됨 (문자,숫자차이?)

