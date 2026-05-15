library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_redirect is
    port (
        CLOCK_N14 : in  std_logic;  -- Tu reloj físico (PIN_N14)
        CLOCK_P11 : out std_logic   -- Señal que el ADC espera
    );
end clock_redirect;

architecture Behavioral of clock_redirect is
begin
    -- Simple redirección lógica
    CLOCK_P11 <= CLOCK_N14;
end Behavioral;