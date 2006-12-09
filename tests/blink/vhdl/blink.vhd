library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.numeric_std.all;

library UNISIM;
use UNISIM.VComponents.all;

entity blink is
  
  port (
    CLK : in std_logic;
    LED1 : out std_logic;
    LED2 : out std_logic;
    BRITE : out std_logic;
    SLEEP : out std_logic
    );

end blink;

architecture Behavioral of blink is
  signal cnt : std_logic_vector(23 downto 0) := (others => '0');
  
                                                 
begin  -- Behavioral

  SLEEP <= '1';
  BRITE <= '1';
  
  main: process (CLK)
    begin
      if rising_edge(CLK) then
        cnt <= cnt + 1;

        LED1 <= cnt(23);
        LED2 <= cnt(22);
        
      end if;

    end process main; 
  

end Behavioral;
