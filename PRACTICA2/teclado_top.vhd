LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY teclado_top IS
    PORT(
        CLK : IN  STD_LOGIC;
        FIL : IN  STD_LOGIC_VECTOR(0 TO 3);
        COL : OUT STD_LOGIC_VECTOR(0 TO 3);
        SAL : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END teclado_top;

ARCHITECTURE BEAS OF teclado_top IS

    COMPONENT divisor
        GENERIC(FREC : INTEGER := 2499);
        PORT(CLK : IN STD_LOGIC; CLK_MST : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT conta
        PORT(CLK   : IN  STD_LOGIC;
             HAB   : IN  STD_LOGIC;
             CUENTA: OUT STD_LOGIC_VECTOR(0 TO 3));
    END COMPONENT;

    COMPONENT colraw
        PORT(CUENTA : IN  STD_LOGIC_VECTOR(0 TO 3);
             FIL    : IN  STD_LOGIC_VECTOR(0 TO 3);
             COL    : OUT STD_LOGIC_VECTOR(0 TO 3);
             HAB    : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT decotecla
        PORT(CUENTA : IN  STD_LOGIC_VECTOR(0 TO 3);
             TECLA  : OUT INTEGER RANGE 0 TO 15);
    END COMPONENT;

    COMPONENT deco7seg
        PORT(NUMERO : IN  INTEGER RANGE 0 TO 15;
             SAL    : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
    END COMPONENT;

    SIGNAL clk_slow  : STD_LOGIC;
    SIGNAL cuenta    : STD_LOGIC_VECTOR(0 TO 3);
    SIGNAL hab       : STD_LOGIC;
    SIGNAL tecla_now : INTEGER RANGE 0 TO 15;
    SIGNAL tecla_reg : INTEGER RANGE 0 TO 15 := 0;

BEGIN
    inst5 : divisor
        GENERIC MAP(FREC => 2499)
        PORT MAP(CLK => CLK, CLK_MST => clk_slow);

    -- HAB ya no congela el contador, se pasa '0' siempre
    inst4 : conta
        PORT MAP(CLK => clk_slow, HAB => '0', CUENTA => cuenta);

    inst1 : colraw
        PORT MAP(CUENTA => cuenta, FIL => FIL, COL => COL, HAB => hab);

    inst7 : decotecla
        PORT MAP(CUENTA => cuenta, TECLA => tecla_now);

    -- Registro: solo actualiza el display cuando HAB='1' (tecla detectada)
    PROCESS(clk_slow)
    BEGIN
        IF FALLING_EDGE(clk_slow) THEN
            IF hab = '1' THEN
                tecla_reg <= tecla_now;
            END IF;
        END IF;
    END PROCESS;

    inst8 : deco7seg
        PORT MAP(NUMERO => tecla_reg, SAL => SAL);

END BEAS;
