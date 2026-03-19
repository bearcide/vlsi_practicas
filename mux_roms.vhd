LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux_roms IS
    PORT(
        SEL      : IN  STD_LOGIC;
        ROM_A    : IN  STD_LOGIC_VECTOR(0 TO 7); 
        ROM_B    : IN  STD_LOGIC_VECTOR(0 TO 7); 
        SEG_OUT  : OUT STD_LOGIC_VECTOR(0 TO 7)  
    );
END ENTITY;

ARCHITECTURE BEAS OF mux_roms IS
BEGIN 
    WITH SEL SELECT
        SEG_OUT <= ROM_A WHEN '0',
                   ROM_B WHEN '1',
                   "11111111" WHEN OTHERS;
                  
END BEAS;