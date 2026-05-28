library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity joystick is
    Port (
        Vx, Vy : in std_logic_vector(11 downto 0);  
        U, D, L, RI : out std_logic                 
    );
end joystick;
architecture Behavioral of joystick is
begin
    process(Vx, Vy)
        variable Vx_int : integer;
        variable Vy_int : integer;
    begin
        Vx_int := to_integer(unsigned(Vx));
        Vy_int := to_integer(unsigned(Vy));
        U <= '0'; D <= '0'; L <= '0'; RI <= '0';
        if Vx_int > 3600 and Vy_int > 1800 and Vy_int < 2300 then
            RI <= '1'; 
        elsif Vx_int < 500 and Vy_int > 1800 and Vy_int < 2300 then
            L <= '1'; 
        elsif Vy_int > 3600 and Vx_int > 1800 and Vx_int < 2300 then
            U <= '1'; 
        elsif Vy_int < 500 and Vx_int > 1800 and Vx_int < 2300 then
            D <= '1'; 
        end if;
    end process;
end Behavioral;
