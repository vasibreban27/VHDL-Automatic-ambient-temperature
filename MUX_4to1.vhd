----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2024 04:58:19 PM
-- Design Name: 
-- Module Name: MUX_4to1 - Behavioral
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

entity MUX_4to1 is
     port(
            en :in std_logic;
            in1 :in std_logic_vector(3 downto 0);
            in2 :in std_logic_vector(3 downto 0);
            in3 :in std_logic_vector(3 downto 0);
            in4 :in std_logic_vector(3 downto 0);
            out_mux: out std_logic_vector(3 downto 0);
            sel : in std_logic_vector(1 downto 0)
     );
end MUX_4to1;

architecture Behavioral of MUX_4to1 is
signal aux:std_logic_vector(3 downto 0);
begin
process(en,sel)
begin
if en='1' then
    case sel is
        when "00" => aux<=in1;
        when "01" => aux<=in2;
        when "10" => aux<=in3;
        when others =>aux<="1111";
     end case;
  end if;
 end process;
 out_mux <= aux;

end Behavioral;
