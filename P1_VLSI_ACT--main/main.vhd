LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY main IS
    PORT(CLK_50MHz : IN  STD_LOGIC;
         RST       : IN  STD_LOGIC;
         HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END ENTITY;

ARCHITECTURE estructural OF main IS

    COMPONENT divf
        GENERIC(FREC: INTEGER := 24999999);
        PORT(CLK_MST: IN STD_LOGIC; CLK: BUFFER STD_LOGIC);
    END COMPONENT;

    COMPONENT conta_rst
        PORT(CLK, RST, ENB: IN STD_LOGIC;
             CARRY: OUT STD_LOGIC;
             COUNT: BUFFER INTEGER RANGE 0 TO 15);
    END COMPONENT;

    COMPONENT conta2
        PORT(CLK, RST, HAB: IN STD_LOGIC;
             SEL: BUFFER INTEGER RANGE 0 TO 2);
    END COMPONENT;

    COMPONENT rom1
        PORT(DIR: IN INTEGER RANGE 0 TO 15; SAL: OUT INTEGER RANGE 0 TO 15);
    END COMPONENT;

    COMPONENT rom2
        PORT(DIR: IN INTEGER RANGE 0 TO 15; SAL: OUT INTEGER RANGE 0 TO 15);
    END COMPONENT;

    COMPONENT rom3
        PORT(DIR: IN INTEGER RANGE 0 TO 15; SAL: OUT INTEGER RANGE 0 TO 15);
    END COMPONENT;

    COMPONENT mux3a1
        PORT(P1, P2, P3: IN INTEGER RANGE 0 TO 15;
             SEL: IN INTEGER RANGE 0 TO 2;
             SALIDA: OUT INTEGER RANGE 0 TO 15);
    END COMPONENT;

    COMPONENT reg_des
        PORT(ENTRADA: IN INTEGER RANGE 0 TO 15;
             CLK, RST: IN STD_LOGIC;
             Q0, Q1, Q2, Q3, Q4, Q5: BUFFER INTEGER RANGE 0 TO 15);
    END COMPONENT;

    COMPONENT dec7seg
        PORT(COD: IN INTEGER RANGE 0 TO 15;
             SEG: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
    END COMPONENT;

    -- Senales internas
    SIGNAL clk_1hz                  : STD_LOGIC;
    SIGNAL cuenta                   : INTEGER RANGE 0 TO 15;
    SIGNAL carry                    : STD_LOGIC;
    SIGNAL sel_pal                  : INTEGER RANGE 0 TO 2;
    SIGNAL p1, p2, p3               : INTEGER RANGE 0 TO 15;
    SIGNAL letra_mux                : INTEGER RANGE 0 TO 15;
    SIGNAL q0s,q1s,q2s,q3s,q4s,q5s : INTEGER RANGE 0 TO 15;

BEGIN
    -- BUG FIX: GENERIC MAP explicito para que el FREC de divf.vhd sea el correcto
    U1: divf      GENERIC MAP(FREC => 24999999)
                  PORT MAP(CLK_50MHz, clk_1hz);

    U2: conta_rst PORT MAP(clk_1hz, RST, '1', carry, cuenta);
    U3: conta2    PORT MAP(clk_1hz, RST, carry, sel_pal);
    U4: rom1      PORT MAP(cuenta, p1);
    U5: rom2      PORT MAP(cuenta, p2);
    U6: rom3      PORT MAP(cuenta, p3);
    U7: mux3a1    PORT MAP(p1, p2, p3, sel_pal, letra_mux);
    U8: reg_des   PORT MAP(letra_mux, clk_1hz, RST,
                           q0s, q1s, q2s, q3s, q4s, q5s);

    -- Un decodificador por cada display
    D0: dec7seg   PORT MAP(q0s, HEX0);
    D1: dec7seg   PORT MAP(q1s, HEX1);
    D2: dec7seg   PORT MAP(q2s, HEX2);
    D3: dec7seg   PORT MAP(q3s, HEX3);
    D4: dec7seg   PORT MAP(q4s, HEX4);
    D5: dec7seg   PORT MAP(q5s, HEX5);

END estructural;
