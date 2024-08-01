library ieee;
use ieee.std_logic_1164.all;

entity timer_counter is 
	port(
	clk: in std_logic;
	rst: in std_logic;
	start: in std_logic;
	done: out std_logic);
end timer_counter;	



architecture beh of timer_counter is	

--declarative section 

--constants		
constant n_count:integer:=10; 

--enum type
type states is (Idle,Init,counting,Switched_on);

--signals  
signal start_counting:std_logic;
signal counter:integer:=0;
signal state:states;   
signal En_Init,En_Counting,En_Switched_on:std_logic;
--next_state function or in general functions 		

-- function next_state()

function next_state(nx:states;sstart:std_logic;sstart_counting: std_logic;scounter:integer)
return states is variable next_status:states;
begin	
	
	case nx is
		
		--state mapping 
		when Idle => if sstart='1' then next_status:=Init;			  --  := for variables instead <= for signals
					 else next_status:=Idle;
					 end if;
					 
		when Init => if sstart_counting='1' then next_status:=Counting;
					 else next_status:=Init; 
					 end if;
					 
					 
		when Counting => if scounter<n_count then next_status:=counting;
			             else next_status:=Switched_on;
						 end if;
						 
		when Switched_on => next_status:=Init;				 
		
		
		
		end case;
	
	
	
	
return next_status;
end function;

begin
	
	--explanation section	 
	
	
	--cu		
	
	--mappiamo il tutto sul rising_edge del clock
	process(clk,rst)	  
	begin
		
		if rst='1' then	
			state<=Idle;
			
		else if clk'event and clk='1' then 
			state<=next_state(state,start,start_counting,counter);
		end if;	
			
		end if;
	end process;		
	
	
	
	--control signals	
	En_Init<='1' when state=Init else '0';
		
	En_Counting<='1' when state=Counting else'0';
		
	En_Switched_on<='1' when state=Switched_on else'0';	
	
	
	
	--datapath 
	process(clk)
	begin 
	if clk'event and clk='1' then
		
		--component initiazation
		if En_init='1' then
			
			start_counting<='1';
			counter<=0;
			
			
		end if;
		
		
		if En_Counting ='1' then  
			
			--increment mapping 
			
			counter<=counter+1;
			
		end if;
		
		
		if En_Switched_on='1' then
			
			 done<='1';
			
		end if;
		
		
		
		
		
	end if;
	
	end process;
	

	
	
	
	
	
end beh;