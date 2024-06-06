----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2024 05:53:34 PM
-- Design Name: 
-- Module Name: Generator_Temp - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Generator_Temp is
   generic(n:natural :=4);
   port(
        mode,rst,clk : in std_logic;
        carry: out std_logic;
        output: out std_logic_vector(n-1 downto 0)
   );
end Generator_Temp;

architecture Behavioral of Generator_Temp is
signal aux1:std_logic_vector(n-1 downto 0):="0001";
signal ser:std_logic:='0';
signal x:std_logic :='1';
signal y:std_logic :='1';

begin
process(clk,mode,rst)
begin
        if rst='1' then aux1<="0001";
        elsif mode='1' and rising_edge(clk) then
           ser <= aux1(n-1) xor aux1(0);  --ser ia valoarea xor dintre primul si ultimul bit
           aux1 <= aux1(n-2 downto 0) & ser;  --se shifteaza la dreapta cu 2 pozitii si se concateneaza cu ser
           x <= aux1(n-3);  --x ia valoarea lui aux(1)
           y <= aux1(n-4);  --y ia valoarea lui aux(0)
           aux1(n-2) <= not(aux1(n-2))and x; --se seteaza bitii din mijloc
           aux1(n-3) <= not(aux1(n-3))and y;
           end if;
end process;
output <= aux1; 
end Behavioral;
