--------------------------------------------------------------------
-- sum_cond.vhd
-- Sumador-Comparador Condicional (bloque base del Double Dabble)
--
-- Lógica PURAMENTE COMBINACIONAL:
--      Si A >= 5  ->  B = A + 3
--      Si A <  5  ->  B = A
--
-- - Sin reloj (CLK).
-- - Sin registros, sin máquina de estados, sin cartas ASM.
-- - 4 bits de entrada, 4 bits de salida.
-- - Sin uso de divisiones (/) ni módulos (MOD).
--
-- Este es el ÚNICO bloque que necesitas para el Double Dabble:
-- en el diagrama de bloques (.bdf) de Quartus generas su símbolo
-- (Create Symbol Files for Current File) y lo instancias en cascada
-- las veces que haga falta (ver guía de cableado al final del chat).
--
-- También se usa internamente como componente en
-- bin_to_bcd_12bits.vhd para que tengas la opción de meter una sola
-- caja "ya armada" en el BDF en lugar de cablear toda la cascada.
--------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY sum_cond IS
    PORT(
        A : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        B : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY sum_cond;

ARCHITECTURE comb OF sum_cond IS
BEGIN

    -- Asignación concurrente: el comparador (>=5) selecciona entre
    -- "A + 3" y "A" sin necesidad de proceso, reloj ni latches.
    B <= STD_LOGIC_VECTOR(UNSIGNED(A) + TO_UNSIGNED(3, 4))
         WHEN UNSIGNED(A) >= TO_UNSIGNED(5, 4)
         ELSE A;

END ARCHITECTURE comb;
