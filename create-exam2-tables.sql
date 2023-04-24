-- CISP 350: Exam #2 - Database Design and Implementation Project
-- Salmanyan, Jacob
-- Reed, Tate
BEGIN
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE invoices';
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE enrollments';
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE sections';
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE courses';
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE faculty';
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE departments';
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE terms';
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE students';
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE admissions';
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
END;
/







CREATE TABLE admissions
(
  application_id    NUMBER        NOT NULL, --PK for admissions
  eligibility       CHAR(1), -- 'Y' or 'N'
  placement         VARCHAR2(30),
  competency_req    VARCHAR2(30),
  eForm_id          NUMBER        UNIQUE,
  eForm_status      VARCHAR2(20),
  transfer_units    NUMBER(3)     DEFAULT 0,
  transfer_units_status CHAR(1), -- 'Y' or 'N'
  CONSTRAINT admission_pk PRIMARY KEY (application_id)
);

CREATE TABLE students
(
  student_id        NUMBER          NOT NULL, --PK for admissions
  application_id    NUMBER          NOT NULL, --FK for admissions
  academic_progress VARCHAR2(30),
  academic_standing CHAR(1),
  student_type      VARCHAR2(20),
  priority          NUMBER(2)       NOT NULL  CHECK (priority <= 3), --0, 0.5, 0.75, 1, 2, 3
  edu_goal          VARCHAR2(50),
  gpa               NUMBER(3,2)     DEFAULT 0.00,
  first_name        VARCHAR2(30)    NOT NULL,
  last_name         VARCHAR2(30)    NOT NULL,
  preferred_name    VARCHAR2(30),
  preferred_pronoun VARCHAR2(10),
  address           VARCHAR2(50)    NOT NULL,
  phone             NUMBER(10)      NOT NULL    UNIQUE,
  email             VARCHAR2(50)    NOT NULL    UNIQUE,
  gender            VARCHAR2(10)    NOT NULL,
  race              VARCHAR2(20)    NOT NULL,
  birthday          DATE            NOT NULL,
  residency_status  VARCHAR2(20),
  CONSTRAINT student_pk PRIMARY KEY (student_id),
  CONSTRAINT student_fk_applications FOREIGN KEY (application_id)
    REFERENCES admissions (application_id)
);

CREATE TABLE terms
(
  term_id           NUMBER          NOT NULL    CHECK (term_id >= 0),
  term_name         VARCHAR2(20)    NOT NULL    UNIQUE,
  drop_deadline     DATE            NOT NULL,
  enroll_deadline   DATE            NOT NULL,
  withdraw_deadline DATE            NOT NULL,
  CONSTRAINT term_pk PRIMARY KEY (term_id)
);

CREATE TABLE departments
(
  department_id     NUMBER        NOT NULL,
  department_name   VARCHAR2(20)  NOT NULL    UNIQUE,
  CONSTRAINT department_pk PRIMARY KEY (department_id)
);

CREATE TABLE faculty
(
  employee_id       NUMBER          NOT NULL    CHECK (employee_id >= 0),
  department_id     NUMBER          NOT NULL    CHECK (department_id >= 0),
  first_name        VARCHAR2(30)    NOT NULL,
  last_name         VARCHAR2(30)    NOT NULL,
  preferred_name    VARCHAR2(30),
  preferred_pronoun VARCHAR2(10),
  address           VARCHAR2(50)    NOT NULL,
  phone             NUMBER(10)      NOT NULL    UNIQUE,
  email             VARCHAR2(50)    NOT NULL    UNIQUE,
  gender            VARCHAR2(10)    NOT NULL,
  race              VARCHAR2(20)    NOT NULL,
  birthday          DATE            NOT NULL,
  CONSTRAINT faculty_pk PRIMARY KEY (employee_id),
  CONSTRAINT faculty_fk_department FOREIGN KEY (department_id)
    REFERENCES departments (department_id)
);

CREATE TABLE courses
(
  course_id     NUMBER(5)     NOT NULL,
  department_id NUMBER        NOT NULL,
  course_name   VARCHAR2(30) 	NOT NULL,
  course_number NUMBER		    NOT NULL	CHECK (course_number > 0),
  advisory      NUMBER(5),
  corequisite   NUMBER(5),
  prerequisite  NUMBER(5),
  num_units     NUMBER		    NOT NULL	CHECK (num_units >= 0),
  CONSTRAINT course_pk PRIMARY KEY (course_id),
  CONSTRAINT course_fk_department FOREIGN KEY (department_id)
    REFERENCES departments (department_id)
);

CREATE TABLE sections
(
  section_id        NUMBER        NOT NULL,
  term_id           NUMBER        NOT NULL, --FK for terms
  employee_id       NUMBER        NOT NULL, --FK for faculty
  course_id         NUMBER        NOT NULL, --FK for courses
  num_students      NUMBER        NOT NULL,
  class_mode        VARCHAR2(20)  NOT NULL,
  class_status      VARCHAR2(10)  NOT NULL,
  credit_status     CHAR(1)       NOT NULL, -- 'T' or 'F'
  credential_type   VARCHAR2(20),
  enrollment_status VARCHAR2(20),
  ge_requirement    VARCHAR2(20),
  program_major     VARCHAR2(30),
  transfer_status   CHAR(1),  -- 'Y' or 'N'
  CONSTRAINT section_pk PRIMARY KEY (section_id),

  CONSTRAINT section_fk_terms FOREIGN KEY (term_id)
    REFERENCES terms (term_id),

  CONSTRAINT section_fk_faculty FOREIGN KEY (employee_id)
    REFERENCES faculty (employee_id),

  CONSTRAINT section_fk_courses FOREIGN KEY (course_id)
    REFERENCES courses (course_id)
);

CREATE TABLE enrollments
(
  enroll_id     NUMBER    NOT NULL  UNIQUE,
  section_id    NUMBER    NOT NULL, --FK for sections
  student_id    NUMBER    NOT NULL, --FK for students
  CONSTRAINT enrollments_fk_sections FOREIGN KEY (section_id)
    REFERENCES sections (section_id),
  CONSTRAINT enrollments_fk_students FOREIGN KEY (student_id)
    REFERENCES students (student_id)
);

CREATE TABLE invoices
(
  invoice_id    NUMBER    NOT NULL,
  student_id    NUMBER    NOT NULL,
  amount_owed   NUMBER    DEFAULT 0    CHECK (amount_owed >= 0),
  amount_paid   NUMBER    DEFAULT 0    CHECK (amount_paid >= 0),
  pay_due_date  DATE      NOT NULL,
  transaction_status      CHAR(1)      NOT NULL,
  CONSTRAINT invoices_pk PRIMARY KEY (invoice_id),
  CONSTRAINT invoices_fk_students FOREIGN KEY (student_id)
    REFERENCES students (student_id)
);



INSERT INTO admissions (application_id, eligibility, placement, competency_req, eForm_id, eForm_status, transfer_units, transfer_units_status)
VALUES (9161, 'Y', 'English', 'Mathematics', 123, 'Approved', 90, 'Y');
INSERT INTO admissions (application_id, eligibility, placement, competency_req, eForm_id, eForm_status, transfer_units, transfer_units_status)
VALUES (9162, 'N', NULL, 'English', 45, 'Rejected', 0, 'N');
INSERT INTO admissions (application_id, eligibility, placement, competency_req, eForm_id, eForm_status, transfer_units, transfer_units_status)
VALUES (9163, 'Y', 'Mathematics', 'English', 90, 'Pending', NULL, NULL);

INSERT INTO students (student_id, application_id, academic_progress, academic_standing, student_type, priority, edu_goal, gpa, first_name, last_name, preferred_name, preferred_pronoun, address, phone, email, gender, race, birthday, residency_status)
VALUES (1010101, 9163, 'On track', 'G', 'Full-time', 1, 'Bachelor of Arts', 3.8, 'John', 'Doe', 'JD', 'He/Him', '123 Main St, Anytown USA', 5551234, 'johndoe@email.com', 'Male', 'Caucasian', TO_DATE('2002-05-10', 'yyyy-mm-dd'), 'Resident');
INSERT INTO students (student_id, application_id, academic_progress, academic_standing, student_type, priority, edu_goal, gpa, first_name, last_name, preferred_name, preferred_pronoun, address, phone, email, gender, race, birthday, residency_status)
VALUES (2020202, 9162, 'Needs improvement', 'U', 'Part-time', 2, 'Associate of Science', 2.5, 'Jane', 'Smith', 'Janie', 'She/Her', '456 Oak Ln, Anytown USA', 5554321, 'janesmith@email.com', 'Female', 'African-American', TO_DATE('2001-01-01', 'yyyy-mm-dd'), 'Non-Resident');
INSERT INTO students (student_id, application_id, academic_progress, academic_standing, student_type, priority, edu_goal, gpa, first_name, last_name, preferred_name, preferred_pronoun, address, phone, email, gender, race, birthday, residency_status)
VALUES (3030303, 9161, 'In progress', 'G', 'Full-time', 1, 'Bachelor of Science', 3.2, 'Alex', 'Rodriguez', NULL, 'They/Them', '789 Maple Ave, Anytown USA', 5556789, 'arod@email.com', 'Non-Binary', 'Hispanic', TO_DATE('2000-06-15', 'yyyy-mm-dd'), 'Resident');

INSERT INTO terms (term_id, term_name, drop_deadline, enroll_deadline, withdraw_deadline)
VALUES (2022, 'Fall 2022', TO_DATE('2022-09-10', 'YYYY-MM-DD'), TO_DATE('2022-09-15', 'YYYY-MM-DD'), TO_DATE('2022-11-01', 'YYYY-MM-DD'));
INSERT INTO terms (term_id, term_name, drop_deadline, enroll_deadline, withdraw_deadline)
VALUES (2023, 'Spring 2023', TO_DATE('2023-02-01', 'YYYY-MM-DD'), TO_DATE('2023-02-05', 'YYYY-MM-DD'), TO_DATE('2023-04-01', 'YYYY-MM-DD'));
INSERT INTO terms (term_id, term_name, drop_deadline, enroll_deadline, withdraw_deadline)
VALUES (2024, 'Summer 2023', TO_DATE('2023-05-15', 'YYYY-MM-DD'), TO_DATE('2023-05-20', 'YYYY-MM-DD'), TO_DATE('2023-06-15', 'YYYY-MM-DD'));

INSERT INTO departments (department_id, department_name)
VALUES (401, 'Mathematics');
INSERT INTO departments (department_id, department_name)
VALUES (402, 'Computer Science');
INSERT INTO departments (department_id, department_name)
VALUES (403, 'English');

INSERT INTO faculty (employee_id, department_id, first_name, last_name, preferred_name, preferred_pronoun, address, phone, email, gender, race, birthday)
VALUES (101111, 401, 'John', 'Doe', 'Johnny', 'he/him', '123 Main St', 5551234, 'jdoe@university.edu', 'Male', 'Caucasian', TO_DATE('1990-01-01', 'YYYY-MM-DD'));
INSERT INTO faculty (employee_id, department_id, first_name, last_name, preferred_name, preferred_pronoun, address, phone, email, gender, race, birthday)
VALUES (102222, 402, 'Jane', 'Smith', 'Janie', 'she/her', '456 Oak St', 5555678, 'jsmith@university.edu', 'Female', 'African American', TO_DATE('1988-05-12', 'YYYY-MM-DD'));
INSERT INTO faculty (employee_id, department_id, first_name, last_name, preferred_name, preferred_pronoun, address, phone, email, gender, race, birthday)
VALUES (103333, 403, 'William', 'Johnson', 'Will', 'he/him', '789 Pine St', 5559012, 'wjohnson@university.edu', 'Male', 'Hispanic', TO_DATE('1993-11-24', 'YYYY-MM-DD'));

INSERT INTO courses (course_id, department_id, course_name, course_number, advisory, corequisite, prerequisite, num_units)
VALUES (10001, 401, 'Calculus I', 101, 20001, NULL, NULL, 4);
INSERT INTO courses (course_id, department_id, course_name, course_number, advisory, corequisite, prerequisite, num_units)
VALUES (10002, 401, 'Calculus II', 102, 10001, NULL, NULL, 4);
INSERT INTO courses (course_id, department_id, course_name, course_number, advisory, corequisite, prerequisite, num_units)
VALUES (20001, 402, 'Introduction to Programming', 101, NULL, NULL, 10002, 3);

INSERT INTO sections (section_id, term_id, employee_id, course_id, num_students, class_mode, class_status, credit_status, credential_type, enrollment_status, ge_requirement, program_major, transfer_status)
VALUES (101, 2022, 101111, 10001, 25, 'In-Person', 'Open', 'T', 'Bachelors', 'Full-time', 'Met', 'Mathematics', 'N');
INSERT INTO sections (section_id, term_id, employee_id, course_id, num_students, class_mode, class_status, credit_status, credential_type, enrollment_status, ge_requirement, program_major, transfer_status)
VALUES (102, 2022, 102222, 10002, 30, 'Online', 'Open', 'T', 'Associates', 'Part-time', 'Not-met', 'Mathematics', 'N');
INSERT INTO sections (section_id, term_id, employee_id, course_id, num_students, class_mode, class_status, credit_status, credential_type, enrollment_status, ge_requirement, program_major, transfer_status)
VALUES (201, 2022, 103333, 20001, 20, 'Hybrid', 'Open', 'T', 'Certificate', 'Full-time', 'Met', 'Computer Science', 'N');

INSERT INTO enrollments (enroll_id, section_id, student_id)
VALUES (100001, 101, 1010101);
INSERT INTO enrollments (enroll_id, section_id, student_id)
VALUES (100002, 101, 2020202);
INSERT INTO enrollments (enroll_id, section_id, student_id)
VALUES (100003, 102, 3030303);

INSERT INTO invoices (invoice_id, student_id, amount_owed, amount_paid, pay_due_date, transaction_status)
VALUES (50001, 1010101, 5000, 0, TO_DATE('2023-05-01', 'YYYY-MM-DD'), 'U');
INSERT INTO invoices (invoice_id, student_id, amount_owed, amount_paid, pay_due_date, transaction_status)
VALUES (50002, 2020202, 4000, 2000, TO_DATE('2023-04-10', 'YYYY-MM-DD'), 'P');
INSERT INTO invoices (invoice_id, student_id, amount_owed, amount_paid, pay_due_date, transaction_status)
VALUES (50003, 3030303, 6000, 1000, TO_DATE('2023-04-20', 'YYYY-MM-DD'), 'P');
