-- Question 13

DECLARE 

lv_errnum VARCHAR(20);
lv_errmsg VARCHAR(120);
v_memNum NUMBER;
v_gameNum NUMBER;
v_memExists NUMBER;
v_gameExists NUMBER;
MEM_NOT_FOUND EXCEPTION;

BEGIN

v_memNum := '&member_number';
v_gameNum := '&game_number';

SELECT COUNT(*) INTO v_memExists FROM membership WHERE mem_num = v_memNum;
SELECT COUNT(*) INTO v_gameExists FROM game WHERE ga_num = v_gameNum;

IF v_memExists = 0 THEN

RAISE MEM_NOT_FOUND;

ELSE

PRC_NEW_RENTAL(v_memNum);
PRC_NEW_DETAIL(v_gameNum);

END IF;

EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
DBMS_OUTPUT.PUT_LINE('You are attempting to store duplicate values in a column with unique constraint.');

WHEN MEM_NOT_FOUND THEN
DBMS_OUTPUT.PUT_LINE('Member with ID ' || v_memNum || ' does not exist.');

WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('No data was found according to that criteria.');

WHEN ZERO_DIVIDE THEN
DBMS_OUTPUT.PUT_LINE('You are trying to divide by zero and it is not allowed.');

WHEN INVALID_NUMBER THEN
DBMS_OUTPUT.PUT_LINE('Data entered is not a valid number.');

WHEN VALUE_ERROR THEN
DBMS_OUTPUT.PUT_LINE('One of the values entered is not a number.');

WHEN OTHERS THEN
lv_errnum := SQLCODE;
lv_errmsg := SUBSTR(SQLERRM, 1,80);
DBMS_OUTPUT.PUT_LINE('Error occurred:');
DBMS_OUTPUT.PUT_LINE('Number: ' || lv_errnum);
DBMS_OUTPUT.PUT_LINE('Message abstract: ' || lv_errmsg);

END;

/