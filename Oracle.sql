-- Tüm çalışanların bilgilerini listeler 
SELECT * FROM HR.EMPLOYEES;
-- Lokasyon tablosundaki tüm bilgileri listeler 
SELECT * FROM HR.LOCATIONS;
-- Tüm çalışanların sadece birinci adı ve email adresleri gösterilir
SELECT FIRST_NAME, EMAIL FROM HR.EMPLOYEES;
-- İlk 20 Çalışan bigisi gösterme
SELECT * FROM HR.EMPLOYEES WHERE ROWNUM <= 20;
-- Çalışanların sadece soyadı ve maaşını listeleme 
SELECT LAST_NAME, SALARY FROM HR.EMPLOYEES;
-- Tüm çalışanların sayısını bulma 
SELECT COUNT(*) AS TOPLAM_CALISAN 
FROM HR.EMPLOYEES;
-- Lokasyon tablosundan sadece şehir,eyalet ve adressi bilgileri listeleme:
SELECT STREET_ADDRESS, CITY, STATE_PROVINCE 
FROM HR.LOCATIONS;
-- Tüm çalışanların ilk isimlerini alfebetik sıraya göre listeleme
SELECT FIRST_NAME 
FROM HR.EMPLOYEES 
ORDER BY FIRST_NAME ASC;
--İlk 30 çalışanın bilgilerini maaş sırasına göre (yüksekten düşüğe) listeleyin.
SELECT FIRST_NAME, LAST_NAME, SALARY 
FROM HR.EMPLOYEES 
ORDER BY SALARY DESC 
FETCH FIRST 30 ROWS ONLY;
--Çalışanların Ad Soyad bilgileri tek sütunda gösterir ve bu sütuna "TAM_AD" adıyla oluşur.
SELECT FIRST_NAME || ' ' || LAST_NAME AS TAM_AD 
FROM HR.EMPLOYEES;
-- İş geçmişi tablosunda kaç farklı departman var onu hesaplıyoruz
SELECT COUNT(DISTINCT DEPARTMENT_ID) AS FARKLI_DEPARTMENT_SAYISI 
FROM HR.JOB_HISTORY;
-- depertmant ıd=80 olan çalışanları belirleme
SELECT * FROM HR.EMPLOYEES WHERE DEPARTMENT_ID = 80;
-- Maaşı 10000 den büyük olan çalışanlar
SELECT FIRST_NAME, LAST_NAME, SALARY 
FROM HR.EMPLOYEES 
WHERE SALARY > 10000;
--Depertman ıd=80 den farklı olan çalışanları listeleme 
SELECT * FROM HR.EMPLOYEES WHERE DEPARTMENT_ID != 80;
-- Aralık belirleme
SELECT * FROM HR.EMPLOYEES WHERE SALARY BETWEEN 3000 AND 9000;
-- Çalışan tablosunda last name A ile başlayanlar listelenir
SELECT * FROM HR.EMPLOYEES WHERE LAST_NAME LIKE 'A%';
--Depertman id si 50 veya 80 olanları getir
SELECT * FROM HR.EMPLOYEES 
WHERE DEPARTMENT_ID = 50 OR DEPARTMENT_ID = 80;
-- Maaşa göre azalan tablosu
SELECT FIRST_NAME, LAST_NAME, SALARY 
FROM HR.EMPLOYEES 
ORDER BY SALARY DESC;
-- Benzersiz state_province 
SELECT DISTINCT STATE_PROVINCE FROM HR.LOCATIONS;
-- It depertmanındaki çalışanları listeleme
SELECT * FROM HR.EMPLOYEES WHERE JOB_ID LIKE 'IT%';
-- Maaşı 2000 ile 1000 arasında olan çalışanları listeleme
SELECT FIRST_NAME, LAST_NAME, SALARY 
FROM HR.EMPLOYEES 
WHERE SALARY BETWEEN 2000 AND 10000
ORDER BY SALARY;
-- İsmi c harfi ile başlayan ve 8000 den maaşı büyük olan kişileri listeleme
SELECT FIRST_NAME, LAST_NAME, SALARY 
FROM HR.EMPLOYEES 
WHERE FIRST_NAME LIKE 'C%' AND SALARY > 8000
ORDER BY SALARY DESC;
-- Telefon numarası olmayan veya telefon numarası 44 ile başlamayan çalışanları bulma
SELECT FIRST_NAME, LAST_NAME, PHONE_NUMBER 
FROM HR.EMPLOYEES 
WHERE PHONE_NUMBER IS NULL OR PHONE_NUMBER NOT LIKE '44%'
ORDER BY PHONE_NUMBER NULLS LAST;
-- Concat fonksiyonu ( birleştirme işlemi)
SELECT CONCAT(FIRST_NAME, LAST_NAME) AS FULL_NAME
FROM HR.EMPLOYEES;
-- String uzunluğu ( isimlerin uzunluğu kaç harfv olduğu)
SELECT FIRST_NAME, LENGTH(FIRST_NAME) AS NAME_LENGTH
FROM HR.EMPLOYEES;
-- String değiştirme (last name c ile başlayan kişilerin last nameleri c yerine * olarak değiştirildi 
SELECT LAST_NAME, REPLACE(LAST_NAME, 'C', '*') AS MODIFIED_NAME
FROM HR.EMPLOYEES;
--Yukarıdan aşağı yuvarlama
SELECT SALARY, CEIL(SALARY/12) AS MONTHLY_CEIL, FLOOR(SALARY/12) AS MONTHLY_FLOOR
FROM HR.EMPLOYEES;
-- 3 Ay ekleme 
SELECT HIRE_DATE, ADD_MONTHS(HIRE_DATE, 3) AS SIX_MONTHS_LATER
FROM HR.EMPLOYEES;
-- NVL fonksiyonu  null değeri 0 ile değiştirme
SELECT FIRST_NAME, NVL(COMMISSION_PCT, 0) AS COMMISSION
FROM HR.EMPLOYEES;
--  Her çalışanı maaşına göre düşük ,orta ve yüksek olarak katogrelize eder
SELECT FIRST_NAME, SALARY,
SELECT FIRST_NAME, SALARY,
       CASE 
           WHEN SALARY < 4000 THEN 'Düşük'
           WHEN SALARY BETWEEN 4000 AND 10000 THEN 'Orta'
           ELSE 'Yüksek'
       END AS SALARY_CATEGORY
FROM HR.EMPLOYEES;
-- Çalışanların tam adı yani adı ve soyadı ve eposta adreslerini büyük harfle gösterme
SELECT UPPER(FIRST_NAME || ' ' || LAST_NAME) AS FULL_NAME, 
       UPPER(EMAIL) AS EMAIL
FROM HR.EMPLOYEES;
-- Çalışanların çalışma süresi yıl olarak hesaplama
SELECT FIRST_NAME, LAST_NAME, HIRE_DATE,
       ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12, 1) AS YEARS_WORKED
FROM HR.EMPLOYEES;
-- Maaş kategorisi ve komisyon durumu analiz
SELECT FIRST_NAME, SALARY, COMMISSION_PCT,
       CASE 
           WHEN SALARY > 10000 THEN 'Senior'
           WHEN SALARY > 5000 THEN 'Mid-level'
           ELSE 'Junior'
       END AS LEVEL,
       NVL(COMMISSION_PCT, 0) AS COMMISSION
FROM HR.EMPLOYEES;
-- Join ile çalışanların hangi departmanda çalıştığını listeleme(departmanı olan çalışanlar listelenir)
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
FROM HR.EMPLOYEES E
INNER JOIN HR.DEPARTMENTS D
  ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
-- Depertmanların hepdi olacak ama çalışan yoksa boş kalacak
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
FROM HR.EMPLOYEES E
RIGHT JOIN HR.DEPARTMENTS D
  ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
-- Tüm lokasyon ve ülke bilgileri  kombinasyonları görmek için
SELECT E.CITY, E.STATE_PROVINCE, D.COUNTRY_NAME
FROM HR.LOCATIONS E
CROSS JOIN HR.COUNTRIES D;
-- Çalışanların ülke bilgileri
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY, C.COUNTRY_NAME
FROM HR.EMPLOYEES E
INNER JOIN HR.DEPARTMENTS D   ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
INNER JOIN HR.LOCATIONS L     ON D.LOCATION_ID = L.LOCATION_ID
INNER JOIN HR.COUNTRIES C     ON L.COUNTRY_ID = C.COUNTRY_ID;
-- Çalışanı olmayan depaartmanlar
SELECT D.DEPARTMENT_NAME
FROM HR.DEPARTMENTS D
LEFT JOIN HR.EMPLOYEES E
  ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE E.EMPLOYEE_ID IS NULL;
-- En yüksek maaşlı çalışan
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM HR.EMPLOYEES
WHERE SALARY = (SELECT MAX(SALARY) FROM HR.EMPLOYEES);
-- Marketing ve finance departamnında çalışanlar
SELECT first_name, last_name, department_id
FROM hr.employees
WHERE department_id IN (
    SELECT department_id 
    FROM hr.departments 
    WHERE department_name IN ('Marketing', 'Finance')
);
-- Kendi departmanının ortalamasından fazla kazananlar
SELECT E1.FIRST_NAME, E1.LAST_NAME, E1.SALARY, E1.DEPARTMENT_ID
FROM HR.EMPLOYEES E1
WHERE E1.SALARY > (
    SELECT AVG(E2.SALARY)
    FROM HR.EMPLOYEES E2
    WHERE E2.DEPARTMENT_ID = E1.DEPARTMENT_ID
);
-- Her depertmanın en düşük maşşlı çalışanı listeleme
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM HR.EMPLOYEES
WHERE (SALARY, DEPARTMENT_ID) IN (
    SELECT MIN(SALARY), DEPARTMENT_ID
    FROM HR.EMPLOYEES
    GROUP BY DEPARTMENT_ID
);
