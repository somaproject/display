library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.numeric_std.all;

library UNISIM;
use UNISIM.VComponents.all;

entity blink is

  port (
    RXCLKIN   : in  std_logic;
    LED1  : out std_logic;
    LED2  : out std_logic;
    BRITE : out std_logic;
    REV : out std_logic; 
    SLEEP : out std_logic;
    DCLK  : out std_logic;
    HD    : out std_logic;
    VD    : out std_logic;
    DENA  : out std_logic;
    ROUT  : out std_logic_vector(5 downto 0);
    GOUT  : out std_logic_vector(5 downto 0);
    BOUT  : out std_logic_vector(5 downto 0)

    );

end blink;

architecture Behavioral of blink is
  signal cnt : std_logic_vector(23 downto 0) := (others => '0');

  component framecontrol
    port (
      CLK        : in  std_logic;
      FRAMESTART : in  std_logic;
      X          : out std_logic_vector(9 downto 0);
      Y          : out std_logic_vector(8 downto 0);
      DCLK       : out std_logic;
      HD         : out std_logic;
      VD         : out std_logic;
      DENA       : out std_logic;
      ROUT       : out std_logic_vector(5 downto 0);
      GOUT       : out std_logic_vector(5 downto 0);
      BOUT       : out std_logic_vector(5 downto 0);
      RIN        : in  std_logic_vector(5 downto 0);
      GIN        : in  std_logic_vector(5 downto 0);
      BIN        : in  std_logic_vector(5 downto 0)
      );
  end component;

  signal x : std_logic_vector(9 downto 0) := (others => '0');
  signal y : std_logic_vector(8 downto 0) := (others => '0');

  signal rin, gin, bin : std_logic_vector(5 downto 0) := (others => '0');
  signal clk : std_logic := '0';
  signal framestart : std_logic := '0';

begin  -- Behavioral

  clk <= RXCLKIN;
  REV <= '0'; 
  SLEEP <= '1';

  framecontrol_inst: framecontrol
    port map (
      CLK        => CLK,
      FRAMESTART => framestart,
      X          => x,
      Y          => y,
      DCLK       => DCLK,
      HD         => HD,
      VD         => VD,
      DENA       => DENA,
      ROUT       => ROUT,
      GOUT       => GOUT,
      BOUT       => BOUT,
      RIN        => rin,
      GIN        => gin,
      BIN        => bin); 
    

  rin <= X(5 downto 0); 
  gin <=  X(5 downto 0); 
  bin <=  X(5 downto 0); 
  
  main : process (CLK)
  begin
    if rising_edge(CLK) then
      cnt <= cnt + 1;

      LED1 <= cnt(23);
      LED2 <= cnt(22);
      
      framestart <= '1';
      if cnt(15) /= '0' then
        BRITE <= '1';
      else
        BRITE <= '0'; 
      end if;

    end if;

  end process main;


end Behavioral;
