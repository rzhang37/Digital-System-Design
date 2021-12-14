LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY divide_by12 IS
	PORT (
		clk : IN STD_LOGIC; 
	numerator: IN std_logic_vector(5 downto 0);
	quotient : OUT std_logic_vector (2 downto 0) ;
	remainder: OUT std_logic_vector(3 downto 0)
	);
END divide_by12;

ARCHITECTURE Behavioral OF divide_by12 is
signal remainder3to2: std_logic_vector (1 downto 0);
begin
    process
    begin 
    wait on numerator(5 downto 2);
        case numerator(5 downto 2) is
            when "0"=> quotient<="0"; remainder3to2<="0";
            when "1"=> quotient<="0"; remainder3to2<="1";
            when "2"=> quotient<="0"; remainder3to2<="2";
            when "3"=> quotient<="1"; remainder3to2<="0";
            when "4"=> quotient<="1"; remainder3to2<="1";
            when "5"=> quotient<="1"; remainder3to2<="2";
            when "6"=> quotient<="2"; remainder3to2<="0";
            when "7"=> quotient<="2"; remainder3to2<="1";
            when "8"=> quotient<="2"; remainder3to2<="2";
            when "9"=> quotient<="3"; remainder3to2<="0";
            when "10"=> quotient<="3"; remainder3to2<="1";
            when "11"=> quotient<="3"; remainder3to2<="2";
            when "12"=> quotient<="4"; remainder3to2<="0";
            when "13"=> quotient<="4"; remainder3to2<="1";
            when "14"=> quotient<="4"; remainder3to2<="2";
            when "15"=> quotient<="5"; remainder3to2<="0";
        end case;
        remainder(1 downto 0) <= numerator(1 downto 0); --first two bits are copied through
        remainder(3 downto 2) <=remainder3to2; -- the last two bits come from the case statement
    end process;

end Behavioral;
