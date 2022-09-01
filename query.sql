-- Список курсов, которые посещает студент.
SELECT DISTINCT s.student, d.discipline
FROM grades g
LEFT JOIN students s ON s.id = g.student
LEFT JOIN disciplines d ON d.id = g.discipline
WHERE g.student = 12;

-- 5 студентов с наибольшим средним баллом по всем предметам.
SELECT s.student,
round(avg(g.grade), 2) AS avg_grade
FROM grades g
LEFT JOIN students s ON s.id = g.student
GROUP BY s.id
ORDER BY avg_grade DESC
LIMIT 5

-- 1 студент с наивысшим средним баллом по одному предмету.
SELECT d.discipline, s.student, round(avg(g.grade),2) AS grade
from grades g
LEFT JOIN students s on s.id = g.student
LEFT JOIN disciplines d ON d.id =g.discipline
WHERE  d.id = 1
GROUP BY s.id , d.id
ORder by (round(avg(g.grade), 2)) DESC
LIMIT 1

-- средний балл в группе по одному предмету.
SELECT d.discipline, gr.[group], round(avg(g.grade),2) AS grade
from grades g
LEFT JOIN students s on s.id = g.student
LEFT JOIN disciplines d ON d.id =g.discipline
LEFT JOIN [groups] gr ON gr.id =s.[group]
WHERE  d.id = 2
GROUP BY gr.id
ORder by grade DESC
LIMIT 1

-- Средний балл в потоке.
SELECT round(avg(grade), 2) as avg_grade
FROM grades

-- Какие курсы читает преподаватель.
SELECT DISTINCT d.discipline, t.teacher
FROM teachers t
LEFT JOIN disciplines d ON d.teacher = t.id
WHERE d.teacher = 2;

-- Список студентов в группе.
SELECT DISTINCT s.student, s."group"
FROM students s
WHERE s."group" =1

-- Оценки студентов в группе по предмету.
SELECT d.discipline, gr.[group], s.student, g.date_of, g.grade
FROM grades g
LEFT JOIN students s ON s.id = g.student
LEFT JOIN disciplines d ON d.id = g.discipline
LEFT JOIN [groups] gr  ON gr.id = s.[group]
WHERE d.id = 2 and gr.id=1

-- Оценки студентов в группе по предмету на последнем занятии.
SELECT d.discipline, gr.[group], s.student, g.date_of, g.grade
FROM grades g
LEFT JOIN students s ON s.id = g.student
LEFT JOIN disciplines d ON d.id = g.discipline
LEFT JOIN [groups] gr  ON gr.id = s.[group]
WHERE d.id = 1 and gr.id=3 and g.date_of = (
SELECT g.date_of
FROM grades g
LEFT JOIN students s on s.id =g.student
LEFT JOIN [groups] gr on gr.id =s.[group]
WHERE g.discipline =1
and gr.id =3
ORDER by g.date_of  DESC
limit 1
)
order by date_of DESC

-- Список курсов, которые посещает студент.
SELECT DISTINCT s.student, d.discipline
FROM grades g
LEFT JOIN students s ON s.id = g.student
LEFT JOIN disciplines d ON d.id = g.discipline
WHERE g.student =7

-- Список курсов, которые студенту читает преподаватель.
SELECT distinct s.student, t.teacher, d.discipline
from grades g
LEFT JOIN students s on s.id = g.student
LEFT JOIN disciplines d  on d.id = g.discipline
LEFT JOIN teachers t  on t.id = d.teacher
WHERE g.student =12 and t.id =2

-- Средний балл, который преподаватель ставит студенту.
SELECT DISTINCT s.student, t.teacher, round(avg(grade), 2) as avg_grade
from grades g
LEFT JOIN students s on s.id = g.student
LEFT JOIN disciplines d  on d.id = g.discipline
LEFT JOIN teachers t  on t.id = d.teacher
WHERE g.student = 13 and t.id =2
GROUP BY s.student, t.teacher

-- Средний балл, который ставит преподаватель.
SELECT DISTINCT t.teacher, round(avg(grade), 2) as avg_grade
from grades g
LEFT JOIN disciplines d  on d.id = g.discipline
LEFT JOIN teachers t  on t.id = d.teacher
WHERE t.id =2
GROUP BY t.teacher