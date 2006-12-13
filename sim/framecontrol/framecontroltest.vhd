library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.numeric_std.all;

entity framecontroltest is

end framecontroltest;

architecture Behavioral of framecontroltest is

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


  signal CLK        : std_logic := '0'; 
  signal FRAMESTART : std_logic  := '0'; 
  signal X          : std_logic_vector(9 downto 0) := (others => '0'); 
  signal Y          : std_logic_vector(8 downto 0)  := (others => '0'); 
  signal DCLK       : std_logic  := '0'; 
  signal HD         : std_logic  := '0'; 
  signal VD         : std_logic  := '0'; 
  signal DENA       : std_logic  := '0'; 
  signal ROUT       : std_logic_vector(5 downto 0)  := (others => '0'); 
  signal GOUT       : std_logic_vector(5 downto 0)  := (others => '0'); 
  signal BOUT       : std_logic_vector(5 downto 0) := (others => '0'); 
  signal RIN        : std_logic_vector(5 downto 0)  := (others => '0'); 
  signal GIN        : std_logic_vector(5 downto 0)  := (others => '0'); 
  signal BIN        : std_logic_vector(5 downto 0)  := (others => '0'); 

  type xreg_t is array (7 downto 0) of std_logic_vector(9 downto 0);
  signal xregs : xreg_t := (others => (others => '0'));
  
  type yreg_t is array (7 downto 0) of std_logic_vector(8 downto 0);
  signal yregs : yreg_t := (others => (others => '0'));
  
  
begin  -- Behavioral

  framecontrol_uut: framecontrol
    port map (
      CLK => CLK,
      FRAMESTART => FRAMESTART,
      X => X,
      Y => Y,
      DCLK => DCLK,
      HD => HD,
      VD => VD,
      DENA => DENA,
      ROUT => ROUT,
      GOUT => GOUT,
      BOUT => BOUT,
      RIN => RIN,
      GIN => GIN,
      BIN => BIN); 
      
  CLK <= not clk after 10 ns;
  
  -- verify data output
  -- 
  main: process(CLK)
    begin
      if rising_edge(CLK) then
        xregs <= xregs(6 downto 0) & X;
        yregs <= yregs(6 downto 0) & Y;
        RIN <= "01" & xregs(7)(3 downto 0);
        GIN <= "10" & xregs(7)(7 downto 4);
        BIN <= "11" & yregs(7)(3 downto 0);
        
        
      end if;
  end process main; 

  process
    begin
      wait for 10 us;
      wait until rising_edge(CLK);
      FRAMESTART <= '1';
      wait until rising_edge(CLK);
      FRAMESTART <= '0';

      wait; 
    end process; 
      
end Behavioral;
