--Chapter 13 Exercise #1
--Salmanyan, Jacob

DECLARE
     invoice_count  NUMBER := 0;
BEGIN
     SELECT COUNT(invoice_total)
     INTO invoice_count
     FROM invoices
     WHERE invoice_total >= 5000;

     DBMS_OUTPUT.PUT_LINE(invoice_count || ' invoices exceed $5,000.');
END;
