----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/09/2024 07:40:54 PM
-- Design Name: 
-- Module Name: Numarator_0to2 - Behavioral
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

entity Numarator_0to2 is
    Port ( clk,rst,en,load : in STD_LOGIC;
           in_0to2: in std_logic_vector(3 downto 0);
           out_0to2 : out STD_LOGIC_VECTOR (3 downto 0);
           carry: out  std_logic);
end Numarator_0to2;

architecture Behavioral of Numarator_0to2 is
signal counter_reg : std_logic_vector(3 downto 0) := "0000";
signal t:std_logic:='0';
begin
process(clk,rst,en,load)
begin
   if rst ='1' then 
       counter_reg <= "0000";
    elsif rising_edge(clk) then 
            if load='1' then counter_reg <= in_0to2;
            elsif load='0' and en='1' then 
            if counter_reg="0010" then counter_reg <="0000";
                                      t <= '1';
                                  else
                                      counter_reg <= counter_reg +1;
                                      t <= '0';
                                  end if;
             end if;
          end if;
            
   
end process;
  out_0to2 <= counter_reg;
  carry <= t;
end Behavioral;