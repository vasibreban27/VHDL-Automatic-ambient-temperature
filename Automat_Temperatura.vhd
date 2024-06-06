----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2024 06:33:39 PM
-- Design Name: 
-- Module Name: Automat_Temperatura - Behavioral
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

entity Automat_Temperatura is
   port(
        start: in std_logic; -- echivalent cu load la mine
        clk: in std_logic;
        rst: in std_logic;
        MinU: in std_logic_vector(3 downto 0);
        MinZ: in std_logic_vector(3 downto 0);
        OraU: in std_logic_vector(3 downto 0);
        OraZ: in std_logic_vector(3 downto 0);
        ZiU: in std_logic_vector(3 downto 0);
        ZiZ: in std_logic_vector(3 downto 0);
        LunaU: in std_logic_vector(3 downto 0);
        LunaZ: in std_logic_vector(3 downto 0);
        BCD1: out std_logic_vector(0 to 6);
        BCD2: out std_logic_vector(0 to 6);
        BCD3: out std_logic_vector(0 to 6);
        BCD4: out std_logic_vector(0 to 6)  
   );
end Automat_Temperatura;

architecture Behavioral of Automat_Temperatura is
--Numarator minute 0->59
component Numarator_0to5 is
    Port ( clk,rst,en,load : in STD_LOGIC;
           in_0to5: in std_logic_vector(3 downto 0);
           out_0to5 : out STD_LOGIC_VECTOR (3 downto 0);
           carry: out  std_logic);
end component;

component Numarator_0to9 is
    Port ( clk,rst,en,load : in STD_LOGIC;
           in_0to9: in std_logic_vector(3 downto 0);
           out_0to9 : out STD_LOGIC_VECTOR (3 downto 0);
           carry: out  std_logic);
end component;

--Numarator ore 0->23
component Numarator_0to2 is
    Port ( clk,rst,en,load : in STD_LOGIC;
           in_0to2: in std_logic_vector(3 downto 0);
           out_0to2 : out STD_LOGIC_VECTOR (3 downto 0);
           carry: out  std_logic);
end component;

component Numarator_0to4 is
    Port ( clk,rst,en,load : in STD_LOGIC;
           in_0to4: in std_logic_vector(3 downto 0);
           out_0to4 : out STD_LOGIC_VECTOR (3 downto 0);
           carry: out  std_logic;
           se : in std_logic);
end component;

--Numarator zile 0->30
component Numarator_0to3 is
    Port ( clk,rst,en,load : in STD_LOGIC;
           in_0to3: in std_logic_vector(3 downto 0);
           out_0to3 : out STD_LOGIC_VECTOR (3 downto 0);
           carry: out  std_logic);
end component;

component Numarator_9_0 is
    Port ( clk,rst,en,load : in STD_LOGIC;
           in_9_0: in std_logic_vector(3 downto 0);
           out_9_0 : out STD_LOGIC_VECTOR (3 downto 0);
           carry: out  std_logic;
           se : in std_logic);
end component;

--Numarator luni 0->12
component Numarator_0to1 is
    Port ( clk,rst,en,load : in STD_LOGIC;
           in_0to1: in std_logic_vector(3 downto 0);
           out_0to1 : out STD_LOGIC_VECTOR (3 downto 0);
           carry: out  std_logic);
end component;

component Numarator_Luni is
    Port ( clk,rst,en,load : in STD_LOGIC;
           in_luni: in std_logic_vector(3 downto 0);
           out_luni : out STD_LOGIC_VECTOR (3 downto 0);
           carry: out  std_logic;
           se : in std_logic);
end component;

--Numarator pentru selectie MUX
component Numarator_MUX is
    Port ( clk,rst,en : in STD_LOGIC;
           out_mux : out STD_LOGIC_VECTOR (1 downto 0);
           carry: out  std_logic);
end component;

--MUX 4 la 1
component MUX_4to1 is
     port(
            en :in std_logic;
            in1 :in std_logic_vector(3 downto 0);
            in2 :in std_logic_vector(3 downto 0);
            in3 :in std_logic_vector(3 downto 0);
            in4 :in std_logic_vector(3 downto 0);
            out_mux: out std_logic_vector(3 downto 0);
            sel : in std_logic_vector(1 downto 0)
     );
end component;

--BCD(seven segments display)
component BCD is
    port(
            input : in std_logic_vector(3 downto 0);
            output:out std_logic_vector(0 to 6)
    );
end component;

--Generator aleator de numere in intervalul 0-9
component Generator_Temp is
   generic(n:natural :=4);
   port(
        mode,rst,clk : in std_logic;
        carry:out std_logic;
        output: out std_logic_vector(n-1 downto 0)
   );
end component;

signal Sel: std_logic_vector(1 downto 0):="00";
signal C_Mu,C_Mz,C_Ou,C_Oz,C_Zu,C_Zz,C_Lu,C_Lz,C_mux,C_G1,C_G2,C_nr,GG:std_logic :='0';
signal E_ou1,E_z,E_l:std_logic :='0';
signal I_Mu,I_Mz,I_Ou1,I_Ou2,I_Ou,I_Oz,I_Zu1,I_Zu,I_Zz,I_Lu1,I_Lu2,I_Lu,I_Lz,I_G1,I_G2,I_BCD1,I_BCD2,I_BCD3,I_BCD4:std_logic_vector(3 downto 0):="0000";
begin

--numarare minute
U_Min_u: Numarator_0to9 port map(clk=>clk,rst=>rst,en=>'1',load=>start,in_0to9=>MinU,out_0to9=>I_Mu,carry=>C_Mu);
U_Min_z: Numarator_0to5 port map(clk=>clk,rst=>rst,en=>C_Mu,load=>start,in_0to5=>MinZ,out_0to5=>I_Mz,carry=>C_Mz); --carry de la unitati va fi enable pt numarator zeci

--numarare ore
E_ou1 <= C_Mu and C_Mz;
U_Ore_z: Numarator_0to2 port map(clk=>clk,rst=>rst,en=>C_Ou,load=>start,in_0to2=>OraZ,out_0to2=>I_Oz,carry=>C_Oz);
U_Ore_u: Numarator_0to4 port map(clk=>clk,rst=>rst,en=>C_Oz,load=>start,in_0to4=>OraU,out_0to4=>I_Ou,carry=>C_Ou,se=>C_Oz);

E_z <= C_Oz and C_Ou and E_ou1;  --daca ajung la 24,se pune enable-ul de la zile pe 1
U_Zile_u:Numarator_9_0 port map(clk=>clk,rst=>rst,en=>E_z,load=>start,in_9_0=>ZiU,out_9_0=>I_Zu,carry=>C_Zu,se=>C_Zz);
U_Zile_z:Numarator_0to3 port map(clk=>clk,rst=>rst,en=>C_Zu,load=>start,in_0to3=>ZiZ,out_0to3=>I_Zz,carry=>C_Zz);

E_l<= C_Zu and C_Zz  and E_z;
U_Luna_u:Numarator_Luni port map(clk=>clk,rst=>rst,en=>E_l,load=>start,in_luni=>LunaU,out_luni=>I_Lu,carry=>C_Lu,se=>C_Lz);
U_Luna_z:Numarator_0to1 port map(clk=>clk,rst=>C_Lu,en=>rst,load=>start,in_0to1=>LunaZ,out_0to1=>I_Lz,carry=>C_Lz);

U_Gen1:Generator_Temp port map(mode=>'1',rst=>clk,clk=>rst,carry=>C_G1,output=>I_G1);
U_Gen2:Generator_Temp port map(mode=>GG,rst=>clk,clk=>rst,carry=>C_G2,output=>I_G2);
GG <= not(C_Mu);

U_MUX: Numarator_MUX port map(clk=>clk,rst=>rst,en=>'1',out_mux=>Sel,carry=>C_nr);

U_BCD1:MUX_4to1 port map(en=>'1',in1=>"1111",in2=>I_Oz,in3=>I_Zz,in4=>"1111",out_mux=>I_BCD1,sel=>Sel);
U_BCD2:MUX_4to1 port map(en=>'1',in1=>"1111",in2=>I_Ou,in3=>I_Zu,in4=>"1111",out_mux=>I_BCD2,sel=>Sel);
U_BCD3:MUX_4to1 port map(en=>'1',in1=>I_G1,in2=>I_Mz,in3=>I_Lz,in4=>"1111",out_mux=>I_BCD3,sel=>Sel);
U_BCD4:MUX_4to1 port map(en=>'1',in1=>I_G2,in2=>I_Mu,in3=>I_Lu,in4=>"1111",out_mux=>I_BCD4,sel=>Sel);

U_F1:BCD port map(input=>I_BCD1,output=>BCD1);
U_F2:BCD port map(input=>I_BCD2,output=>BCD2);
U_F3:BCD port map(input=>I_BCD3,output=>BCD3);
U_F4:BCD port map(input=>I_BCD4,output=>BCD4);

end Behavioral;
