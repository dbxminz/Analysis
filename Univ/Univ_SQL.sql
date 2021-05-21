use univ;
--- (1) To find all instructors in Comp. Sci. dept
		select *
        from instructor
        where dept_name = "Comp. Sci.";

--- (2) To find all instructors in Comp. Sci. dept with salary > 80000
		select *
        from instructor
        where dept_name = "Comp. Sci." and salary > 80000;
        
--- (3) Find the Cartesian product instructor X teaches
		select *
        from instructor, teaches;

--- (4) Find the names of all instructors who have taught some course and the course_id
		select distinct name
        from instructor, teaches
        where instructor.ID = teaches.ID;

--- (5) Find the names of all instructors in the Art department who have taught some course and the course_id
		select distinct name
        from instructor, teaches
        where instructor.ID = teaches.ID and dept_name = "Art";

--- (6) Find the names of all instructors who have a higher salary than some instructor in 'Comp. Sci'.
		select name
        from instructor
        where salary > some (select salary
							 from instructor
							 where dept_name = "Comp. Sci.");

--- (7) Find the names of all instructors whose name includes the substring “dar”.
		select name
        from instructor
        where name like "%dar%";

--- (8) Find the names of all instructors with salary between $90,000 and $100,000
		select name
        from instructor
        where salary between 90000 and 100000;

--- (9) Find courses that ran in spring 2010  and in Fall 2009
		select course_id 
        from teaches 
        where semester = "fall" and year = 2009 and course_id in (select course_id from teaches where semester = "spring" and year = 2010);

--- (10) Find courses that ran in spring 2010 or in Fall 2009
		(select course_id from teaches where semester = "Fall" and year = 2009)
        union
        (select course_id from teaches where semester = "Spring" and year = 2010);

--- (11) Find courses that ran in all spring 2010 but not in Fall 2009
		select course_id 
        from teaches 
        where semester = "Spring" and year = 2010 and (course_id not in (select course_id from teaches where semester = "Fall" and year = 2009));

--- (12) Find the average salary of instructors in the Computer Science department 
		select avg(salary) as avg_salary
        from instructor
        where dept_name = "Comp. Sci.";

--- (13) Find the total number of instructors who teach a course in the Spring 2010 semester
		select count(distinct name) as nummer_instructors
        from instructor, teaches
        where instructor.ID = teaches.ID and semester = "Spring" and year = 2010;
        
--- (14) Find the number of tuples in the course relation
		select count(*)
        from course;
        
--- (15) Find the average salary of instructors in each department
		select dept_name, avg(salary) as avg_salary
        from instructor
        group by dept_name;

--- (16) Find the names and average salaries of all departments whose average salary is greater than 42000
		select department.dept_name, avg(salary) as avg_salary
        from department, instructor
        where department.dept_name = instructor.dept_name
        group by department.dept_name
        having avg_salary > 42000;

--- (17) Name all instructors whose name is neither “Mozart” nor Einstein”
		select name
        from instructor
        where name not in ("Mozart", "Einstein");

--- (18) Find the total number of (distinct) students who have taken course sections taught by the instructor with ID 10101
		select count(distinct takes.ID) as number_of_student
        from takes, teaches
        where takes.course_id = teaches.course_id and teaches.ID = 10101;
        
--- (19) Find names of instructors with salary greater than that of some (at least one) instructor in the Comp. Sci. department.
		select name
        from instructor
        where salary > some(select salary from instructor where dept_name="Comp. Sci.");
	
--- (20) Find the names of all instructors whose salary is greater than the salary of all instructors in the Comp. Sci. department.
		select name
        from instructor
        where salary> all(select salary from instructor where dept_name = "Comp. Sci.");
        
--- (21) Find all students who have taken all courses offered in the Biology department.
		select distinct T.ID
        from takes as T
        where not exists ((select course.course_id from course, takes as K where K.ID = T.ID and dept_name = "Biology"));

        
--- (22) Find all departments with the maximum budget
		select dept_name
        from department
        where budget = (select max(budget) from department);
        
--- (23) Delete all instructors from the Finance department
		Delete from instructor
        where dept_name = "Finance";
        
        select *
        from instructor;
        
--- (24) Delete all instructors whose salary is less than the average salary of instructors
		set sql_safe_updates=0;
		Delete from instructor
        where salary < (select salary from (select avg(salary) as salary from instructor) as i);
        
        select ID, salary
        from instructor;
        
--- (25) Give a 5% salary raise to all instructors
		UPDATE instructor
        SET salary = salary + (salary * 0.05);
        
        select ID, salary
        from instructor;

--- (26) Increase salaries of instructors whose salary is over $100,000 by 3%, and all others by a 5% 
		UPDATE instructor
        SET salary = salary + (salary*0.03)
        WHERE salary > 10000;
        
        UPDATE instructor
        SET salary = salary + (salary*0.05)
        WHERE salary <= 10000;
        
        select ID, salary
        from instructor;
        
--- (27) Add a new tuple to student  with tot_creds set to null
		insert into student(ID, name, dept_name, tot_cred)
        values(17099, "hi", "Comp. Sci.", null);
        
        select *
        from student;
		

