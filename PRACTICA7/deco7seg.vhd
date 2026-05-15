--------------------------------------------------------------------
-- deco7seg.vhd
-- Decodificador BCD -> 7 Segmentos para Terasic DE10-Lite
--
-- Versión "limpia" de repaso.vhd:
--   * Se eliminó la salida DIG (era para displays multiplexados).
--   * La entrada ahora es STD_LOGIC_VECTOR(3 DOWNTO 0) para conectarse
--     directamente al bus de 4 bits que entrega cada dígito del
--     convertidor binario->BCD.
--   * Las salidas operan en LÓGICA NEGADA: '0' enciende, '1' apaga.
--
-- Mapeo de los 8 bits de SAL (mismo orden que repaso.vhd original):
--     SAL(7)=A  SAL(6)=B  SAL(5)=C  SAL(4)=D
--     SAL(3)=E  SAL(2)=F  SAL(1)=G  SAL(0)=DP
--
-- NOTA: la plantilla por defecto de la DE10-Lite usa el orden
-- contrario en su .qsf (HEX0[0]=a, HEX0[6]=g, HEX0[7]=DP). Verifica
-- tu asignación de pines en Quartus; si usas la plantilla oficial,
-- asigna cada bit de SAL al pin correspondiente para que coincida
-- con el patrón de arriba.
--------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY deco7seg IS
    PORT(
        BCD : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);   -- dígito decimal 0-9
        SAL : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)    -- 7 segmentos + DP
    );
END ENTITY deco7seg;

ARCHITECTURE comb OF deco7seg IS
    signal seg_internal : std_logic_vector(6 downto 0);  -- A B C D E F G
BEGIN
    -- Decodificación normal (activo bajo)
    WITH BCD SELECT
        seg_internal <= "1000000" WHEN "0000",  -- 0
                        "1111001" WHEN "0001",  -- 1
                        "0100100" WHEN "0010",  -- 2
                        "0110000" WHEN "0011",  -- 3
                        "0011001" WHEN "0100",  -- 4
                        "0010010" WHEN "0101",  -- 5
                        "0000010" WHEN "0110",  -- 6
                        "1111000" WHEN "0111",  -- 7
                        "0000000" WHEN "1000",  -- 8
                        "0010000" WHEN "1001",  -- 9
                        "1111111" WHEN OTHERS;
    
    -- Reordenar: SAL(7)=DP, SAL(6)=G, SAL(5)=F, SAL(4)=E, SAL(3)=D, SAL(2)=C, SAL(1)=B, SAL(0)=A
    SAL(0) <= seg_internal(0);  -- A
    SAL(1) <= seg_internal(1);  -- B
    SAL(2) <= seg_internal(2);  -- C
    SAL(3) <= seg_internal(3);  -- D
    SAL(4) <= seg_internal(4);  -- E
    SAL(5) <= seg_internal(5);  -- F
    SAL(6) <= seg_internal(6);  -- G
    SAL(7) <= '1';              -- DP siempre apagado

END ARCHITECTURE comb;
