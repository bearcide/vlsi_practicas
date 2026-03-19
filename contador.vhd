LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY contador IS
    PORT(CLK, RST: IN STD_LOGIC;
         CUENTA: BUFFER STD_LOGIC_VECTOR(2 DOWNTO 0));  -- 3 bits para que coincida con COMP
END ENTITY;

ARCHITECTURE BEAS OF contador IS
BEGIN 
    PROCESS(CLK, RST)
    BEGIN
        IF RST = '1' THEN
            CUENTA <= "000";  -- Reset a 0
        ELSIF RISING_EDGE(CLK) THEN
            IF CUENTA = "100" THEN  -- Cuando llega a 4 (100 en binario)
                CUENTA <= "000";     -- Reinicia a 0
            ELSE
                CUENTA <= CUENTA + 1;  -- Incrementa
            END IF;
        END IF;
    END PROCESS;
END BEAS;