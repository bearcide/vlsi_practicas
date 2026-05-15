--------------------------------------------------------------------
-- bin_to_bcd_12bits.vhd
-- Convertidor BINARIO (12 bits) -> BCD (4 dígitos)
-- Algoritmo: Double Dabble  ("Shift and Add 3")
--
-- Pura lógica combinacional:
--   * No hay reloj en la lista de sensibilidad.
--   * No hay registros, contadores ni FSM.
--   * No se usan divisiones (/) ni MOD.
--
-- Entrada:   bin_in   --  vector 12 bits  (0 .. 4095)  desde el ADC
-- Salidas:   miles, centenas, decenas, unidades  --  4 bits c/u
--
-- ¿Cómo se sintetiza?
--   El bucle FOR se desenrolla en 12 etapas combinacionales en
--   cascada. Cada etapa contiene hasta 4 instancias del bloque
--   "sumar 3 si >= 5" (idéntico a sum_cond) seguidas por un
--   corrimiento cableado a la izquierda. El sintetizador de
--   Quartus optimiza y elimina los comparadores cuyos dígitos
--   aún son cero, dejando una red puramente combinacional.
--
-- Úsalo de cualquiera de las dos formas:
--   (a) Generar símbolo de sum_cond y cablear la cascada a mano en
--       tu .bdf (estilo que pidió el profesor), o
--   (b) Generar símbolo de bin_to_bcd_12bits y meter una sola caja
--       que ya hace todo (más rápido para entregar).
--------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY bin_to_bcd_12bits IS
    PORT(
        bin_in   : IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
        miles    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        centenas : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        decenas  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        unidades : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY bin_to_bcd_12bits;

ARCHITECTURE comb OF bin_to_bcd_12bits IS
BEGIN

    -- Process combinacional: solo bin_in en la sensibilidad y todas
    -- las variables se ESCRIBEN antes de leerse en cada ejecución,
    -- por lo que Quartus NO infiere latches ni flip-flops.
    PROCESS(bin_in)
        VARIABLE bcd : UNSIGNED(15 DOWNTO 0);  -- 4 dígitos BCD
    BEGIN
        bcd := (OTHERS => '0');

        -- Recorremos los 12 bits del MSB al LSB.
        -- Cada iteración = una etapa de la cascada combinacional.
        FOR i IN 11 DOWNTO 0 LOOP

            -- ---- Corrección "+3 si >= 5" sobre cada dígito BCD ----
            -- (Equivale a 4 instancias paralelas de sum_cond.)
            IF bcd(3 DOWNTO 0) >= 5 THEN
                bcd(3 DOWNTO 0) := bcd(3 DOWNTO 0) + 3;
            END IF;
            IF bcd(7 DOWNTO 4) >= 5 THEN
                bcd(7 DOWNTO 4) := bcd(7 DOWNTO 4) + 3;
            END IF;
            IF bcd(11 DOWNTO 8) >= 5 THEN
                bcd(11 DOWNTO 8) := bcd(11 DOWNTO 8) + 3;
            END IF;
            IF bcd(15 DOWNTO 12) >= 5 THEN
                bcd(15 DOWNTO 12) := bcd(15 DOWNTO 12) + 3;
            END IF;

            -- ---- Corrimiento a la izquierda + bit nuevo en LSB ----
            bcd := bcd(14 DOWNTO 0) & bin_in(i);

        END LOOP;

        -- Salidas (puramente cableadas a la variable final)
        unidades <= STD_LOGIC_VECTOR(bcd( 3 DOWNTO  0));
        decenas  <= STD_LOGIC_VECTOR(bcd( 7 DOWNTO  4));
        centenas <= STD_LOGIC_VECTOR(bcd(11 DOWNTO  8));
        miles    <= STD_LOGIC_VECTOR(bcd(15 DOWNTO 12));

    END PROCESS;

END ARCHITECTURE comb;
