LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY pwm IS
    PORT(
        CLK    : IN  STD_LOGIC;               -- Reloj maestro (50MHz)
        VALOR  : IN  INTEGER RANGE 0 TO 4;    -- Viene de tu contador ASM
        PWM_OUT: OUT STD_LOGIC                -- Salida al LED (Pin de un LEDR)
    );
END ENTITY;

ARCHITECTURE BEAS OF pwm IS
    -- Un contador de 0 a 3 para dividir el ciclo en 4 partes (25% cada una)
    -- Usamos 0 a 3 porque el PWM compara contra el valor de referencia
    SIGNAL rampa : INTEGER RANGE 0 TO 3 := 0; 
    
    -- Señal para bajar la velocidad de la rampa (opcional)
    -- Para que el PWM sea de unos 100Hz o más y no parpadee
    SIGNAL clk_pwm : INTEGER RANGE 0 TO 5000 := 0; 
BEGIN

    -- 1. Generador de Rampa (Diente de sierra)
    -- Creamos una frecuencia de PWM cómoda (aprox 2kHz)
    PROCESS(CLK)
    BEGIN
        IF RISING_EDGE(CLK) THEN
            IF clk_pwm = 5000 THEN
                clk_pwm <= 0;
                IF rampa = 3 THEN
                    rampa <= 0;
                ELSE
                    rampa <= rampa + 1;
                END IF;
            ELSE
                clk_pwm <= clk_pwm + 1;
            END IF;
        END IF;
    END PROCESS;

    -- 2. Comparador para generar el Ciclo de Trabajo (Duty Cycle)
    PROCESS(VALOR, rampa)
    BEGIN
        -- Caso especial: 0 es 0% (siempre apagado)
        IF VALOR = 0 THEN
            PWM_OUT <= '0';
        -- Caso especial: 4 es 100% (siempre prendido)
        ELSIF VALOR = 4 THEN
            PWM_OUT <= '1';
        -- Para 1, 2 y 3 (25%, 50%, 75%)
        ELSE
            IF rampa < VALOR THEN
                PWM_OUT <= '1';
            ELSE
                PWM_OUT <= '0';
            END IF;
        END IF;
    END PROCESS;

END BEAS;