LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY reg_des IS
    PORT(ENTRADA              : IN     INTEGER RANGE 0 TO 15;
         CLK, RST             : IN     STD_LOGIC;
         Q0,Q1,Q2,Q3,Q4,Q5   : BUFFER INTEGER RANGE 0 TO 15);
END ENTITY;

ARCHITECTURE BEAS OF reg_des IS
BEGIN
    PROCESS(CLK)
    BEGIN
        IF RISING_EDGE(CLK) THEN
            IF RST = '1' THEN
                Q0<=0; Q1<=0; Q2<=0; Q3<=0; Q4<=0; Q5<=0;
            ELSE
                Q0 <= ENTRADA;
                Q1 <= Q0;
                Q2 <= Q1;
                Q3 <= Q2;
                Q4 <= Q3;
                Q5 <= Q4;
            END IF;
        END IF;
    END PROCESS;
END BEAS;
