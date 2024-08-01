library ieee;
use ieee.std_logic_1164.all;

entity tb_timer_counter is
end tb_timer_counter;

architecture beh of tb_timer_counter is

    -- Component declaration
    component timer_counter
        port (
            clk : in std_logic;
            rst : in std_logic;
            start : in std_logic;
            done : out std_logic
        );
    end component;

    -- Signals to connect to the UUT (Unit Under Test)
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal start : std_logic := '0';
    signal done : std_logic;

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: timer_counter
        port map (
            clk => clk,
            rst => rst,
            start => start,
            done => done
        );

    -- Clock process definitions
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin

        -- Reset the system
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 20 ns;

        -- Start the timer
        start <= '1';
        wait for 20 ns;
        start <= '0';

        -- Wait for done signal
        wait until done = '1';
        wait for 20 ns;

        -- Start the timer again
        start <= '1';
        wait for 20 ns;
        start <= '0';

        -- Wait for done signal
        wait until done = '1';
        wait for 20 ns;

        -- Stop the simulation
        wait;
    end process;

end beh;
