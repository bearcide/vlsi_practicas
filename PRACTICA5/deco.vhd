LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL; 
 
ENTITY deco IS  
    PORT(NUM: IN CHARACTER; -- Cambiado de INTEGER a CHARACTER
         SAL  : OUT STD_LOGIC_VECTOR(0 TO 7)); 
END ENTITY; 
 
ARCHITECTURE BEAS OF deco IS  
BEGIN 
    -- Lógica: '0' enciende, '1' apaga. 
    -- Bits: (0)=a, (1)=b, (2)=c, (3)=d, (4)=e, (5)=f, (6)=g, (7)=DP 
    WITH NUM SELECT 
        SAL <= "00010001" WHEN 'A', -- A
               "11000001" WHEN 'B', -- b (minúscula para distinguir)
               "01100011" WHEN 'C', -- C
               "10000101" WHEN 'D', -- d (minúscula para distinguir)
               "01100001" WHEN 'E', -- E
               "11111111" WHEN OTHERS; 
END BEAS;