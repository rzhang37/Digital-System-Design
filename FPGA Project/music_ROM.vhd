library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity music_ROM is 
    Port(clk : in  STD_LOGIC;  -- system clock (50 MHz)
        address:in STD_LOGIC_VECTOR(7 downto 0);
        note: out STD_LOGIC_VECTOR(7 downto 0)
    );
end music_ROM;
ARCHITECTURE Behavioral OF music_ROM is
begin
    process
    begin
        wait until rising_edge(clk);
            case address is
            --Here are a few notes from the original Verilog file
            when "0"=>note <=std_logic_vector(to_unsigned(25,8));
            when "1"=>note <=std_logic_vector(to_unsigned(23,8));
  
            end case;
    end process;
        
        
end Behavioral;