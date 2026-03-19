LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY contador_out_carry IS
    GENERIC(TAMANO_PALABRA: INTEGER := 6); 
    PORT(CLK, RST: IN STD_LOGIC;
         CARRY: OUT STD_LOGIC; 
         CUENTA: BUFFER INTEGER RANGE 0 TO 7); 
END ENTITY;

ARCHITECTURE BEAS OF contador_out_carry IS
BEGIN 
    CARRY <= '1' WHEN CUENTA = TAMANO_PALABRA ELSE '0';

    PROCESS(CLK, RST)
    BEGIN
        IF RISING_EDGE(CLK) THEN
            IF RST = '1' THEN 
                CUENTA <= 0;
            ELSIF CUENTA = TAMANO_PALABRA THEN 
                CUENTA <= 0;
            ELSE 
                CUENTA <= CUENTA + 1;
            END IF;
        END IF;
    END PROCESS;
END BEAS;