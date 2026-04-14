LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY deco7seg IS
    PORT(
        NUMERO : IN  INTEGER RANGE 0 TO 15;
        SAL    : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE BEAS OF deco7seg IS
BEGIN
    -- SAL(7 downto 0) = a, b, c, d, e, f, g, dp  (anodo comun, 0=encendido)
    -- Segun asignacion de pines:
    -- SAL[7]=a=PIN_C14  SAL[6]=b=PIN_E15  SAL[5]=c=PIN_C15  SAL[4]=d=PIN_C16
    -- SAL[3]=e=PIN_E16  SAL[2]=f=PIN_D17  SAL[1]=g=PIN_C17  SAL[0]=dp=PIN_D15
    WITH NUMERO SELECT
        SAL <= "00000011" WHEN 0,   -- 0: a,b,c,d,e,f ON
               "10011111" WHEN 1,   -- 1: b,c ON
               "00100101" WHEN 2,   -- 2: a,b,d,e,g ON
               "00001101" WHEN 3,   -- 3: a,b,c,d,g ON
               "10011001" WHEN 4,   -- 4: b,c,f,g ON
               "01001001" WHEN 5,   -- 5: a,c,d,f,g ON
               "01000001" WHEN 6,   -- 6: a,c,d,e,f,g ON
               "00011111" WHEN 7,   -- 7: a,b,c ON
               "00000001" WHEN 8,   -- 8: todos ON
               "00001001" WHEN 9,   -- 9: a,b,c,d,f,g ON
               "00010001" WHEN 10,  -- A: a,b,c,e,f,g ON
               "11000001" WHEN 11,  -- b minuscula: c,d,e,f,g ON
               "01100011" WHEN 12,  -- C: a,d,e,f ON
               "10000101" WHEN 13,  -- d minuscula: b,c,d,e,g ON
               "10010001" WHEN 14,  -- H (para #): b,c,e,f,g ON
               "01111111" WHEN OTHERS; -- guion superior (para *)
END BEAS;
