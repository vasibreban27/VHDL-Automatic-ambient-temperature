----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2024 04:40:26 PM
-- Design Name: 
-- Module Name: Numarator_MUX - Behavioral
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

entity Numarator_MUX is
    Port ( clk,rst,en : in STD_LOGIC;
           out_mux : out STD_LOGIC_VECTOR (1 downto 0);
           carry: out  std_logic);
end Numarator_MUX;

architecture Behavioral of Numarator_MUX is
signal counter_reg : std_logic_vector(1 downto 0) := "11";
signal t:std_logic:='0';
begin
process(clk,rst,en)
begin
   if rst ='1' then 
       counter_reg <= "00";
    elsif rising_edge(clk)and en='1' then 
           if counter_reg="11" then counter_reg <= "00";
                                     t <='1';
                                  else
                                      counter_reg <= counter_reg +1;
                                      t <= '0';
                                  end if;
             end if;  
end process;
  out_mux <= counter_reg;
  carry <= t;
end Behavioral;
