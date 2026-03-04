LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY deco IS 
    PORT(
        NUM: IN INTEGER RANGE 0 TO 15;   
        SAL: OUT STD_LOGIC_VECTOR(0 TO 7) -- abcdefg + DP
    );
END ENTITY;

ARCHITECTURE BEAS OF deco IS 
BEGIN
    -- Mapeo para Ánodo Común (0 = Encendido, 1 = Apagado)
    -- El orden del vector es SAL(0) a SAL(7) -> a, b, c, d, e, f, g, DP
    WITH NUM SELECT
        SAL <= "00000011" WHEN 0, -- Numero 0
               "10011111" WHEN 1, -- Numero 1
               "00100101" WHEN 2, -- Numero 2
               "00001101" WHEN 3, -- Numero 3
               "10011001" WHEN 4, -- Numero 4
               "01001001" WHEN 5, -- Numero 5
               "01000001" WHEN 6, -- Numero 6
               "00011111" WHEN 7, -- Numero 7
               "00000001" WHEN 8, -- Numero 8
               "00001001" WHEN 9, -- Numero 9
               "11111111" WHEN OTHERS; -- Apagado (10-15)

END BEAS;