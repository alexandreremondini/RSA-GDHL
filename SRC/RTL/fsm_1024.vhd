library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fsm_1024 is
  generic(
  N : natural); --number of registers in the reg file
  port(
    clk_i                     : in  std_logic;
    resetb_i                  : in  std_logic;
    start_i                   : in  std_logic; --launch fsm
    ope_i                     : in std_logic_vector(3 downto 0);
    cpt_i                     : in  std_logic_vector(3*N-1 downto 0); -- 3 counter output of N bits each
    addr_read1_i              : in std_logic_vector(N-1 downto 0); --LSB register for operand 1
    addr_read2_i              : in std_logic_vector(N-1 downto 0); --LSB register for operand 2
    addr_mod_i                : in std_logic_vector(N-1 downto 0); --LSB register for modulo
    addr_write_i              : in std_logic_vector(N-1 downto 0); --LSB register for result storage
    cadd_i                    : in std_logic; --ALU's current add carry
    csub_i                    : in std_logic; --ALU's current sub carry
    shftl_i                   : in std_logic; --ALU's current shift left carry
    shftr_i                   : in std_logic; --ALU's current shift right carry

    done_o                    : out std_logic; --when output reg_file is full
    ope_o                     : out std_logic_vector(3 downto 0);
    high_mul_o                : out std_logic;
    init_cpt_o                : out std_logic_vector(2 downto 0); --init counter to 0
    en_cpt_o                  : out std_logic_vector(2 downto 0); --enable counter
    en_write_o                : out std_logic; --enable write in reg_file
    addr_read1_o              : out std_logic_vector(N-1 downto 0);
    addr_read2_o              : out std_logic_vector(N-1 downto 0);
    addr_write_o              : out std_logic_vector(N-1 downto 0);
    external_write_o          : out std_logic --write external data instead of ALU's data
    );

end fsm_1024;

architecture fsm_1024_arch of fsm_1024 is

  signal cpt1 : std_logic_vector(N-1 downto 0) := (others => '0');
  signal cpt2 : std_logic_vector(N-1 downto 0) := (others => '0');
  signal cpt3 : std_logic_vector(N-1 downto 0) := (others => '0');

  constant R0 : std_logic_vector(N-1 downto 0) := (others=> '0');
  constant R1 : std_logic_vector(N-1 downto 0) := std_logic_vector(unsigned(R0)+1);

  type state is (IDLE, LOAD,
                 ADD_ADD, ADDC_ADD1, ADDC_ADD2,
                 SUB_SUB, SUBC_SUB1, SUBC_SUB2,
                 ADD1_ADDMOD, ADDC2_ADDMOD, ADDC3_ADDMOD, ADDC4_ADDMOD,SUB5_ADDMOD, SUBC6_ADDMOD, SUBC7_ADDMOD, SUBC8_ADDMOD, ADD9_ADDMOD,ADDC10_ADDMOD, ADDC11_ADDMOD,
                 MULL, ADD_MULL, ADDC_MULL1, ADDC_MULL2, MULH, ADD_MULH, ADDC_MULH1, ADDC_MULH2, INCR_CPT1, INCR_CPT2,
                 ENDING);

  signal present_state, next_state : state;
  begin

  cpt1 <= cpt_i(N-1 downto 0);
  cpt2 <= cpt_i(2*N-1 downto N);
  cpt3 <= cpt_i(3*N-1 downto 2*N);

  sequential : process(clk_i, resetb_i)
  begin
  	if resetb_i = '0' then
  		present_state <= IDLE;
  	elsif rising_edge(clk_i) then
  		present_state <= next_state;
  	end if;
  end process sequential;

  C0 : process(present_state, start_i, ope_i, cpt_i, addr_read1_i, addr_read2_i, addr_mod_i, addr_write_i, cadd_i, csub_i, shftl_i, shftr_i)
  begin
  	case present_state is

  		when IDLE => --wait
        if ((start_i = '1') and (ope_i = x"0")) then
          next_state <= ADD_ADD;
        elsif ((start_i = '1') and (ope_i = x"1")) then
          next_state <= SUB_SUB;
        elsif ((start_i = '1') and (ope_i = x"2")) then
  				next_state <= MULL;
        elsif ((start_i = '1') and (ope_i = x"3")) then
          next_state <= LOAD;
        elsif ((start_i = '1') and (ope_i = x"4")) then
          next_state <= ADD1_ADDMOD;
        else
          next_state <= IDLE;
        end if;

      when LOAD =>
          next_state <= IDLE;

      --STATES FOR ADDITION
      when ADD_ADD =>
        next_state <= ADDC_ADD1;

      when ADDC_ADD1 =>
        if (to_integer(unsigned(cpt1)) < 14) then
          next_state <= ADDC_ADD2;
        else
          next_state <= ENDING;
        end if;

      when ADDC_ADD2 =>
        if (to_integer(unsigned(cpt1)) < 14) then
          next_state <= ADDC_ADD1;
        else
          next_state <= ENDING;
        end if;

      --STATES FOR SUBSTRACTION
      when SUB_SUB =>
        next_state <= SUBC_SUB1;

      when SUBC_SUB1 =>
        if (to_integer(unsigned(cpt1)) < 14) then
          next_state <= SUBC_SUB2;
        else
          next_state <= ENDING;
        end if;

      when SUBC_SUB2 =>
        if (to_integer(unsigned(cpt1)) < 14) then
          next_state <= SUBC_SUB1;
        else
          next_state <= ENDING;
        end if;

      --STATES FOR MODULAR ADDITION
      when ADD1_ADDMOD =>
        next_state <= ADDC2_ADDMOD;

      when ADDC2_ADDMOD =>
        if (to_integer(unsigned(cpt1)) < 14) then
          next_state <= ADDC3_ADDMOD;
        else
          next_state <= ADDC4_ADDMOD;
        end if;

      when ADDC3_ADDMOD =>
        if (to_integer(unsigned(cpt1)) < 14) then
          next_state <= ADDC2_ADDMOD;
        else
          next_state <= ADDC4_ADDMOD;
        end if;

      when ADDC4_ADDMOD =>
          next_state <= SUB5_ADDMOD;

      when SUB5_ADDMOD =>
          next_state <= SUBC6_ADDMOD;

      when SUBC6_ADDMOD =>
        if (to_integer(unsigned(cpt1)) < 14) then
          next_state <= SUBC7_ADDMOD;
        else
          next_state <= SUBC8_ADDMOD;
        end if;

      when SUBC7_ADDMOD =>
        if (to_integer(unsigned(cpt1)) < 14) then
          next_state <= SUBC6_ADDMOD;
        else
          next_state <= SUBC8_ADDMOD;
        end if;

      when SUBC8_ADDMOD =>
        if (csub_i = '0') then
          next_state <= SUB5_ADDMOD;
        else
          next_state <= ADD9_ADDMOD;
        end if;

      when ADD9_ADDMOD =>
        next_state <= ADDC10_ADDMOD;

      when ADDC10_ADDMOD =>
        if (to_integer(unsigned(cpt1)) < 14) then
          next_state <= ADDC11_ADDMOD;
        else
          next_state <= ENDING;
        end if;

      when ADDC11_ADDMOD =>
        if (to_integer(unsigned(cpt1)) < 14) then
          next_state <= ADDC10_ADDMOD;
        else
          next_state <= ENDING;
        end if;

      --STATES FOR MULTIPLICATION

      when MULL => --MUL R1, ope1(cpt1), ope2(cpt2)
        next_state <= ADD_MULL;

  		when ADD_MULL => --ADD res(cpt1 + cpt2), res(cpt1 + cpt2), R1
				if (cadd_i = '1') then
          next_state <= ADDC_MULL1;
				else
					next_state <= MULH;
        end if;

      when ADDC_MULL1 => --ADDC res(cpt1 + cpt2 + cpt3), res(cpt1 + cpt2 + cpt3), R0
        if (cadd_i = '1') then
          next_state <= ADDC_MULL2;
        else
          next_state <= MULH;
        end if;

      when ADDC_MULL2 => --ADDC res(cpt1 + cpt2 + cpt3), res(cpt1 + cpt2 + cpt3), R0
        if (cadd_i = '1') then
          next_state <= ADDC_MULL1;
        else
          next_state <= MULH;
        end if;

      when MULH => --MUL R1, ope1(cpt1), ope2(cpt2)
          next_state <= ADD_MULH;

      when ADD_MULH => --ADD res(cpt1 + cpt2 + 1), res(cpt1 + cpt2 + 1), R1
        if (cadd_i = '1') then
          next_state <= ADDC_MULH1;
        elsif (to_integer(unsigned(cpt2)) < 15) then
          next_state <= INCR_CPT2;
        elsif (to_integer(unsigned(cpt1)) < 15) then
          next_state <= INCR_CPT1;
        else
          next_state <= ENDING;
        end if;

      when ADDC_MULH1 => --ADDC res(cpt1 + cpt2 + cpt3 + 1), res(cpt1 + cpt2 + cpt3 + 1), R0
        if (cadd_i = '1') then
          next_state <= ADDC_MULH2;
        elsif (to_integer(unsigned(cpt2)) < 15) then
          next_state <= INCR_CPT2;
        elsif (to_integer(unsigned(cpt1)) < 15) then
          next_state <= INCR_CPT1;
        else
          next_state <= ENDING;
        end if;

      when ADDC_MULH2 => --ADDC res(cpt1 + cpt2 + cpt3 + 1), res(cpt1 + cpt2 + cpt3 + 1), R0
        if (cadd_i = '1') then
          next_state <= ADDC_MULH1;
        elsif (to_integer(unsigned(cpt2)) < 15) then
          next_state <= INCR_CPT2;
        elsif (to_integer(unsigned(cpt1)) < 15) then
          next_state <= INCR_CPT1;
        else
          next_state <= ENDING;
        end if;

      when INCR_CPT1 =>
  				next_state <= MULL;

      when INCR_CPT2 =>
  				next_state <= MULL;

  		when ENDING =>
  				next_state <= IDLE;

    end case;
end process C0;

  C1 : process(present_state)
  begin
  	case present_state is
  		when IDLE =>
        done_o <= '0';
        init_cpt_o <= "111";
        en_cpt_o <= "000";
        en_write_o <= '0';
        ope_o <= x"0";
        high_mul_o <= '0';
        addr_read1_o <= (others => '0');
        addr_read2_o <= (others => '0');
        addr_write_o <= (others => '0');
        external_write_o <= '0';

      when LOAD =>
        done_o <= '1';
        init_cpt_o <= "111";
        en_cpt_o <= "000";
        en_write_o <= '1';
        ope_o <= x"0"; --not used
        high_mul_o <= '0';
        addr_read1_o <= (others => '0');
        addr_read2_o <= (others => '0');
        addr_write_o <= addr_write_i;
        external_write_o <= '1';

      -- STATES FOR ADDITION
      when ADD_ADD =>
        done_o <= '0';
        init_cpt_o <= "110";
        en_cpt_o <= "001";
        en_write_o <= '1';
        ope_o <= x"1";
        high_mul_o <= '0';
        addr_read1_o <= addr_read1_i;
        addr_read2_o <= addr_read2_i;
        addr_write_o <= addr_write_i;
        external_write_o <= '0';

      when ADDC_ADD1 =>
        done_o <= '0';
        init_cpt_o <= "110";
        en_cpt_o <= "001";
        en_write_o <= '1';
        ope_o <= x"2";
        high_mul_o <= '0';
        addr_read1_o <= std_logic_vector(unsigned(addr_read1_i) + unsigned(cpt1) + 1);
        addr_read2_o <= std_logic_vector(unsigned(addr_read2_i) + unsigned(cpt1) + 1);
        addr_write_o <= std_logic_vector(unsigned(addr_write_i) + unsigned(cpt1) + 1);
        external_write_o <= '0';

      when ADDC_ADD2 =>
        done_o <= '0';
        init_cpt_o <= "110";
        en_cpt_o <= "001";
        en_write_o <= '1';
        ope_o <= x"2";
        high_mul_o <= '0';
        addr_read1_o <= std_logic_vector(unsigned(addr_read1_i) + unsigned(cpt1) + 1);
        addr_read2_o <= std_logic_vector(unsigned(addr_read2_i) + unsigned(cpt1) + 1);
        addr_write_o <= std_logic_vector(unsigned(addr_write_i) + unsigned(cpt1) + 1);
        external_write_o <= '0';

      --STATES FOR SUBSTRACTION
      when SUB_SUB =>
        done_o <= '0';
        init_cpt_o <= "110";
        en_cpt_o <= "001";
        en_write_o <= '1';
        ope_o <= x"3";
        high_mul_o <= '0';
        addr_read1_o <= addr_read1_i;
        addr_read2_o <= addr_read2_i;
        addr_write_o <= addr_write_i;
        external_write_o <= '0';

      when SUBC_SUB1 =>
        done_o <= '0';
        init_cpt_o <= "110";
        en_cpt_o <= "001";
        en_write_o <= '1';
        ope_o <= x"4";
        high_mul_o <= '0';
        addr_read1_o <= std_logic_vector(unsigned(addr_read1_i) + unsigned(cpt1) + 1);
        addr_read2_o <= std_logic_vector(unsigned(addr_read2_i) + unsigned(cpt1) + 1);
        addr_write_o <= std_logic_vector(unsigned(addr_write_i) + unsigned(cpt1) + 1);
        external_write_o <= '0';

      when SUBC_SUB2 =>
        done_o <= '0';
        init_cpt_o <= "110";
        en_cpt_o <= "001";
        en_write_o <= '1';
        ope_o <= x"4";
        high_mul_o <= '0';
        addr_read1_o <= std_logic_vector(unsigned(addr_read1_i) + unsigned(cpt1) + 1);
        addr_read2_o <= std_logic_vector(unsigned(addr_read2_i) + unsigned(cpt1) + 1);
        addr_write_o <= std_logic_vector(unsigned(addr_write_i) + unsigned(cpt1) + 1);
        external_write_o <= '0';

      --STATES FOR MODULAR ADDITION
      when ADD1_ADDMOD =>
        done_o <= '0';
        init_cpt_o <= "110";
        en_cpt_o <= "001";
        en_write_o <= '1';
        ope_o <= x"1";
        high_mul_o <= '0';
        addr_read1_o <= addr_read1_i;
        addr_read2_o <= addr_read2_i;
        addr_write_o <= addr_write_i;
        external_write_o <= '0';

      when ADDC2_ADDMOD =>
        done_o <= '0';
        init_cpt_o <= "110";
        en_cpt_o <= "001";
        en_write_o <= '1';
        ope_o <= x"2";
        high_mul_o <= '0';
        addr_read1_o <= std_logic_vector(unsigned(addr_read1_i) + unsigned(cpt1) + 1);
        addr_read2_o <= std_logic_vector(unsigned(addr_read2_i) + unsigned(cpt1) + 1);
        addr_write_o <= std_logic_vector(unsigned(addr_write_i) + unsigned(cpt1) + 1);
        external_write_o <= '0';

      when ADDC3_ADDMOD =>
        done_o <= '0';
        init_cpt_o <= "110";
        en_cpt_o <= "001";
        en_write_o <= '1';
        ope_o <= x"2";
        high_mul_o <= '0';
        addr_read1_o <= std_logic_vector(unsigned(addr_read1_i) + unsigned(cpt1) + 1);
        addr_read2_o <= std_logic_vector(unsigned(addr_read2_i) + unsigned(cpt1) + 1);
        addr_write_o <= std_logic_vector(unsigned(addr_write_i) + unsigned(cpt1) + 1);
        external_write_o <= '0';

      when ADDC4_ADDMOD =>
        done_o <= '0';
        init_cpt_o <= "111";
        en_cpt_o <= "000";
        en_write_o <= '1';
        ope_o <= x"2";
        high_mul_o <= '0';
        addr_read1_o <= R0;
        addr_read2_o <= R0;
        addr_write_o <= R1; --store carry
        external_write_o <= '0';

      when SUB5_ADDMOD =>
        done_o <= '0';
        init_cpt_o <= "110";
        en_cpt_o <= "001";
        en_write_o <= '1';
        ope_o <= x"3";
        high_mul_o <= '0';
        addr_read1_o <= addr_write_i;
        addr_read2_o <= addr_mod_i;
        addr_write_o <= addr_write_i;
        external_write_o <= '0';

      when SUBC6_ADDMOD =>
        done_o <= '0';
        init_cpt_o <= "110";
        en_cpt_o <= "001";
        en_write_o <= '1';
        ope_o <= x"4";
        high_mul_o <= '0';
        addr_read1_o <= std_logic_vector(unsigned(addr_write_i) + unsigned(cpt1) + 1);
        addr_read2_o <= std_logic_vector(unsigned(addr_mod_i) + unsigned(cpt1) + 1);
        addr_write_o <= std_logic_vector(unsigned(addr_write_i) + unsigned(cpt1) + 1);
        external_write_o <= '0';

      when SUBC7_ADDMOD =>
        done_o <= '0';
        init_cpt_o <= "110";
        en_cpt_o <= "001";
        en_write_o <= '1';
        ope_o <= x"4";
        high_mul_o <= '0';
        addr_read1_o <= std_logic_vector(unsigned(addr_write_i) + unsigned(cpt1) + 1);
        addr_read2_o <= std_logic_vector(unsigned(addr_mod_i) + unsigned(cpt1) + 1);
        addr_write_o <= std_logic_vector(unsigned(addr_write_i) + unsigned(cpt1) + 1);
        external_write_o <= '0';

      when SUBC8_ADDMOD =>
        done_o <= '0';
        init_cpt_o <= "111";
        en_cpt_o <= "000";
        en_write_o <= '1';
        ope_o <= x"4";
        high_mul_o <= '0';
        addr_read1_o <= R1;
        addr_read2_o <= R0;
        addr_write_o <= R1;
        external_write_o <= '0';

      when ADD9_ADDMOD =>
        done_o <= '0';
        init_cpt_o <= "110";
        en_cpt_o <= "001";
        en_write_o <= '1';
        ope_o <= x"1";
        high_mul_o <= '0';
        addr_read1_o <= addr_write_i;
        addr_read2_o <= addr_mod_i;
        addr_write_o <= addr_write_i;
        external_write_o <= '0';

      when ADDC10_ADDMOD =>
        done_o <= '0';
        init_cpt_o <= "110";
        en_cpt_o <= "001";
        en_write_o <= '1';
        ope_o <= x"2";
        high_mul_o <= '0';
        addr_read1_o <= std_logic_vector(unsigned(addr_write_i) + unsigned(cpt1) + 1);
        addr_read2_o <= std_logic_vector(unsigned(addr_mod_i) + unsigned(cpt1) + 1);
        addr_write_o <= std_logic_vector(unsigned(addr_write_i) + unsigned(cpt1) + 1);
        external_write_o <= '0';

      when ADDC11_ADDMOD =>
        done_o <= '0';
        init_cpt_o <= "110";
        en_cpt_o <= "001";
        en_write_o <= '1';
        ope_o <= x"2";
        high_mul_o <= '0';
        addr_read1_o <= std_logic_vector(unsigned(addr_write_i) + unsigned(cpt1) + 1);
        addr_read2_o <= std_logic_vector(unsigned(addr_mod_i) + unsigned(cpt1) + 1);
        addr_write_o <= std_logic_vector(unsigned(addr_write_i) + unsigned(cpt1) + 1);
        external_write_o <= '0';

      -- STATES FOR MULTIPLICATION
      when MULL =>
        done_o <= '0';
        init_cpt_o <= "100";
        en_cpt_o <= "000";
        en_write_o <= '1';
        ope_o <= x"9";
        high_mul_o <= '0';
        addr_read1_o <= std_logic_vector(unsigned(addr_read1_i) + unsigned(cpt1));
        addr_read2_o <= std_logic_vector(unsigned(addr_read2_i) + unsigned(cpt2));
        addr_write_o <= R1;
        external_write_o <= '0';

      when ADD_MULL =>
        done_o <= '0';
        init_cpt_o <= "000";
        en_cpt_o <= "100";
        en_write_o <= '1';
        ope_o <= x"1";
        high_mul_o <= '0';
        addr_read1_o <= std_logic_vector(unsigned(addr_write_i) + unsigned(cpt1) + unsigned(cpt2)); --mov ope2
        addr_read2_o <= R1;
        addr_write_o <= std_logic_vector(unsigned(addr_write_i) + unsigned(cpt1) + unsigned(cpt2));
        external_write_o <= '0';

      when ADDC_MULL1 =>
        done_o <= '0';
        init_cpt_o <= "000";
        en_cpt_o <= "100";
        en_write_o <= '1';
        ope_o <= x"2";
        high_mul_o <= '0';
        addr_read1_o <= std_logic_vector(unsigned(addr_write_i) + unsigned(cpt1) + unsigned(cpt2) + unsigned(cpt3) + 1);
        addr_read2_o <= R0;
        addr_write_o <= std_logic_vector(unsigned(addr_write_i) + unsigned(cpt1) + unsigned(cpt2) + unsigned(cpt3) + 1);
        external_write_o <= '0';

      when ADDC_MULL2 =>
        done_o <= '0';
        init_cpt_o <= "000";
        en_cpt_o <= "100";
        en_write_o <= '1';
        ope_o <= x"2";
        high_mul_o <= '0';
        addr_read1_o <= std_logic_vector(unsigned(addr_write_i) + unsigned(cpt1) + unsigned(cpt2) + unsigned(cpt3) + 1);
        addr_read2_o <= R0;
        addr_write_o <= std_logic_vector(unsigned(addr_write_i) + unsigned(cpt1) + unsigned(cpt2) + unsigned(cpt3) + 1);
        external_write_o <= '0';

      when MULH =>
        done_o <= '0';
        init_cpt_o <= "100";
        en_cpt_o <= "000";
        en_write_o <= '1';
        ope_o <= x"9";
        high_mul_o <= '1';
        addr_read1_o <= std_logic_vector(unsigned(addr_read1_i) + unsigned(cpt1));
        addr_read2_o <= std_logic_vector(unsigned(addr_read2_i) + unsigned(cpt2));
        addr_write_o <= R1;
        external_write_o <= '0';

      when ADD_MULH =>
        done_o <= '0';
        init_cpt_o <= "000";
        en_cpt_o <= "100";
        en_write_o <= '1';
        ope_o <= x"1";
        high_mul_o <= '0';
        addr_read1_o <= std_logic_vector(unsigned(addr_write_i) + unsigned(cpt1) + unsigned(cpt2) + 1); --mov ope2
        addr_read2_o <= R1;
        addr_write_o <= std_logic_vector(unsigned(addr_write_i) + unsigned(cpt1) + unsigned(cpt2) + 1);
        external_write_o <= '0';

      when ADDC_MULH1 =>
        done_o <= '0';
        init_cpt_o <= "000";
        en_cpt_o <= "100";
        en_write_o <= '1';
        ope_o <= x"2";
        high_mul_o <= '0';
        addr_read1_o <= std_logic_vector(unsigned(addr_write_i) + unsigned(cpt1) + unsigned(cpt2) + unsigned(cpt3) + 2);
        addr_read2_o <= R0;
        addr_write_o <= std_logic_vector(unsigned(addr_write_i) + unsigned(cpt1) + unsigned(cpt2) + unsigned(cpt3) + 2);
        external_write_o <= '0';

      when ADDC_MULH2 =>
        done_o <= '0';
        init_cpt_o <= "000";
        en_cpt_o <= "100";
        en_write_o <= '1';
        ope_o <= x"2";
        high_mul_o <= '0';
        addr_read1_o <= std_logic_vector(unsigned(addr_write_i) + unsigned(cpt1) + unsigned(cpt2) + unsigned(cpt3) + 2);
        addr_read2_o <= R0;
        addr_write_o <= std_logic_vector(unsigned(addr_write_i) + unsigned(cpt1) + unsigned(cpt2) + unsigned(cpt3) + 2);
        external_write_o <= '0';

      when INCR_CPT1 =>
        done_o <= '0';
        init_cpt_o <= "110";
        en_cpt_o <= "001";
        en_write_o <= '0';
        ope_o <= x"0";
        high_mul_o <= '0';
        addr_read1_o <= (others => '0');
        addr_read2_o <= (others => '0');
        addr_write_o <= (others => '0');
        external_write_o <= '0';

      when INCR_CPT2 =>
        done_o <= '0';
        init_cpt_o <= "100";
        en_cpt_o <= "010";
        en_write_o <= '0';
        ope_o <= x"0";
        high_mul_o <= '0';
        addr_read1_o <= (others => '0');
        addr_read2_o <= (others => '0');
        addr_write_o <= (others => '0');
        external_write_o <= '0';

      when ENDING =>
        done_o <= '1';
        init_cpt_o <= "111";
        en_cpt_o <= "000";
        en_write_o <= '0';
        ope_o <= x"0";
        high_mul_o <= '0';
        addr_read1_o <= (others => '0');
        addr_read2_o <= (others => '0');
        addr_write_o <= (others => '0');
        external_write_o <= '0';

      end case;
  end process C1;

end architecture fsm_1024_arch;
