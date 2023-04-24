--Chapter 13 Exercise #2
--Salmanyan, Jacob

DECLARE
     unpaid_count     NUMBER := 0;
     unpaid_total     NUMBER := 0;
BEGIN
     SELECT COUNT(invoice_total), SUM(invoice_total)
     INTO unpaid_count, unpaid_total
     FROM invoices
     WHERE invoice_total > 0;

     IF unpaid_total >= 50000 THEN
         DBMS_OUTPUT.PUT_LINE('Number of unpaid invoices is ' || unpaid_count || '.');
         DBMS_OUTPUT.PUT_LINE('Total balance due is $' || TO_CHAR(unpaid_total, 'FM999,999.99') || '.');
     ELSE
         DBMS_OUTPUT.PUT_LINE('Total balance due is less than $50,000.');
     END IF;
END;
