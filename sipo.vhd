LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY sipo IS
    PORT(
        CLK     : IN  STD_LOGIC;
        ENTRADA : IN  STD_LOGIC_VECTOR(0 TO 7);
        Q1, Q2, Q3, Q4, Q5, Q6 : BUFFER STD_LOGIC_VECTOR(0 TO 7)
    );
END ENTITY;

ARCHITECTURE BEAS OF sipo IS
BEGIN
    PROCESS(CLK)
    BEGIN
        IF RISING_EDGE(CLK) THEN
            Q1 <= ENTRADA;
            Q2 <= Q1;
            Q3 <= Q2;
            Q4 <= Q3;
            Q5 <= Q4;
            Q6 <= Q5;
        END IF;
    END PROCESS;
END BEAS;