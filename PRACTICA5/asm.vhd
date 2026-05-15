LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY asm IS
    PORT(INC, DEC, CLK: IN STD_LOGIC;
         CUENTA: BUFFER INTEGER RANGE 0 TO 4 := 0);
END ENTITY;

ARCHITECTURE BEAS OF asm IS
    -- Usaremos señales para detectar el flanco
    SIGNAL reg_inc, reg_dec : STD_LOGIC_VECTOR(2 DOWNTO 0) := "111";
    SIGNAL presionado : STD_LOGIC := '0';
    SIGNAL contador_bloqueo : INTEGER RANGE 0 TO 100 := 0; 
BEGIN

    PROCESS(CLK) -- Este CLK debe ser el de 50 MHz para máxima respuesta
    BEGIN
        IF RISING_EDGE(CLK) THEN
            -- Desplazamiento para sincronizar
            reg_inc <= reg_inc(1 DOWNTO 0) & INC;
            reg_dec <= reg_dec(1 DOWNTO 0) & DEC;

            -- Lógica de disparo
            IF presionado = '0' THEN
                -- Si detectamos el flanco de bajada (110)
                IF reg_inc = "110" THEN
                    IF CUENTA < 4 THEN CUENTA <= CUENTA + 1; END IF;
                    presionado <= '1'; -- Bloqueamos nuevas cuentas
                ELSIF reg_dec = "110" THEN
                    IF CUENTA > 0 THEN CUENTA <= CUENTA - 1; END IF;
                    presionado <= '1';
                END IF;
            ELSE
                -- ESPERA ACTIVA: Solo dejamos de estar "presionados" 
                -- cuando AMBOS botones regresen a '1' (sueltos)
                IF reg_inc = "111" AND reg_dec = "111" THEN
                    presionado <= '0';
                END IF;
            END IF;
        END IF;
    END PROCESS;

END BEAS;