-- Deliverable 1
SELECT emp.emp_no,
emp.first_name,
emp.last_name,
tit.title,
tit.from_date,
tit.to_date
Into retirement_titles
From employees as emp 
INNER Join titles as tit
ON (emp.emp_no = tit.emp_no)
Where birth_date between '1952-01-01' and '1955-12-31'
Order By emp.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no ASC, to_date DESC;

-- Retirement number by job title
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

-- Mentorship Eligibility (Deliverable 2)

Select Distinct on (emp.emp_no) emp.emp_no, 
	emp.first_name, 
	emp.last_name, 
	emp.birth_date,
	dep.from_date,
	dep.to_date,
	tit.title
Into mentor_eligibility
From employees as emp
Inner Join dept_emp as dep
ON (emp.emp_no = dep.emp_no)
Inner Join titles as tit
ON (emp.emp_no = tit.emp_no)
Where (dep.to_date = '9999-01-01') 
and birth_date between '1965-01-01' and '1965-12-31'
Order by emp.emp_no;

-- Eligible number of mentors (Deliverables 1 & 2)
SELECT COUNT(title), title
FROM mentor_eligibility
GROUP BY title
ORDER BY count DESC;

-- Most recent 4 year average (Deliverable 3 Q1)
Select count (hire_date)
From employees
Where hire_date between '1997-01-01' and '2000-12-31'

Select count (birth_date)
From employees
Where birth_date between '1952-01-01' and '1955-12-31'

-- Mentorship Eligibility by Department (Deliverable 3 Q2)
Select Distinct on (emp.emp_no) emp.emp_no, 
	emp.first_name, 
	emp.last_name, 
	emp.birth_date,
	dm.dept_no, 
	dep.dept_name
Into department_mentors
From employees as emp
Inner Join dept_emp as dm
ON (emp.emp_no = dm.emp_no)
Right Join departments as dep
ON (dm.dept_no = dep.dept_no)
Where (dm.to_date = '9999-01-01') 
and birth_date between '1952-01-01' and '1955-12-31'
Order by emp.emp_no;

-- Eligible number of mentors (D3 Q2)
SELECT COUNT(dept_name), dept_name
FROM department_mentors
GROUP BY dept_name
ORDER BY count DESC;

