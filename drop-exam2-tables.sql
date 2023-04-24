-- CISP 350: Exam #2 - Database Design and Implementation Project
-- Reed, Tate
-- Salmanyan, Jacob

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