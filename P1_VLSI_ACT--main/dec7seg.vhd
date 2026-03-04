-- dec7seg.vhd - Decodificador Hex a 7 segmentos
-- Logica ACTIVA EN BAJO (DE10-Lite Terasic)
--
--   SEG(0)=a(top)  SEG(1)=b(top-right)   SEG(2)=c(bot-right)
--   SEG(3)=d(bot)  SEG(4)=e(bot-left)    SEG(5)=f(top-left)
--   SEG(6)=g(mid)
--
--  COD | Char | SEG[6543210] gfedcba
--   0  |  sp  | 1111111  <- espacio / apagado
--  10  |   A  | 0001000
--  11  |   b  | 0000011
--  12  |   C  | 1000110
--  13  |   d  | 0100001
--  14  |   E  | 0000110
--  15  |   F  | 0001110
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY dec7seg IS
    PORT(COD : IN  INTEGER RANGE 0 TO 15;
         SEG : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END ENTITY;

ARCHITECTURE BEAS OF dec7seg IS
BEGIN
    WITH COD SELECT
        SEG <= "1111111" WHEN 0,   -- espacio (apagado)
               "1111001" WHEN 1,   -- 1
               "0100100" WHEN 2,   -- 2
               "0110000" WHEN 3,   -- 3
               "0011001" WHEN 4,   -- 4
               "0010010" WHEN 5,   -- 5
               "0000010" WHEN 6,   -- 6
               "1111000" WHEN 7,   -- 7
               "0000000" WHEN 8,   -- 8
               "0010000" WHEN 9,   -- 9
               "0001000" WHEN 10,  -- A
               "0000011" WHEN 11,  -- b
               "1000110" WHEN 12,  -- C
               "0100001" WHEN 13,  -- d
               "0000110" WHEN 14,  -- E
               "0001110" WHEN 15,  -- F
               "1111111" WHEN OTHERS; -- apagado
END BEAS;
