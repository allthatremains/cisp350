--Chapter 13 Exercise #2
--Salmanyan, Jacob

DECLARE
  CURSOR invoices_cursor IS
    SELECT v.vendor_name, i.invoice_number, i.invoice_total
    FROM invoices i JOIN vendors v
      ON i.vendor_id = v.vendor_id
    WHERE i.invoice_total >= 5000
    ORDER BY i.invoice_total DESC;

  v_name    VARCHAR2(30);
  i_number  VARCHAR2(10);
  i_total   NUMBER(10,2);
  i_row     invoices%ROWTYPE;
BEGIN
  FOR i_row IN invoices_cursor LOOP
    v_name    := i_row.vendor_name;
    i_number  := i_row.invoice_number;
    i_total   := i_row.invoice_total;
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(i_total, '$999,999.99') || CHR(9) || i_number || CHR(9) || v_name);
  END LOOP;
END;
