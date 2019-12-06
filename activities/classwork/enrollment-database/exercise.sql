/*
 SECTION: Group exercises
 DESCRIPTION: Write a valid SQL query to solve each problem.
 */


-- A) Get all the unique department names.
-- * es seleccionar todas las columnas
SELECT DISTINCT department FROM  course;
-- DISTINCT seleccionar los valores únicos de department


-- B) Get the top 10 female students (first_name, last_name, age, gpa) with the best GPA scores and order by age (asc).
SELECT
	first_name AS "first name",
	last_name AS "Last name",
	age AS "Age",
	gpa AS "GPA"
FROM
	student
WHERE
	gender = 'female' -- aquí se podrían poner diferentes condiciones
ORDER BY
	gpa DESC, -- DESC = Descendiente
	age ASC,
	first_name ASC,
	last_name ASC
LIMIT 10
;


-- C) Count the number of male/female students that are at least 25 years old.
SELECT
	gender AS "Gender",
	count(gender) AS "Count"
FROM
	student
WHERE
	age >= 25
GROUP BY gender
;



-- D) Get the number of male/female students that were accepted
SELECT
    gender,
    count(gender)
FROM
	student INNER JOIN enrollment ON student.id = enrollment.student_id
WHERE
    enrollment.approved = 1
GROUP BY
    gender
;

-- E) Get the min, average, and max GPA of the accepted male students that are less than 20 years old.
SELECT
    MIN(gpa),
    AVG(gpa),
    MAX(gpa)
FROM
	student INNER JOIN enrollment ON student.id = enrollment.student_id
WHERE
    student.gender = 'male' AND student.age <= 20 AND enrollment.approved=1
;

SELECT
    *
FROM
     (SELECT
             gender,
             MIN(gpa),
             AVG(gpa),
             MAX(gpa)
      FROM student
               INNER JOIN enrollment e on student.id = e.student_id
      WHERE student.age <= 20
        AND e.approved = 1
      GROUP BY gender
     ) gender_aggregate
WHERE
      gender_aggregate.gender = 'male'
;


-- F) Get the number of enrollments to courses that take longer than 2 years to finalize.
SELECT
    count(*)
FROM
    course c INNER JOIN enrollment e on c.id = e.course_id
WHERE
    c.years > 2 AND e.approved = 1
;



-- G) Get the number of male/female student that will take a course from the 'Statistics' department.
SELECT
    gender,
    count(*)
FROM
    student s
        INNER JOIN enrollment e on s.id = e.student_id
        INNER JOIN course c on e.course_id = c.id
WHERE
    LOWER(c.department) = 'statistics'
-- LOWER(c.department) LIKE 'stat%'
GROUP BY
    gender
;

/*
 SECTION: Individual exercises
 DESCRIPTION: Write a valid SQL query to solve each problem.
 */

-- A) Count the number of courses per department
SELECT
    department,
    count(*)
FROM
    course
GROUP BY department;


-- B) How many male/female students were accepted?
SELECT
    gender,
    count(*)
FROM
    student
        INNER JOIN enrollment on student.id = enrollment.student_id
WHERE
    enrollment.approved=1
GROUP BY
    gender;


-- C) How many students were accepted per course?
SELECT
    c.name,
    count(*)
FROM
    student s
       INNER JOIN enrollment e on s.id = e.student_id
       INNER JOIN course c on e.course_id = c.id
WHERE
    e.approved=1

GROUP BY c.name;

-- D) What's the average age and gpa per course?
select
       c.name,
       avg(age),
       avg(gpa)
from
     student s
         inner join enrollment e on s.id = e.student_id
         inner join course c on e.course_id = c.id
group by name;

-- E) Get the average number of years the enrolled (approved) female student will study.
select
       avg(years)
from
     student s
         inner join enrollment e on s.id = e.student_id
         inner join course c on e.course_id = c.id
WHERE
      e.approved=1 and s.gender = 'female'
group by gender;