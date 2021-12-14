library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity musicbox is
    Port ( clk : in  STD_LOGIC;   -- system clock (50 MHz)
        BTN0 : in STD_LOGIC; -- start button
            dac_MCLK : out  STD_LOGIC;  -- outputs to PMODI2L DAC
            dac_LRCK : out  STD_LOGIC;
            dac_SCLK : out  STD_LOGIC;
            dac_SDIN : out  STD_LOGIC;
            fullnote: out STD_LOGIC_VECTOR(5 downto 0)
            );
end musicbox;

architecture Behavioral of musicbox is
component dac_if is
    Port ( SCLK : in  STD_LOGIC;
        L_start: in STD_LOGIC;
        R_start: in STD_LOGIC;
           L_data : in signed (15 downto 0);
           R_data : in signed (15 downto 0);
           SDATA : out  STD_LOGIC
           );
end component;

component divide_by12 is
    Port(
   quotient : IN std_logic_vector (2 downto 0) ;
	remainder: IN std_logic_vector(3 downto 0)
	);
	end component;

signal data_L, data_R: SIGNED (15 downto 0);  -- 16-bit signed audio data
signal dac_load_L, dac_load_R: STD_LOGIC;  -- timing pulses to load DAC shift reg.
signal slo_clk, sclk, audio_CLK: STD_LOGIC; 


signal tone: std_logic_vector (30 downto 0);
signal fullnote: std_logic_vector (7 downto 0);
signal octave: std_logic_vector (2 downto 0);
signal note:std_logic_vector (3 downto 0);
signal clkdivider:std_logic_vector (8 downto 0);
signal counter_note: std_logic_vector(8 downto 0);    
signal counter_octave: std_logic_vector(7 downto 0);    

begin 
    tone_calc: process
        begin
        wait until rising_edge(clk);
            tone <= std_logic_vector(to_unsigned(to_integer(unsigned(tone))+1,31));
    end process;
    
    clk_divide: process   --This process defines the frequency values of each note
        begin
        wait on note;
            case note is
                when "0" => clkdivider <=std_logic_vector(to_unsigned(511,9)); --A
                when "1" => clkdivider <=std_logic_vector(to_unsigned(482,9)); --A#/Bb
                when "2" => clkdivider <=std_logic_vector(to_unsigned(455,9)); --B
                when "3" => clkdivider <=std_logic_vector(to_unsigned(430,9));  --C
                when "4" => clkdivider <=std_logic_vector(to_unsigned(405,9)); --C#/Db
                when "5" => clkdivider <=std_logic_vector(to_unsigned(383,9)); --D
                when "6" => clkdivider <=std_logic_vector(to_unsigned(361,9)); --D#/Eb
                when "7" => clkdivider <=std_logic_vector(to_unsigned(341,9)); --E
                when "8" => clkdivider <=std_logic_vector(to_unsigned(322,9)); --F
                when "9" => clkdivider <=std_logic_vector(to_unsigned(303,9)); --F#/Gb
                when "10" => clkdivider <=std_logic_vector(to_unsigned(286,9)); --G
                when "11" => clkdivider <=std_logic_vector(to_unsigned(270,9)); --G#/Ab
                when others => clkdivider <=std_logic_vector(to_unsigned(0,9));            
            end case;
    
    end process;
    
    counter_note_calc:process
        begin
         wait until rising_edge(clk);
         if(unsigned(counter_note)=0)then  
            counter_note <= clkdivider;       
         else
            counter_note <= std_logic_vector(to_integer(unsigned(counter_note))-1);
         end if;
     end process;
    
    counter_octave_calc:process
        begin
            wait until rising_edge(clk);
            if (unsigned(counter_note)=0) then
                    if (unsigned(counter_octave)=0)  then
                        if (unsigned(octave)=0)then
                            counter_octave <=std_logic_vector(to_unsigned(255,8));
                        elsif (unsigned(octave)=1)then
                            counter_octave <=std_logic_vector(to_unsigned(127,8));
                        elsif (unsigned(octave)=2)then
                            counter_octave <=std_logic_vector(to_unsigned(63,8));
                        elsif (unsigned(octave)=3)then
                            counter_octave <=std_logic_vector(to_unsigned(31,8));
                        elsif (unsigned(octave)=4)then
                            counter_octave <=std_logic_vector(to_unsigned(15,8));
                        else 
                            counter_octave <=std_logic_vector(to_unsigned(7,8));
                        end if;
                    end if;  
            end if;                   
    end process;
    
--The speaker output is yet to be implemented
--    speaker_out:process
--        begin
--            wait until rising_edge(clk);
--                if (unsigned(counter_note)=0 and unsigned(counter_octave)=0 and unsigned(tone)/=0 and unsigned(tone(21 downto 18)) /= 0
--                    then speaker <= ~speaker;
--                end process;

end Behavioral;

