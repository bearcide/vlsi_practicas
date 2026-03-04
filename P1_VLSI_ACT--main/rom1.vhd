-- ROM1: Palabra "FACADE"
-- F=15  A=10  C=12  A=10  d=13  E=14
-- Espacios al inicio y final como pide el profesor
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY rom1 IS
    PORT(DIR : IN  INTEGER RANGE 0 TO 15;
         SAL : OUT INTEGER RANGE 0 TO 15);
END ENTITY;

ARCHITECTURE BEAS OF rom1 IS
    TYPE MEMORY IS ARRAY(0 TO 9) OF INTEGER RANGE 0 TO 15;
    --                   sp  sp   F   A   C   A   d   E  sp  sp
    CONSTANT ROM: MEMORY := (0, 0, 15, 10, 12, 10, 13, 14, 0, 0);
BEGIN
    SAL <= ROM(DIR);
END BEAS;
