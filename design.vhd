library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity triangular is
port (clk : in std_logic; 
      wave_out : out std_logic_vector(15 downto 0);
      reset :in std_logic
     );
end triangular;

architecture Behavioral of triangular is

signal count,count2 : integer := 0;
signal direction : std_logic := '0';

begin

process(clk,reset)
begin
if(reset = '1') then
    count <= 16383;
    count2 <= 32767;
elsif(rising_edge(clk)) then
    --"direction" signal determines the direction of counting - up or down
    if(count = 32765) then
        count <= 0;
        if(direction = '0') then
            direction <= '1';
            count2 <= 16382;
        else
            direction <= '0';
            count2 <= 16385;
        end if; 
    else
        count <= count + 1;
    end if;
    if(direction = '0') then
        if(count2 = 32767) then
            count2 <= 0;
        else
            count2 <= count2 + 1; --up counts from 16385 to 32767 and then 0 to 16383
        end if;
    else
        if(count2 = 32767) then
            count2 <= 0;
        else
            count2 <= count2 - 1; --down counts from 16382 to 0 and then 32767 to 16384
        end if;
    end if;
        
end if;
end process;

wave_out <= conv_std_logic_vector(count2,16);

end Behavioral;
