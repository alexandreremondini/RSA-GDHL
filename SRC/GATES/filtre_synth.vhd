
library IEEE;

use IEEE.std_logic_1164.all;

package CONV_PACK_FILTRE is

-- define attributes
attribute ENUM_ENCODING : STRING;

end CONV_PACK_FILTRE;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_FILTRE.all;

entity mul_DW_mult_uns_0 is

   port( a, b : in std_logic_vector (7 downto 0);  product : out 
         std_logic_vector (15 downto 0));

end mul_DW_mult_uns_0;

architecture SYN_USE_DEFA_ARCH_NAME of mul_DW_mult_uns_0 is

   component CLKIN0
      port( A : in std_logic;  Q : out std_logic);
   end component;
   
   component NOR20
      port( A, B : in std_logic;  Q : out std_logic);
   end component;
   
   component ADD22
      port( A, B : in std_logic;  CO, S : out std_logic);
   end component;
   
   component ADD32
      port( A, B, CI : in std_logic;  CO, S : out std_logic);
   end component;
   
   signal n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, 
      n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31
      , n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, 
      n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60
      , n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, 
      n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89
      , n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, 
      n103, n104, n105, n106, n107, n108, n109, n110, n111, n112, n113, n114, 
      n115, n116, n117, n118, n119, n120, n121, n122, n123, n124, n125, n126, 
      n127, n128, n129, n130, n131, n132, n133, n134, n135, n136, n137, n138, 
      n139, n140, n141, n142, n143, n144, n145, n146, n147, n148, n149, n150, 
      n151, n152, n153, n154, n155, n156, n157, n158, n159, n160, n161, n214, 
      n215, n216, n217, n218, n219, n220, n221, n222, n223, n224, n225, n226, 
      n227, n228, n229 : std_logic;

begin
   
   U2 : ADD32 port map( A => n15, B => n99, CI => n2, CO => product(15), S => 
                           product(14));
   U3 : ADD32 port map( A => n17, B => n16, CI => n3, CO => n2, S => 
                           product(13));
   U4 : ADD32 port map( A => n21, B => n18, CI => n4, CO => n3, S => 
                           product(12));
   U5 : ADD32 port map( A => n22, B => n27, CI => n5, CO => n4, S => 
                           product(11));
   U6 : ADD32 port map( A => n28, B => n35, CI => n6, CO => n5, S => 
                           product(10));
   U7 : ADD32 port map( A => n36, B => n45, CI => n7, CO => n6, S => product(9)
                           );
   U8 : ADD32 port map( A => n46, B => n57, CI => n8, CO => n7, S => product(8)
                           );
   U9 : ADD32 port map( A => n58, B => n69, CI => n9, CO => n8, S => product(7)
                           );
   U10 : ADD32 port map( A => n70, B => n79, CI => n10, CO => n9, S => 
                           product(6));
   U11 : ADD32 port map( A => n80, B => n87, CI => n11, CO => n10, S => 
                           product(5));
   U12 : ADD32 port map( A => n88, B => n93, CI => n12, CO => n11, S => 
                           product(4));
   U13 : ADD32 port map( A => n13, B => n96, CI => n94, CO => n12, S => 
                           product(3));
   U14 : ADD32 port map( A => n14, B => n146, CI => n98, CO => n13, S => 
                           product(2));
   U15 : ADD22 port map( A => n161, B => n154, CO => n14, S => product(1));
   U16 : ADD32 port map( A => n100, B => n107, CI => n19, CO => n15, S => n16);
   U17 : ADD32 port map( A => n20, B => n25, CI => n23, CO => n17, S => n18);
   U18 : ADD32 port map( A => n101, B => n115, CI => n108, CO => n19, S => n20)
                           ;
   U19 : ADD32 port map( A => n24, B => n31, CI => n29, CO => n21, S => n22);
   U20 : ADD32 port map( A => n33, B => n116, CI => n26, CO => n23, S => n24);
   U21 : ADD32 port map( A => n102, B => n123, CI => n109, CO => n25, S => n26)
                           ;
   U22 : ADD32 port map( A => n37, B => n39, CI => n30, CO => n27, S => n28);
   U23 : ADD32 port map( A => n34, B => n41, CI => n32, CO => n29, S => n30);
   U24 : ADD32 port map( A => n117, B => n124, CI => n43, CO => n31, S => n32);
   U25 : ADD32 port map( A => n103, B => n131, CI => n110, CO => n33, S => n34)
                           ;
   U26 : ADD32 port map( A => n47, B => n40, CI => n38, CO => n35, S => n36);
   U27 : ADD32 port map( A => n51, B => n44, CI => n49, CO => n37, S => n38);
   U28 : ADD32 port map( A => n53, B => n55, CI => n42, CO => n39, S => n40);
   U29 : ADD32 port map( A => n125, B => n118, CI => n132, CO => n41, S => n42)
                           ;
   U30 : ADD32 port map( A => n104, B => n139, CI => n111, CO => n43, S => n44)
                           ;
   U31 : ADD32 port map( A => n59, B => n50, CI => n48, CO => n45, S => n46);
   U32 : ADD32 port map( A => n61, B => n54, CI => n52, CO => n47, S => n48);
   U33 : ADD32 port map( A => n63, B => n65, CI => n56, CO => n49, S => n50);
   U34 : ADD32 port map( A => n133, B => n140, CI => n67, CO => n51, S => n52);
   U35 : ADD32 port map( A => n119, B => n147, CI => n126, CO => n53, S => n54)
                           ;
   U36 : ADD22 port map( A => n105, B => n112, CO => n55, S => n56);
   U37 : ADD32 port map( A => n62, B => n71, CI => n60, CO => n57, S => n58);
   U38 : ADD32 port map( A => n66, B => n64, CI => n73, CO => n59, S => n60);
   U39 : ADD32 port map( A => n75, B => n77, CI => n68, CO => n61, S => n62);
   U40 : ADD32 port map( A => n134, B => n148, CI => n141, CO => n63, S => n64)
                           ;
   U41 : ADD32 port map( A => n120, B => n155, CI => n127, CO => n65, S => n66)
                           ;
   U42 : ADD22 port map( A => n106, B => n113, CO => n67, S => n68);
   U43 : ADD32 port map( A => n74, B => n81, CI => n72, CO => n69, S => n70);
   U44 : ADD32 port map( A => n78, B => n83, CI => n76, CO => n71, S => n72);
   U45 : ADD32 port map( A => n142, B => n149, CI => n85, CO => n73, S => n74);
   U46 : ADD32 port map( A => n128, B => n156, CI => n135, CO => n75, S => n76)
                           ;
   U47 : ADD22 port map( A => n114, B => n121, CO => n77, S => n78);
   U48 : ADD32 port map( A => n84, B => n86, CI => n82, CO => n79, S => n80);
   U49 : ADD32 port map( A => n91, B => n150, CI => n89, CO => n81, S => n82);
   U50 : ADD32 port map( A => n136, B => n157, CI => n143, CO => n83, S => n84)
                           ;
   U51 : ADD22 port map( A => n122, B => n129, CO => n85, S => n86);
   U52 : ADD32 port map( A => n92, B => n95, CI => n90, CO => n87, S => n88);
   U53 : ADD32 port map( A => n144, B => n158, CI => n151, CO => n89, S => n90)
                           ;
   U54 : ADD22 port map( A => n130, B => n137, CO => n91, S => n92);
   U55 : ADD32 port map( A => n152, B => n159, CI => n97, CO => n93, S => n94);
   U56 : ADD22 port map( A => n138, B => n145, CO => n95, S => n96);
   U57 : ADD22 port map( A => n153, B => n160, CO => n97, S => n98);
   U140 : NOR20 port map( A => n214, B => n215, Q => product(0));
   U141 : NOR20 port map( A => n216, B => n217, Q => n99);
   U142 : NOR20 port map( A => n214, B => n218, Q => n161);
   U143 : NOR20 port map( A => n214, B => n219, Q => n160);
   U144 : NOR20 port map( A => n214, B => n220, Q => n159);
   U145 : NOR20 port map( A => n214, B => n221, Q => n158);
   U146 : NOR20 port map( A => n214, B => n222, Q => n157);
   U147 : NOR20 port map( A => n214, B => n223, Q => n156);
   U148 : NOR20 port map( A => n214, B => n217, Q => n155);
   U149 : CLKIN0 port map( A => a(0), Q => n214);
   U150 : NOR20 port map( A => n215, B => n224, Q => n154);
   U151 : NOR20 port map( A => n218, B => n224, Q => n153);
   U152 : NOR20 port map( A => n219, B => n224, Q => n152);
   U153 : NOR20 port map( A => n220, B => n224, Q => n151);
   U154 : NOR20 port map( A => n221, B => n224, Q => n150);
   U155 : NOR20 port map( A => n222, B => n224, Q => n149);
   U156 : NOR20 port map( A => n223, B => n224, Q => n148);
   U157 : NOR20 port map( A => n217, B => n224, Q => n147);
   U158 : CLKIN0 port map( A => a(1), Q => n224);
   U159 : NOR20 port map( A => n215, B => n225, Q => n146);
   U160 : NOR20 port map( A => n218, B => n225, Q => n145);
   U161 : NOR20 port map( A => n219, B => n225, Q => n144);
   U162 : NOR20 port map( A => n220, B => n225, Q => n143);
   U163 : NOR20 port map( A => n221, B => n225, Q => n142);
   U164 : NOR20 port map( A => n222, B => n225, Q => n141);
   U165 : NOR20 port map( A => n223, B => n225, Q => n140);
   U166 : NOR20 port map( A => n217, B => n225, Q => n139);
   U167 : CLKIN0 port map( A => a(2), Q => n225);
   U168 : NOR20 port map( A => n215, B => n226, Q => n138);
   U169 : NOR20 port map( A => n218, B => n226, Q => n137);
   U170 : NOR20 port map( A => n219, B => n226, Q => n136);
   U171 : NOR20 port map( A => n220, B => n226, Q => n135);
   U172 : NOR20 port map( A => n221, B => n226, Q => n134);
   U173 : NOR20 port map( A => n222, B => n226, Q => n133);
   U174 : NOR20 port map( A => n223, B => n226, Q => n132);
   U175 : NOR20 port map( A => n217, B => n226, Q => n131);
   U176 : CLKIN0 port map( A => a(3), Q => n226);
   U177 : NOR20 port map( A => n215, B => n227, Q => n130);
   U178 : NOR20 port map( A => n218, B => n227, Q => n129);
   U179 : NOR20 port map( A => n219, B => n227, Q => n128);
   U180 : NOR20 port map( A => n220, B => n227, Q => n127);
   U181 : NOR20 port map( A => n221, B => n227, Q => n126);
   U182 : NOR20 port map( A => n222, B => n227, Q => n125);
   U183 : NOR20 port map( A => n223, B => n227, Q => n124);
   U184 : NOR20 port map( A => n217, B => n227, Q => n123);
   U185 : CLKIN0 port map( A => a(4), Q => n227);
   U186 : NOR20 port map( A => n215, B => n228, Q => n122);
   U187 : NOR20 port map( A => n218, B => n228, Q => n121);
   U188 : NOR20 port map( A => n219, B => n228, Q => n120);
   U189 : NOR20 port map( A => n220, B => n228, Q => n119);
   U190 : NOR20 port map( A => n221, B => n228, Q => n118);
   U191 : NOR20 port map( A => n222, B => n228, Q => n117);
   U192 : NOR20 port map( A => n223, B => n228, Q => n116);
   U193 : NOR20 port map( A => n217, B => n228, Q => n115);
   U194 : CLKIN0 port map( A => a(5), Q => n228);
   U195 : NOR20 port map( A => n215, B => n229, Q => n114);
   U196 : NOR20 port map( A => n218, B => n229, Q => n113);
   U197 : NOR20 port map( A => n219, B => n229, Q => n112);
   U198 : NOR20 port map( A => n220, B => n229, Q => n111);
   U199 : NOR20 port map( A => n221, B => n229, Q => n110);
   U200 : NOR20 port map( A => n222, B => n229, Q => n109);
   U201 : NOR20 port map( A => n223, B => n229, Q => n108);
   U202 : NOR20 port map( A => n217, B => n229, Q => n107);
   U203 : CLKIN0 port map( A => a(6), Q => n229);
   U204 : CLKIN0 port map( A => b(7), Q => n217);
   U205 : NOR20 port map( A => n215, B => n216, Q => n106);
   U206 : CLKIN0 port map( A => b(0), Q => n215);
   U207 : NOR20 port map( A => n216, B => n218, Q => n105);
   U208 : CLKIN0 port map( A => b(1), Q => n218);
   U209 : NOR20 port map( A => n216, B => n219, Q => n104);
   U210 : CLKIN0 port map( A => b(2), Q => n219);
   U211 : NOR20 port map( A => n216, B => n220, Q => n103);
   U212 : CLKIN0 port map( A => b(3), Q => n220);
   U213 : NOR20 port map( A => n216, B => n221, Q => n102);
   U214 : CLKIN0 port map( A => b(4), Q => n221);
   U215 : NOR20 port map( A => n216, B => n222, Q => n101);
   U216 : CLKIN0 port map( A => b(5), Q => n222);
   U217 : NOR20 port map( A => n216, B => n223, Q => n100);
   U218 : CLKIN0 port map( A => b(6), Q => n223);
   U219 : CLKIN0 port map( A => a(7), Q => n216);

end SYN_USE_DEFA_ARCH_NAME;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_FILTRE.all;

entity reg_4 is

   port( clk_i, clk_en_i, resetb_i : in std_logic;  data_i : in 
         std_logic_vector (7 downto 0);  data_o : out std_logic_vector (7 
         downto 0));

end reg_4;

architecture SYN_reg_arch of reg_4 is

   component DFEC1
      port( D, E, C, RN : in std_logic;  Q, QN : out std_logic);
   end component;
   
   signal n9, n10, n11, n12, n13, n14, n15, n16 : std_logic;

begin
   
   reg_s_regx7x : DFEC1 port map( D => data_i(7), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(7), QN => n9);
   reg_s_regx6x : DFEC1 port map( D => data_i(6), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(6), QN => n10);
   reg_s_regx5x : DFEC1 port map( D => data_i(5), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(5), QN => n11);
   reg_s_regx4x : DFEC1 port map( D => data_i(4), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(4), QN => n12);
   reg_s_regx3x : DFEC1 port map( D => data_i(3), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(3), QN => n13);
   reg_s_regx2x : DFEC1 port map( D => data_i(2), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(2), QN => n14);
   reg_s_regx1x : DFEC1 port map( D => data_i(1), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(1), QN => n15);
   reg_s_regx0x : DFEC1 port map( D => data_i(0), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(0), QN => n16);

end SYN_reg_arch;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_FILTRE.all;

entity reg_3 is

   port( clk_i, clk_en_i, resetb_i : in std_logic;  data_i : in 
         std_logic_vector (7 downto 0);  data_o : out std_logic_vector (7 
         downto 0));

end reg_3;

architecture SYN_reg_arch of reg_3 is

   component DFEC1
      port( D, E, C, RN : in std_logic;  Q, QN : out std_logic);
   end component;
   
   signal n9, n10, n11, n12, n13, n14, n15, n16 : std_logic;

begin
   
   reg_s_regx7x : DFEC1 port map( D => data_i(7), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(7), QN => n9);
   reg_s_regx6x : DFEC1 port map( D => data_i(6), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(6), QN => n10);
   reg_s_regx5x : DFEC1 port map( D => data_i(5), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(5), QN => n11);
   reg_s_regx4x : DFEC1 port map( D => data_i(4), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(4), QN => n12);
   reg_s_regx3x : DFEC1 port map( D => data_i(3), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(3), QN => n13);
   reg_s_regx2x : DFEC1 port map( D => data_i(2), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(2), QN => n14);
   reg_s_regx1x : DFEC1 port map( D => data_i(1), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(1), QN => n15);
   reg_s_regx0x : DFEC1 port map( D => data_i(0), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(0), QN => n16);

end SYN_reg_arch;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_FILTRE.all;

entity reg_2 is

   port( clk_i, clk_en_i, resetb_i : in std_logic;  data_i : in 
         std_logic_vector (7 downto 0);  data_o : out std_logic_vector (7 
         downto 0));

end reg_2;

architecture SYN_reg_arch of reg_2 is

   component DFEC1
      port( D, E, C, RN : in std_logic;  Q, QN : out std_logic);
   end component;
   
   signal n9, n10, n11, n12, n13, n14, n15, n16 : std_logic;

begin
   
   reg_s_regx7x : DFEC1 port map( D => data_i(7), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(7), QN => n9);
   reg_s_regx6x : DFEC1 port map( D => data_i(6), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(6), QN => n10);
   reg_s_regx5x : DFEC1 port map( D => data_i(5), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(5), QN => n11);
   reg_s_regx4x : DFEC1 port map( D => data_i(4), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(4), QN => n12);
   reg_s_regx3x : DFEC1 port map( D => data_i(3), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(3), QN => n13);
   reg_s_regx2x : DFEC1 port map( D => data_i(2), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(2), QN => n14);
   reg_s_regx1x : DFEC1 port map( D => data_i(1), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(1), QN => n15);
   reg_s_regx0x : DFEC1 port map( D => data_i(0), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(0), QN => n16);

end SYN_reg_arch;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_FILTRE.all;

entity reg_1 is

   port( clk_i, clk_en_i, resetb_i : in std_logic;  data_i : in 
         std_logic_vector (7 downto 0);  data_o : out std_logic_vector (7 
         downto 0));

end reg_1;

architecture SYN_reg_arch of reg_1 is

   component DFEC1
      port( D, E, C, RN : in std_logic;  Q, QN : out std_logic);
   end component;
   
   signal n9, n10, n11, n12, n13, n14, n15, n16 : std_logic;

begin
   
   reg_s_regx7x : DFEC1 port map( D => data_i(7), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(7), QN => n9);
   reg_s_regx6x : DFEC1 port map( D => data_i(6), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(6), QN => n10);
   reg_s_regx5x : DFEC1 port map( D => data_i(5), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(5), QN => n11);
   reg_s_regx4x : DFEC1 port map( D => data_i(4), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(4), QN => n12);
   reg_s_regx3x : DFEC1 port map( D => data_i(3), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(3), QN => n13);
   reg_s_regx2x : DFEC1 port map( D => data_i(2), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(2), QN => n14);
   reg_s_regx1x : DFEC1 port map( D => data_i(1), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(1), QN => n15);
   reg_s_regx0x : DFEC1 port map( D => data_i(0), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(0), QN => n16);

end SYN_reg_arch;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_FILTRE.all;

entity reg_0 is

   port( clk_i, clk_en_i, resetb_i : in std_logic;  data_i : in 
         std_logic_vector (7 downto 0);  data_o : out std_logic_vector (7 
         downto 0));

end reg_0;

architecture SYN_reg_arch of reg_0 is

   component DFEC1
      port( D, E, C, RN : in std_logic;  Q, QN : out std_logic);
   end component;
   
   signal n1, n2, n3, n4, n5, n6, n7, n8 : std_logic;

begin
   
   reg_s_regx7x : DFEC1 port map( D => data_i(7), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(7), QN => n8);
   reg_s_regx6x : DFEC1 port map( D => data_i(6), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(6), QN => n7);
   reg_s_regx5x : DFEC1 port map( D => data_i(5), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(5), QN => n6);
   reg_s_regx4x : DFEC1 port map( D => data_i(4), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(4), QN => n5);
   reg_s_regx3x : DFEC1 port map( D => data_i(3), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(3), QN => n4);
   reg_s_regx2x : DFEC1 port map( D => data_i(2), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(2), QN => n3);
   reg_s_regx1x : DFEC1 port map( D => data_i(1), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(1), QN => n2);
   reg_s_regx0x : DFEC1 port map( D => data_i(0), E => clk_en_i, C => clk_i, RN
                           => resetb_i, Q => data_o(0), QN => n1);

end SYN_reg_arch;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_FILTRE.all;

entity mul is

   port( a_i, b_i : in std_logic_vector (7 downto 0);  mul_o : out 
         std_logic_vector (15 downto 0));

end mul;

architecture SYN_mul_arch of mul is

   component mul_DW_mult_uns_0
      port( a, b : in std_logic_vector (7 downto 0);  product : out 
            std_logic_vector (15 downto 0));
   end component;

begin
   
   mult_18 : mul_DW_mult_uns_0 port map( a(7) => a_i(7), a(6) => a_i(6), a(5) 
                           => a_i(5), a(4) => a_i(4), a(3) => a_i(3), a(2) => 
                           a_i(2), a(1) => a_i(1), a(0) => a_i(0), b(7) => 
                           b_i(7), b(6) => b_i(6), b(5) => b_i(5), b(4) => 
                           b_i(4), b(3) => b_i(3), b(2) => b_i(2), b(1) => 
                           b_i(1), b(0) => b_i(0), product(15) => mul_o(15), 
                           product(14) => mul_o(14), product(13) => mul_o(13), 
                           product(12) => mul_o(12), product(11) => mul_o(11), 
                           product(10) => mul_o(10), product(9) => mul_o(9), 
                           product(8) => mul_o(8), product(7) => mul_o(7), 
                           product(6) => mul_o(6), product(5) => mul_o(5), 
                           product(4) => mul_o(4), product(3) => mul_o(3), 
                           product(2) => mul_o(2), product(1) => mul_o(1), 
                           product(0) => mul_o(0));

end SYN_mul_arch;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_FILTRE.all;

entity rom is

   port( add_i : in std_logic_vector (1 downto 0);  data_o : out 
         std_logic_vector (7 downto 0));

end rom;

architecture SYN_rom_arch of rom is

   component NAND20
      port( A, B : in std_logic;  Q : out std_logic);
   end component;
   
   component OAI210
      port( A, B, C : in std_logic;  Q : out std_logic);
   end component;
   
   component CLKIN0
      port( A : in std_logic;  Q : out std_logic);
   end component;
   
   signal data_o_6_port, data_o_7_port, data_o_4_port : std_logic;

begin
   data_o <= ( data_o_7_port, data_o_6_port, data_o_7_port, data_o_4_port, 
      data_o_7_port, data_o_6_port, data_o_7_port, data_o_4_port );
   
   U1 : CLKIN0 port map( A => add_i(1), Q => data_o_6_port);
   U2 : OAI210 port map( A => add_i(1), B => add_i(0), C => data_o_4_port, Q =>
                           data_o_7_port);
   U3 : NAND20 port map( A => add_i(0), B => add_i(1), Q => data_o_4_port);

end SYN_rom_arch;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_FILTRE.all;

entity dl_N_g4 is

   port( clk_i, resetb_i : in std_logic;  ctrl_i : in std_logic_vector (1 
         downto 0);  en_i : in std_logic;  dl_data_i : in std_logic_vector (7 
         downto 0);  dl_data_o : out std_logic_vector (7 downto 0));

end dl_N_g4;

architecture SYN_dl_arch of dl_N_g4 is

   component reg_1
      port( clk_i, clk_en_i, resetb_i : in std_logic;  data_i : in 
            std_logic_vector (7 downto 0);  data_o : out std_logic_vector (7 
            downto 0));
   end component;
   
   component reg_2
      port( clk_i, clk_en_i, resetb_i : in std_logic;  data_i : in 
            std_logic_vector (7 downto 0);  data_o : out std_logic_vector (7 
            downto 0));
   end component;
   
   component reg_3
      port( clk_i, clk_en_i, resetb_i : in std_logic;  data_i : in 
            std_logic_vector (7 downto 0);  data_o : out std_logic_vector (7 
            downto 0));
   end component;
   
   component reg_4
      port( clk_i, clk_en_i, resetb_i : in std_logic;  data_i : in 
            std_logic_vector (7 downto 0);  data_o : out std_logic_vector (7 
            downto 0));
   end component;
   
   component CLKIN0
      port( A : in std_logic;  Q : out std_logic);
   end component;
   
   component NOR20
      port( A, B : in std_logic;  Q : out std_logic);
   end component;
   
   component AOI220
      port( A, B, C, D : in std_logic;  Q : out std_logic);
   end component;
   
   component NAND20
      port( A, B : in std_logic;  Q : out std_logic);
   end component;
   
   signal inter_s : std_logic_vector(31 downto 0);
   
   signal n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16
      , n17, n18, n19, n20, n21, n22 : std_logic;

begin
   
   U1 : NAND20 port map( A => n1, B => n2, Q => dl_data_o(7));
   U2 : AOI220 port map( A => inter_s(7), B => n3, C => inter_s(15), D => n4, Q
                           => n2);
   U3 : AOI220 port map( A => inter_s(23), B => n5, C => inter_s(31), D => n6, 
                           Q => n1);
   U4 : NAND20 port map( A => n7, B => n8, Q => dl_data_o(6));
   U5 : AOI220 port map( A => inter_s(6), B => n3, C => inter_s(14), D => n4, Q
                           => n8);
   U6 : AOI220 port map( A => inter_s(22), B => n5, C => inter_s(30), D => n6, 
                           Q => n7);
   U7 : NAND20 port map( A => n9, B => n10, Q => dl_data_o(5));
   U8 : AOI220 port map( A => inter_s(5), B => n3, C => inter_s(13), D => n4, Q
                           => n10);
   U9 : AOI220 port map( A => inter_s(21), B => n5, C => inter_s(29), D => n6, 
                           Q => n9);
   U10 : NAND20 port map( A => n11, B => n12, Q => dl_data_o(4));
   U11 : AOI220 port map( A => inter_s(4), B => n3, C => inter_s(12), D => n4, 
                           Q => n12);
   U12 : AOI220 port map( A => inter_s(20), B => n5, C => inter_s(28), D => n6,
                           Q => n11);
   U13 : NAND20 port map( A => n13, B => n14, Q => dl_data_o(3));
   U14 : AOI220 port map( A => inter_s(3), B => n3, C => inter_s(11), D => n4, 
                           Q => n14);
   U15 : AOI220 port map( A => inter_s(19), B => n5, C => inter_s(27), D => n6,
                           Q => n13);
   U16 : NAND20 port map( A => n15, B => n16, Q => dl_data_o(2));
   U17 : AOI220 port map( A => inter_s(2), B => n3, C => inter_s(10), D => n4, 
                           Q => n16);
   U18 : AOI220 port map( A => inter_s(18), B => n5, C => inter_s(26), D => n6,
                           Q => n15);
   U19 : NAND20 port map( A => n17, B => n18, Q => dl_data_o(1));
   U20 : AOI220 port map( A => inter_s(1), B => n3, C => inter_s(9), D => n4, Q
                           => n18);
   U21 : AOI220 port map( A => inter_s(17), B => n5, C => inter_s(25), D => n6,
                           Q => n17);
   U22 : NAND20 port map( A => n19, B => n20, Q => dl_data_o(0));
   U23 : AOI220 port map( A => inter_s(0), B => n3, C => inter_s(8), D => n4, Q
                           => n20);
   U24 : NOR20 port map( A => n21, B => ctrl_i(0), Q => n4);
   U25 : NOR20 port map( A => n21, B => n22, Q => n3);
   U26 : CLKIN0 port map( A => ctrl_i(1), Q => n21);
   U27 : AOI220 port map( A => inter_s(16), B => n5, C => inter_s(24), D => n6,
                           Q => n19);
   U28 : NOR20 port map( A => ctrl_i(0), B => ctrl_i(1), Q => n6);
   U29 : NOR20 port map( A => n22, B => ctrl_i(1), Q => n5);
   U30 : CLKIN0 port map( A => ctrl_i(0), Q => n22);
   first : reg_4 port map( clk_i => clk_i, clk_en_i => en_i, resetb_i => 
                           resetb_i, data_i(7) => dl_data_i(7), data_i(6) => 
                           dl_data_i(6), data_i(5) => dl_data_i(5), data_i(4) 
                           => dl_data_i(4), data_i(3) => dl_data_i(3), 
                           data_i(2) => dl_data_i(2), data_i(1) => dl_data_i(1)
                           , data_i(0) => dl_data_i(0), data_o(7) => 
                           inter_s(31), data_o(6) => inter_s(30), data_o(5) => 
                           inter_s(29), data_o(4) => inter_s(28), data_o(3) => 
                           inter_s(27), data_o(2) => inter_s(26), data_o(1) => 
                           inter_s(25), data_o(0) => inter_s(24));
   inter_1 : reg_3 port map( clk_i => clk_i, clk_en_i => en_i, resetb_i => 
                           resetb_i, data_i(7) => inter_s(31), data_i(6) => 
                           inter_s(30), data_i(5) => inter_s(29), data_i(4) => 
                           inter_s(28), data_i(3) => inter_s(27), data_i(2) => 
                           inter_s(26), data_i(1) => inter_s(25), data_i(0) => 
                           inter_s(24), data_o(7) => inter_s(23), data_o(6) => 
                           inter_s(22), data_o(5) => inter_s(21), data_o(4) => 
                           inter_s(20), data_o(3) => inter_s(19), data_o(2) => 
                           inter_s(18), data_o(1) => inter_s(17), data_o(0) => 
                           inter_s(16));
   inter_2 : reg_2 port map( clk_i => clk_i, clk_en_i => en_i, resetb_i => 
                           resetb_i, data_i(7) => inter_s(23), data_i(6) => 
                           inter_s(22), data_i(5) => inter_s(21), data_i(4) => 
                           inter_s(20), data_i(3) => inter_s(19), data_i(2) => 
                           inter_s(18), data_i(1) => inter_s(17), data_i(0) => 
                           inter_s(16), data_o(7) => inter_s(15), data_o(6) => 
                           inter_s(14), data_o(5) => inter_s(13), data_o(4) => 
                           inter_s(12), data_o(3) => inter_s(11), data_o(2) => 
                           inter_s(10), data_o(1) => inter_s(9), data_o(0) => 
                           inter_s(8));
   inter_3 : reg_1 port map( clk_i => clk_i, clk_en_i => en_i, resetb_i => 
                           resetb_i, data_i(7) => inter_s(15), data_i(6) => 
                           inter_s(14), data_i(5) => inter_s(13), data_i(4) => 
                           inter_s(12), data_i(3) => inter_s(11), data_i(2) => 
                           inter_s(10), data_i(1) => inter_s(9), data_i(0) => 
                           inter_s(8), data_o(7) => inter_s(7), data_o(6) => 
                           inter_s(6), data_o(5) => inter_s(5), data_o(4) => 
                           inter_s(4), data_o(3) => inter_s(3), data_o(2) => 
                           inter_s(2), data_o(1) => inter_s(1), data_o(0) => 
                           inter_s(0));

end SYN_dl_arch;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_FILTRE.all;

entity cpt is

   port( clk_i, resetb_i, en_i, init_i : in std_logic;  cpt_o : out 
         std_logic_vector (2 downto 0));

end cpt;

architecture SYN_cpt_arch of cpt is

   component NAND20
      port( A, B : in std_logic;  Q : out std_logic);
   end component;
   
   component XOR20
      port( A, B : in std_logic;  Q : out std_logic);
   end component;
   
   component NOR20
      port( A, B : in std_logic;  Q : out std_logic);
   end component;
   
   component XNR20
      port( A, B : in std_logic;  Q : out std_logic);
   end component;
   
   component DFEC1
      port( D, E, C, RN : in std_logic;  Q, QN : out std_logic);
   end component;
   
   signal cpt_o_port : std_logic_vector(2 downto 0);
   
   signal N8, N9, N10, n1, n2, n3, n4, n5, n6 : std_logic;

begin
   cpt_o <= ( cpt_o_port(2), cpt_o_port(1), cpt_o_port(0) );
   
   cpt_s_regx0x : DFEC1 port map( D => N8, E => en_i, C => clk_i, RN => 
                           resetb_i, Q => cpt_o_port(0), QN => n3);
   cpt_s_regx1x : DFEC1 port map( D => N9, E => en_i, C => clk_i, RN => 
                           resetb_i, Q => cpt_o_port(1), QN => n2);
   cpt_s_regx2x : DFEC1 port map( D => N10, E => en_i, C => clk_i, RN => 
                           resetb_i, Q => cpt_o_port(2), QN => n1);
   U3 : NOR20 port map( A => init_i, B => n4, Q => N9);
   U4 : XNR20 port map( A => cpt_o_port(1), B => cpt_o_port(0), Q => n4);
   U5 : NOR20 port map( A => init_i, B => cpt_o_port(0), Q => N8);
   U6 : NOR20 port map( A => init_i, B => n5, Q => N10);
   U7 : XOR20 port map( A => cpt_o_port(2), B => n6, Q => n5);
   U8 : NAND20 port map( A => cpt_o_port(1), B => cpt_o_port(0), Q => n6);

end SYN_cpt_arch;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_FILTRE.all;

entity fsm is

   port( clk_i, resetb_i, adc_busy_i : in std_logic;  adc_convstb_o, 
         adc_rd_csb_o : out std_logic;  cpt_i : in std_logic_vector (2 downto 
         0);  cpt_en_o, cpt_init_o, Delay_line_sample_shift_o, Accu_ctrl_o, 
         Buff_oe_o : out std_logic;  Rom_and_delay_line_addr_o : out 
         std_logic_vector (1 downto 0));

end fsm;

architecture SYN_fsm_arch of fsm is

   component NOR22
      port( A, B : in std_logic;  Q : out std_logic);
   end component;
   
   component NAND20
      port( A, B : in std_logic;  Q : out std_logic);
   end component;
   
   component NOR20
      port( A, B : in std_logic;  Q : out std_logic);
   end component;
   
   component CLKIN0
      port( A : in std_logic;  Q : out std_logic);
   end component;
   
   component AOI2110
      port( A, B, C, D : in std_logic;  Q : out std_logic);
   end component;
   
   component NAND30
      port( A, B, C : in std_logic;  Q : out std_logic);
   end component;
   
   component OAI2110
      port( A, B, C, D : in std_logic;  Q : out std_logic);
   end component;
   
   component OAI210
      port( A, B, C : in std_logic;  Q : out std_logic);
   end component;
   
   component TFEC1
      port( T, C, RN : in std_logic;  Q, QN : out std_logic);
   end component;
   
   component DFC1
      port( D, C, RN : in std_logic;  Q, QN : out std_logic);
   end component;
   
   component DFC3
      port( D, C, RN : in std_logic;  Q, QN : out std_logic);
   end component;
   
   signal cpt_init_o_port, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, 
      n16, n17, n18, n19 : std_logic;
   
   signal Etat_present : std_logic_vector(2 downto 0);
   
   signal Etat_futur : std_logic_vector(1 downto 0);

begin
   cpt_init_o <= cpt_init_o_port;
   Rom_and_delay_line_addr_o <= ( cpt_i(1), cpt_i(0) );
   
   Etat_present_regx0x : DFC3 port map( D => Etat_futur(0), C => clk_i, RN => 
                           resetb_i, Q => Etat_present(0), QN => n18);
   Etat_present_regx1x : DFC1 port map( D => Etat_futur(1), C => clk_i, RN => 
                           resetb_i, Q => Etat_present(1), QN => n17);
   Etat_present_regx2x : TFEC1 port map( T => n7, C => clk_i, RN => resetb_i, Q
                           => Etat_present(2), QN => n9);
   U3 : CLKIN0 port map( A => n5, Q => cpt_en_o);
   U4 : NOR20 port map( A => cpt_init_o_port, B => n6, Q => n5);
   U5 : NOR20 port map( A => n7, B => Etat_present(2), Q => cpt_init_o_port);
   U6 : NOR20 port map( A => Etat_present(2), B => n8, Q => adc_convstb_o);
   U7 : NOR20 port map( A => n10, B => Etat_present(2), Q => adc_rd_csb_o);
   U8 : OAI210 port map( A => n11, B => n12, C => n8, Q => Etat_futur(1));
   U9 : NOR20 port map( A => Etat_present(2), B => n13, Q => n11);
   U10 : OAI2110 port map( A => n14, B => n12, C => n15, D => n16, Q => 
                           Etat_futur(0));
   U11 : NAND30 port map( A => n17, B => n13, C => n18, Q => n15);
   U12 : CLKIN0 port map( A => adc_busy_i, Q => n13);
   U13 : AOI2110 port map( A => cpt_i(1), B => cpt_i(0), C => n9, D => cpt_i(2)
                           , Q => n14);
   U15 : CLKIN0 port map( A => n10, Q => n7);
   U16 : NOR20 port map( A => n10, B => n16, Q => Buff_oe_o);
   U17 : NAND20 port map( A => Etat_present(2), B => n19, Q => n16);
   U18 : CLKIN0 port map( A => n6, Q => n19);
   U19 : NAND20 port map( A => n8, B => n12, Q => n6);
   U20 : NAND20 port map( A => Etat_present(1), B => n18, Q => n12);
   U21 : NAND20 port map( A => Etat_present(1), B => Etat_present(0), Q => n10)
                           ;
   U22 : NOR20 port map( A => n8, B => n9, Q => Accu_ctrl_o);
   U23 : NAND20 port map( A => Etat_present(0), B => n17, Q => n8);
   U14 : NOR22 port map( A => n7, B => n16, Q => Delay_line_sample_shift_o);

end SYN_fsm_arch;

library IEEE;

use IEEE.std_logic_1164.all;

use work.CONV_PACK_FILTRE.all;

entity FILTRE is

   port( Filter_IN_i : in std_logic_vector (7 downto 0);  clk_i, Resetb_i, 
         ADC_Busy_i : in std_logic;  Filter_out_o : out std_logic_vector (7 
         downto 0);  ADC_Convstb_o, ADC_Rd_csb_o : out std_logic);

end FILTRE;

architecture SYN_filtre_arch of FILTRE is

   component reg_0
      port( clk_i, clk_en_i, resetb_i : in std_logic;  data_i : in 
            std_logic_vector (7 downto 0);  data_o : out std_logic_vector (7 
            downto 0));
   end component;
   
   component accu
      port( clk_i, resetb_i : in std_logic;  data_i : in std_logic_vector (15 
            downto 0);  ctrl_i : in std_logic;  data_o : out std_logic_vector 
            (16 downto 0));
   end component;
   
   component mul
      port( a_i, b_i : in std_logic_vector (7 downto 0);  mul_o : out 
            std_logic_vector (15 downto 0));
   end component;
   
   component rom
      port( add_i : in std_logic_vector (1 downto 0);  data_o : out 
            std_logic_vector (7 downto 0));
   end component;
   
   component dl_N_g4
      port( clk_i, resetb_i : in std_logic;  ctrl_i : in std_logic_vector (1 
            downto 0);  en_i : in std_logic;  dl_data_i : in std_logic_vector 
            (7 downto 0);  dl_data_o : out std_logic_vector (7 downto 0));
   end component;
   
   component cpt
      port( clk_i, resetb_i, en_i, init_i : in std_logic;  cpt_o : out 
            std_logic_vector (2 downto 0));
   end component;
   
   component fsm
      port( clk_i, resetb_i, adc_busy_i : in std_logic;  adc_convstb_o, 
            adc_rd_csb_o : out std_logic;  cpt_i : in std_logic_vector (2 
            downto 0);  cpt_en_o, cpt_init_o, Delay_line_sample_shift_o, 
            Accu_ctrl_o, Buff_oe_o : out std_logic;  Rom_and_delay_line_addr_o 
            : out std_logic_vector (1 downto 0));
   end component;
   
   signal cpt_s : std_logic_vector(2 downto 0);
   
   signal cpt_en_s, cpt_init_s, Delay_line_sample_shift_s, Accu_ctrl_s, 
      Buff_oe_s, n_1000, n_1001, n_1002, n_1003, n_1004, n_1005, n_1006, n_1007
      , n_1008 : std_logic;
   
   signal Rom_and_delay_line_addr_s : std_logic_vector(1 downto 0);
   
   signal delay_line_data_s, rom_data_s : std_logic_vector(7 downto 0);
   
   signal mul_res_data_s : std_logic_vector(15 downto 0);
   
   signal accu_s : std_logic_vector(16 downto 9);

begin
   
   fsm_1 : fsm port map( clk_i => clk_i, resetb_i => Resetb_i, adc_busy_i => 
                           ADC_Busy_i, adc_convstb_o => ADC_Convstb_o, 
                           adc_rd_csb_o => ADC_Rd_csb_o, cpt_i(2) => cpt_s(2), 
                           cpt_i(1) => cpt_s(1), cpt_i(0) => cpt_s(0), cpt_en_o
                           => cpt_en_s, cpt_init_o => cpt_init_s, 
                           Delay_line_sample_shift_o => 
                           Delay_line_sample_shift_s, Accu_ctrl_o => 
                           Accu_ctrl_s, Buff_oe_o => Buff_oe_s, 
                           Rom_and_delay_line_addr_o(1) => 
                           Rom_and_delay_line_addr_s(1), 
                           Rom_and_delay_line_addr_o(0) => 
                           Rom_and_delay_line_addr_s(0));
   cpt_1 : cpt port map( clk_i => clk_i, resetb_i => Resetb_i, en_i => cpt_en_s
                           , init_i => cpt_init_s, cpt_o(2) => cpt_s(2), 
                           cpt_o(1) => cpt_s(1), cpt_o(0) => cpt_s(0));
   dl_1 : dl_N_g4 port map( clk_i => clk_i, resetb_i => Resetb_i, ctrl_i(1) => 
                           Rom_and_delay_line_addr_s(1), ctrl_i(0) => 
                           Rom_and_delay_line_addr_s(0), en_i => 
                           Delay_line_sample_shift_s, dl_data_i(7) => 
                           Filter_IN_i(7), dl_data_i(6) => Filter_IN_i(6), 
                           dl_data_i(5) => Filter_IN_i(5), dl_data_i(4) => 
                           Filter_IN_i(4), dl_data_i(3) => Filter_IN_i(3), 
                           dl_data_i(2) => Filter_IN_i(2), dl_data_i(1) => 
                           Filter_IN_i(1), dl_data_i(0) => Filter_IN_i(0), 
                           dl_data_o(7) => delay_line_data_s(7), dl_data_o(6) 
                           => delay_line_data_s(6), dl_data_o(5) => 
                           delay_line_data_s(5), dl_data_o(4) => 
                           delay_line_data_s(4), dl_data_o(3) => 
                           delay_line_data_s(3), dl_data_o(2) => 
                           delay_line_data_s(2), dl_data_o(1) => 
                           delay_line_data_s(1), dl_data_o(0) => 
                           delay_line_data_s(0));
   rom_f : rom port map( add_i(1) => Rom_and_delay_line_addr_s(1), add_i(0) => 
                           Rom_and_delay_line_addr_s(0), data_o(7) => 
                           rom_data_s(7), data_o(6) => rom_data_s(6), data_o(5)
                           => rom_data_s(5), data_o(4) => rom_data_s(4), 
                           data_o(3) => rom_data_s(3), data_o(2) => 
                           rom_data_s(2), data_o(1) => rom_data_s(1), data_o(0)
                           => rom_data_s(0));
   mul_f : mul port map( a_i(7) => delay_line_data_s(7), a_i(6) => 
                           delay_line_data_s(6), a_i(5) => delay_line_data_s(5)
                           , a_i(4) => delay_line_data_s(4), a_i(3) => 
                           delay_line_data_s(3), a_i(2) => delay_line_data_s(2)
                           , a_i(1) => delay_line_data_s(1), a_i(0) => 
                           delay_line_data_s(0), b_i(7) => rom_data_s(7), 
                           b_i(6) => rom_data_s(6), b_i(5) => rom_data_s(5), 
                           b_i(4) => rom_data_s(4), b_i(3) => rom_data_s(3), 
                           b_i(2) => rom_data_s(2), b_i(1) => rom_data_s(1), 
                           b_i(0) => rom_data_s(0), mul_o(15) => 
                           mul_res_data_s(15), mul_o(14) => mul_res_data_s(14),
                           mul_o(13) => mul_res_data_s(13), mul_o(12) => 
                           mul_res_data_s(12), mul_o(11) => mul_res_data_s(11),
                           mul_o(10) => mul_res_data_s(10), mul_o(9) => 
                           mul_res_data_s(9), mul_o(8) => mul_res_data_s(8), 
                           mul_o(7) => mul_res_data_s(7), mul_o(6) => 
                           mul_res_data_s(6), mul_o(5) => mul_res_data_s(5), 
                           mul_o(4) => mul_res_data_s(4), mul_o(3) => 
                           mul_res_data_s(3), mul_o(2) => mul_res_data_s(2), 
                           mul_o(1) => mul_res_data_s(1), mul_o(0) => 
                           mul_res_data_s(0));
   Accu_f : accu port map( clk_i => clk_i, resetb_i => Resetb_i, data_i(15) => 
                           mul_res_data_s(15), data_i(14) => mul_res_data_s(14)
                           , data_i(13) => mul_res_data_s(13), data_i(12) => 
                           mul_res_data_s(12), data_i(11) => mul_res_data_s(11)
                           , data_i(10) => mul_res_data_s(10), data_i(9) => 
                           mul_res_data_s(9), data_i(8) => mul_res_data_s(8), 
                           data_i(7) => mul_res_data_s(7), data_i(6) => 
                           mul_res_data_s(6), data_i(5) => mul_res_data_s(5), 
                           data_i(4) => mul_res_data_s(4), data_i(3) => 
                           mul_res_data_s(3), data_i(2) => mul_res_data_s(2), 
                           data_i(1) => mul_res_data_s(1), data_i(0) => 
                           mul_res_data_s(0), ctrl_i => Accu_ctrl_s, data_o(16)
                           => accu_s(16), data_o(15) => accu_s(15), data_o(14) 
                           => accu_s(14), data_o(13) => accu_s(13), data_o(12) 
                           => accu_s(12), data_o(11) => accu_s(11), data_o(10) 
                           => accu_s(10), data_o(9) => accu_s(9), data_o(8) => 
                           n_1000, data_o(7) => n_1001, data_o(6) => n_1002, 
                           data_o(5) => n_1003, data_o(4) => n_1004, data_o(3) 
                           => n_1005, data_o(2) => n_1006, data_o(1) => n_1007,
                           data_o(0) => n_1008);
   reg_1 : reg_0 port map( clk_i => clk_i, clk_en_i => Buff_oe_s, resetb_i => 
                           Resetb_i, data_i(7) => accu_s(16), data_i(6) => 
                           accu_s(15), data_i(5) => accu_s(14), data_i(4) => 
                           accu_s(13), data_i(3) => accu_s(12), data_i(2) => 
                           accu_s(11), data_i(1) => accu_s(10), data_i(0) => 
                           accu_s(9), data_o(7) => Filter_out_o(7), data_o(6) 
                           => Filter_out_o(6), data_o(5) => Filter_out_o(5), 
                           data_o(4) => Filter_out_o(4), data_o(3) => 
                           Filter_out_o(3), data_o(2) => Filter_out_o(2), 
                           data_o(1) => Filter_out_o(1), data_o(0) => 
                           Filter_out_o(0));

end SYN_filtre_arch;
