LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY deco IS
    PORT(ENTRADAS: IN INTEGER RANGE 0 TO 10;
         SEG: OUT STD_LOGIC_VECTOR(0 TO 7));
END ENTITY;

ARCHITECTURE BEAS OF deco IS
BEGIN 
    WITH ENTRADAS SELECT
        SEG <= "11111111" WHEN 0,  -- - (Todo apagado)
               "00001101" WHEN 1,  -- 3
               "10011111" WHEN 2,  -- 1
               "00000001" WHEN 3,  -- 8
               "00000011" WHEN 4,  -- 0
               "00001101" WHEN 5,  -- 3
               "00001001" WHEN 6,  -- 9
               "00000011" WHEN 7,  -- 0
               "00100101" WHEN 8,  -- 2
               "01000001" WHEN 9,  -- 6
               "11111111" WHEN 10, -- - (Todo apagado)
               "11111111" WHEN OTHERS;
                  
END BEAS;