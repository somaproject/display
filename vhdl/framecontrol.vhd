library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.numeric_std.all;

library UNISIM;
use UNISIM.VComponents.all;

entity framecontrol is
  port (
    CLK  : in  std_logic;
    FRAMESTART : in std_logic; 
    X    : out std_logic_vector(9 downto 0);
    Y    : out std_logic_vector(8 downto 0);
    DCLK : out std_logic;
    HD   : out std_logic;
    VD   : out std_logic;
    DENA : out std_logic; 
    ROUT : out std_logic_vector(5 downto 0);
    GOUT : out std_logic_vector(5 downto 0);
    BOUT : out std_logic_vector(5 downto 0);
    RIN : in std_logic_vector(5 downto 0);
    GIN : in std_logic_vector(5 downto 0);
    BIN : in std_logic_vector(5 downto 0)    
    );
end framecontrol;

architecture Behavioral of framecontrol is

  signal ldclk : std_logic := '0';

  signal hcnt : integer range 0 to 1023 := 0;
  constant HLEN : integer := 660;
  constant HBP : integer := 10;
  
  signal vcnt : integer range 0 to 511 := 0;
  constant VLEN : integer := 490;

  signal xcnt : std_logic_vector(9 downto 0) := (others => '0');
  signal ldena : std_logic := '0';
  
begin  -- Behavioral

  main: process(CLK)
    begin
      if rising_edge(CLK) then

        ldclk <= not ldclk;
        DCLK <= ldclk; 

        if ldclk = '0' then
          if hcnt = HLEN -1 then
            hcnt <= 0;
          else
            hcnt <= hcnt + 1; 
          end if;
        end if;

        if ldclk = '0' then
          if ldena = '1'  then
            xcnt <= xcnt + 1;
          else
            xcnt <= (others => '0'); 
          end if;
        end if;

        X <= xcnt;
        
        if hcnt < HBP then
          HD <= '0';
        else
          HD <= '1'; 
        end if;

        if hcnt > HBP and hcnt < 640 + HBP  then
          lDENA <= '1';
        else
          lDENA <= '0'; 
        end if;

        DENA <= ldena; 
        
        if hcnt = HLEN-1 then
          if vcnt = VLEN -1 then
            vcnt <= 0;
          else
            vcnt <= vcnt + 1; 
          end if;
        end if;

        if vcnt < 10 then
          VD <= '0';
        else
          VD <= '1'; 
        end if;
        
        ROUT <= RIN;
        GOUT <= GIN;
        BOUT <= BIN; 
      end if;
    end process main; 

 end Behavioral;
