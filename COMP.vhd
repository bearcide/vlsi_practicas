LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY COMP IS
    PORT(CLK  : IN  STD_LOGIC;
         CONT : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);  -- 0-9
         CT   : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);  -- Switches
         PWM  : OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE BEAS OF COMP IS
    SIGNAL THRESHOLD : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
    -- Mapeo de porcentajes:
    -- CT=000 (0) -> TH=0  (0%)
    -- CT=001 (1) -> TH=2  (20%)
    -- CT=010 (2) -> TH=4  (40%)
    -- CT=011 (3) -> TH=6  (60%)
    -- CT=100 (4) -> TH=8  (80%)
    -- CT=101 (5) -> TH=10 (100%) - Nota: 10 en binario es "1010"
    
    THRESHOLD <= CT(2 DOWNTO 0) & '0'; -- Multiplica CT por 2 desplazando bits

    PROCESS(CLK)
    BEGIN
        IF RISING_EDGE(CLK) THEN
            -- Si el contador es menor al umbral, la señal está en ALTO
            IF CONT < THRESHOLD THEN
                PWM <= '1';
            ELSE
                PWM <= '0';
            END IF;
        END IF;
    END PROCESS;
END BEAS;