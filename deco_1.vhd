LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY deco_1 IS
    PORT(ENTRADAS: IN INTEGER RANGE 0 TO 6;
         SEG: OUT STD_LOGIC_VECTOR(0 TO 7));
END ENTITY;

ARCHITECTURE BEAS OF deco_1 IS
BEGIN 
    WITH ENTRADAS SELECT
        SEG <= "11111111" WHEN 0, 
               "00010001" WHEN 1, 
               "11000001" WHEN 2, 
               "01100011" WHEN 3, 
               "10000101" WHEN 4, 
               "01100001" WHEN 5, 
               "11111111" WHEN 6, 
               "11111111" WHEN OTHERS;
                  
END BEAS;