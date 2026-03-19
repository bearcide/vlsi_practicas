LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY deco IS
    PORT(ENTRADAS: IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
         SEG: OUT STD_LOGIC_VECTOR(0 TO 7)); -- a-g y punto decimal
END ENTITY;

ARCHITECTURE BEAS OF deco IS
BEGIN 
    WITH ENTRADAS SELECT
        SEG <= "00000011" WHEN "0000", -- 0
               "10011111" WHEN "0001", -- 1
               "00100101" WHEN "0010", -- 2
               "00001101" WHEN "0011", -- 3
               "10011001" WHEN "0100", -- 4
               "01001001" WHEN "0101", -- 5
               "01000001" WHEN "0110", -- 6
               "00011111" WHEN "0111", -- 7
               "00000001" WHEN "1000", -- 8
               "00001001" WHEN "1001", -- 9
               "11111111" WHEN OTHERS; -- Apagado
END BEAS;