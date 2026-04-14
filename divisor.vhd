-- ============================================================
-- divisor.vhd
-- Divisor de frecuencia para el teclado matricial 4x4
-- DE10-Lite: CLK = 50 MHz
-- FREC = 2499 => CLK_MST ~ 10 kHz (suficiente para escaneo)
-- ============================================================
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY divisor IS
    GENERIC(FREC : INTEGER := 2499);  -- (50MHz / (FREC+1)) / 2
    PORT(
        CLK     : IN  STD_LOGIC;
        CLK_MST : OUT STD_LOGIC
    );
END divisor;

ARCHITECTURE BEAS OF divisor IS
    SIGNAL cuenta_div : INTEGER RANGE 0 TO FREC := 0;
    SIGNAL clk_int    : STD_LOGIC := '0';
BEGIN
    PROCESS(CLK)
    BEGIN
        IF RISING_EDGE(CLK) THEN
            IF cuenta_div = FREC THEN
                cuenta_div <= 0;
                clk_int    <= NOT clk_int;
            ELSE
                cuenta_div <= cuenta_div + 1;
            END IF;
        END IF;
    END PROCESS;

    CLK_MST <= clk_int;
END BEAS;
