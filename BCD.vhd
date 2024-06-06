----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2024 05:24:05 PM
-- Design Name: 
-- Module Name: BCD - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BCD is
    port(
            input : in std_logic_vector(3 downto 0);
            output:out std_logic_vector(0 to 6)
    );
end BCD;

architecture Behavioral of BCD is

begin
process(input)
begin
    case input is
        when "0000" =>output<="0000001";
        when "0001" =>output<="1001111";
        when "0010" =>output<="0010010";
        when "0011" =>output<="0000110";
        when "0100" =>output<="1001100";
        when "0101" =>output<="0100100";
        when "0110" =>output<="0100000";
        when "0111" =>output<="0001111";
        when "1000" =>output<="0000000";
        when "1001" =>output<="0001100";
        when others =>output<="1111111";
     end case;
end process;
end Behavioral;
