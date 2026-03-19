LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY deco IS
    PORT(ENTRADAS: IN STD_LOGIC_VECTOR(2 DOWNTO 0);  -- 3 bits del contador
         SEG: OUT STD_LOGIC_VECTOR(0 TO 7));         -- Salida al display de 7 segmentos
END ENTITY;

ARCHITECTURE BEAS OF deco IS
BEGIN 
    WITH ENTRADAS SELECT
        SEG <= "11111111" WHEN "000",  -- 0: - (Todo apagado)
               "00001101" WHEN "001",  -- 1: 3
               "00100101" WHEN "010",  -- 2: 2
               "00000011" WHEN "011",  -- 3: 0
               "01001001" WHEN "100",  -- 4: 5
               "10011111" WHEN "101",  -- 5: 1
               "01001001" WHEN "110",  -- 6: 5
               "10011111" WHEN "111",  -- 7: 1
               "11111111" WHEN OTHERS;
END BEAS;