
module fsm ( clk_i, resetb_i, adc_busy_i, adc_convstb_o, adc_rd_csb_o, cpt_i, 
        cpt_en_o, cpt_init_o, Delay_line_sample_shift_o, Accu_ctrl_o, 
        Buff_oe_o, Rom_and_delay_line_addr_o );
  input [2:0] cpt_i;
  output [1:0] Rom_and_delay_line_addr_o;
  input clk_i, resetb_i, adc_busy_i;
  output adc_convstb_o, adc_rd_csb_o, cpt_en_o, cpt_init_o,
         Delay_line_sample_shift_o, Accu_ctrl_o, Buff_oe_o;
  wire   n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19;
  wire   [2:0] Etat_present;
  wire   [1:0] Etat_futur;
  assign Rom_and_delay_line_addr_o[1] = cpt_i[1];
  assign Rom_and_delay_line_addr_o[0] = cpt_i[0];

  DFC3 Etat_present_regx0x ( .D(Etat_futur[0]), .C(clk_i), .RN(resetb_i), .Q(
        Etat_present[0]), .QN(n18) );
  DFC1 Etat_present_regx1x ( .D(Etat_futur[1]), .C(clk_i), .RN(resetb_i), .Q(
        Etat_present[1]), .QN(n17) );
  TFEC1 Etat_present_regx2x ( .T(n7), .C(clk_i), .RN(resetb_i), .Q(
        Etat_present[2]), .QN(n9) );
  CLKIN0 U3 ( .A(n5), .Q(cpt_en_o) );
  NOR20 U4 ( .A(cpt_init_o), .B(n6), .Q(n5) );
  NOR20 U5 ( .A(n7), .B(Etat_present[2]), .Q(cpt_init_o) );
  NOR20 U6 ( .A(Etat_present[2]), .B(n8), .Q(adc_convstb_o) );
  NOR20 U7 ( .A(n10), .B(Etat_present[2]), .Q(adc_rd_csb_o) );
  OAI210 U8 ( .A(n11), .B(n12), .C(n8), .Q(Etat_futur[1]) );
  NOR20 U9 ( .A(Etat_present[2]), .B(n13), .Q(n11) );
  OAI2110 U10 ( .A(n14), .B(n12), .C(n15), .D(n16), .Q(Etat_futur[0]) );
  NAND30 U11 ( .A(n17), .B(n13), .C(n18), .Q(n15) );
  CLKIN0 U12 ( .A(adc_busy_i), .Q(n13) );
  AOI2110 U13 ( .A(cpt_i[1]), .B(cpt_i[0]), .C(n9), .D(cpt_i[2]), .Q(n14) );
  CLKIN0 U15 ( .A(n10), .Q(n7) );
  NOR20 U16 ( .A(n10), .B(n16), .Q(Buff_oe_o) );
  NAND20 U17 ( .A(Etat_present[2]), .B(n19), .Q(n16) );
  CLKIN0 U18 ( .A(n6), .Q(n19) );
  NAND20 U19 ( .A(n8), .B(n12), .Q(n6) );
  NAND20 U20 ( .A(Etat_present[1]), .B(n18), .Q(n12) );
  NAND20 U21 ( .A(Etat_present[1]), .B(Etat_present[0]), .Q(n10) );
  NOR20 U22 ( .A(n8), .B(n9), .Q(Accu_ctrl_o) );
  NAND20 U23 ( .A(Etat_present[0]), .B(n17), .Q(n8) );
  NOR22 U14 ( .A(n7), .B(n16), .Q(Delay_line_sample_shift_o) );
endmodule


module cpt ( clk_i, resetb_i, en_i, init_i, cpt_o );
  output [2:0] cpt_o;
  input clk_i, resetb_i, en_i, init_i;
  wire   N8, N9, N10, n4, n5, n6;

  DFEC1 cpt_s_regx0x ( .D(N8), .E(en_i), .C(clk_i), .RN(resetb_i), .Q(cpt_o[0]) );
  DFEC1 cpt_s_regx1x ( .D(N9), .E(en_i), .C(clk_i), .RN(resetb_i), .Q(cpt_o[1]) );
  DFEC1 cpt_s_regx2x ( .D(N10), .E(en_i), .C(clk_i), .RN(resetb_i), .Q(
        cpt_o[2]) );
  NOR20 U3 ( .A(init_i), .B(n4), .Q(N9) );
  XNR20 U4 ( .A(cpt_o[1]), .B(cpt_o[0]), .Q(n4) );
  NOR20 U5 ( .A(init_i), .B(cpt_o[0]), .Q(N8) );
  NOR20 U6 ( .A(init_i), .B(n5), .Q(N10) );
  XOR20 U7 ( .A(cpt_o[2]), .B(n6), .Q(n5) );
  NAND20 U8 ( .A(cpt_o[1]), .B(cpt_o[0]), .Q(n6) );
endmodule


module reg_4 ( clk_i, clk_en_i, resetb_i, data_i, data_o );
  input [7:0] data_i;
  output [7:0] data_o;
  input clk_i, clk_en_i, resetb_i;


  DFEC1 reg_s_regx7x ( .D(data_i[7]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[7]) );
  DFEC1 reg_s_regx6x ( .D(data_i[6]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[6]) );
  DFEC1 reg_s_regx5x ( .D(data_i[5]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[5]) );
  DFEC1 reg_s_regx4x ( .D(data_i[4]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[4]) );
  DFEC1 reg_s_regx3x ( .D(data_i[3]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[3]) );
  DFEC1 reg_s_regx2x ( .D(data_i[2]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[2]) );
  DFEC1 reg_s_regx1x ( .D(data_i[1]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[1]) );
  DFEC1 reg_s_regx0x ( .D(data_i[0]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[0]) );
endmodule


module reg_3 ( clk_i, clk_en_i, resetb_i, data_i, data_o );
  input [7:0] data_i;
  output [7:0] data_o;
  input clk_i, clk_en_i, resetb_i;


  DFEC1 reg_s_regx7x ( .D(data_i[7]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[7]) );
  DFEC1 reg_s_regx6x ( .D(data_i[6]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[6]) );
  DFEC1 reg_s_regx5x ( .D(data_i[5]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[5]) );
  DFEC1 reg_s_regx4x ( .D(data_i[4]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[4]) );
  DFEC1 reg_s_regx3x ( .D(data_i[3]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[3]) );
  DFEC1 reg_s_regx2x ( .D(data_i[2]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[2]) );
  DFEC1 reg_s_regx1x ( .D(data_i[1]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[1]) );
  DFEC1 reg_s_regx0x ( .D(data_i[0]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[0]) );
endmodule


module reg_2 ( clk_i, clk_en_i, resetb_i, data_i, data_o );
  input [7:0] data_i;
  output [7:0] data_o;
  input clk_i, clk_en_i, resetb_i;


  DFEC1 reg_s_regx7x ( .D(data_i[7]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[7]) );
  DFEC1 reg_s_regx6x ( .D(data_i[6]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[6]) );
  DFEC1 reg_s_regx5x ( .D(data_i[5]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[5]) );
  DFEC1 reg_s_regx4x ( .D(data_i[4]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[4]) );
  DFEC1 reg_s_regx3x ( .D(data_i[3]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[3]) );
  DFEC1 reg_s_regx2x ( .D(data_i[2]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[2]) );
  DFEC1 reg_s_regx1x ( .D(data_i[1]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[1]) );
  DFEC1 reg_s_regx0x ( .D(data_i[0]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[0]) );
endmodule


module reg_1 ( clk_i, clk_en_i, resetb_i, data_i, data_o );
  input [7:0] data_i;
  output [7:0] data_o;
  input clk_i, clk_en_i, resetb_i;


  DFEC1 reg_s_regx7x ( .D(data_i[7]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[7]) );
  DFEC1 reg_s_regx6x ( .D(data_i[6]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[6]) );
  DFEC1 reg_s_regx5x ( .D(data_i[5]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[5]) );
  DFEC1 reg_s_regx4x ( .D(data_i[4]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[4]) );
  DFEC1 reg_s_regx3x ( .D(data_i[3]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[3]) );
  DFEC1 reg_s_regx2x ( .D(data_i[2]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[2]) );
  DFEC1 reg_s_regx1x ( .D(data_i[1]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[1]) );
  DFEC1 reg_s_regx0x ( .D(data_i[0]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[0]) );
endmodule


module dl_N_g4 ( clk_i, resetb_i, ctrl_i, en_i, dl_data_i, dl_data_o );
  input [1:0] ctrl_i;
  input [7:0] dl_data_i;
  output [7:0] dl_data_o;
  input clk_i, resetb_i, en_i;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22;
  wire   [31:0] inter_s;

  NAND20 U1 ( .A(n1), .B(n2), .Q(dl_data_o[7]) );
  AOI220 U2 ( .A(inter_s[7]), .B(n3), .C(inter_s[15]), .D(n4), .Q(n2) );
  AOI220 U3 ( .A(inter_s[23]), .B(n5), .C(inter_s[31]), .D(n6), .Q(n1) );
  NAND20 U4 ( .A(n7), .B(n8), .Q(dl_data_o[6]) );
  AOI220 U5 ( .A(inter_s[6]), .B(n3), .C(inter_s[14]), .D(n4), .Q(n8) );
  AOI220 U6 ( .A(inter_s[22]), .B(n5), .C(inter_s[30]), .D(n6), .Q(n7) );
  NAND20 U7 ( .A(n9), .B(n10), .Q(dl_data_o[5]) );
  AOI220 U8 ( .A(inter_s[5]), .B(n3), .C(inter_s[13]), .D(n4), .Q(n10) );
  AOI220 U9 ( .A(inter_s[21]), .B(n5), .C(inter_s[29]), .D(n6), .Q(n9) );
  NAND20 U10 ( .A(n11), .B(n12), .Q(dl_data_o[4]) );
  AOI220 U11 ( .A(inter_s[4]), .B(n3), .C(inter_s[12]), .D(n4), .Q(n12) );
  AOI220 U12 ( .A(inter_s[20]), .B(n5), .C(inter_s[28]), .D(n6), .Q(n11) );
  NAND20 U13 ( .A(n13), .B(n14), .Q(dl_data_o[3]) );
  AOI220 U14 ( .A(inter_s[3]), .B(n3), .C(inter_s[11]), .D(n4), .Q(n14) );
  AOI220 U15 ( .A(inter_s[19]), .B(n5), .C(inter_s[27]), .D(n6), .Q(n13) );
  NAND20 U16 ( .A(n15), .B(n16), .Q(dl_data_o[2]) );
  AOI220 U17 ( .A(inter_s[2]), .B(n3), .C(inter_s[10]), .D(n4), .Q(n16) );
  AOI220 U18 ( .A(inter_s[18]), .B(n5), .C(inter_s[26]), .D(n6), .Q(n15) );
  NAND20 U19 ( .A(n17), .B(n18), .Q(dl_data_o[1]) );
  AOI220 U20 ( .A(inter_s[1]), .B(n3), .C(inter_s[9]), .D(n4), .Q(n18) );
  AOI220 U21 ( .A(inter_s[17]), .B(n5), .C(inter_s[25]), .D(n6), .Q(n17) );
  NAND20 U22 ( .A(n19), .B(n20), .Q(dl_data_o[0]) );
  AOI220 U23 ( .A(inter_s[0]), .B(n3), .C(inter_s[8]), .D(n4), .Q(n20) );
  NOR20 U24 ( .A(n21), .B(ctrl_i[0]), .Q(n4) );
  NOR20 U25 ( .A(n21), .B(n22), .Q(n3) );
  CLKIN0 U26 ( .A(ctrl_i[1]), .Q(n21) );
  AOI220 U27 ( .A(inter_s[16]), .B(n5), .C(inter_s[24]), .D(n6), .Q(n19) );
  NOR20 U28 ( .A(ctrl_i[0]), .B(ctrl_i[1]), .Q(n6) );
  NOR20 U29 ( .A(n22), .B(ctrl_i[1]), .Q(n5) );
  CLKIN0 U30 ( .A(ctrl_i[0]), .Q(n22) );
  reg_4 first ( .clk_i(clk_i), .clk_en_i(en_i), .resetb_i(resetb_i), .data_i(
        dl_data_i), .data_o(inter_s[31:24]) );
  reg_3 inter_1 ( .clk_i(clk_i), .clk_en_i(en_i), .resetb_i(resetb_i), 
        .data_i(inter_s[31:24]), .data_o(inter_s[23:16]) );
  reg_2 inter_2 ( .clk_i(clk_i), .clk_en_i(en_i), .resetb_i(resetb_i), 
        .data_i(inter_s[23:16]), .data_o(inter_s[15:8]) );
  reg_1 inter_3 ( .clk_i(clk_i), .clk_en_i(en_i), .resetb_i(resetb_i), 
        .data_i(inter_s[15:8]), .data_o(inter_s[7:0]) );
endmodule


module rom ( add_i, data_o );
  input [1:0] add_i;
  output [7:0] data_o;

  assign data_o[2] = data_o[6];
  assign data_o[1] = data_o[7];
  assign data_o[3] = data_o[7];
  assign data_o[5] = data_o[7];
  assign data_o[0] = data_o[4];

  CLKIN0 U1 ( .A(add_i[1]), .Q(data_o[6]) );
  OAI210 U2 ( .A(add_i[1]), .B(add_i[0]), .C(data_o[4]), .Q(data_o[7]) );
  NAND20 U3 ( .A(add_i[0]), .B(add_i[1]), .Q(data_o[4]) );
endmodule


module mul_DW_mult_uns_0 ( a, b, product );
  input [7:0] a;
  input [7:0] b;
  output [15:0] product;
  wire   n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58,
         n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86,
         n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111,
         n112, n113, n114, n115, n116, n117, n118, n119, n120, n121, n122,
         n123, n124, n125, n126, n127, n128, n129, n130, n131, n132, n133,
         n134, n135, n136, n137, n138, n139, n140, n141, n142, n143, n144,
         n145, n146, n147, n148, n149, n150, n151, n152, n153, n154, n155,
         n156, n157, n158, n159, n160, n161, n214, n215, n216, n217, n218,
         n219, n220, n221, n222, n223, n224, n225, n226, n227, n228, n229;

  ADD32 U2 ( .A(n15), .B(n99), .CI(n2), .CO(product[15]), .S(product[14]) );
  ADD32 U3 ( .A(n17), .B(n16), .CI(n3), .CO(n2), .S(product[13]) );
  ADD32 U4 ( .A(n21), .B(n18), .CI(n4), .CO(n3), .S(product[12]) );
  ADD32 U5 ( .A(n22), .B(n27), .CI(n5), .CO(n4), .S(product[11]) );
  ADD32 U6 ( .A(n28), .B(n35), .CI(n6), .CO(n5), .S(product[10]) );
  ADD32 U7 ( .A(n36), .B(n45), .CI(n7), .CO(n6), .S(product[9]) );
  ADD32 U8 ( .A(n46), .B(n57), .CI(n8), .CO(n7), .S(product[8]) );
  ADD32 U9 ( .A(n58), .B(n69), .CI(n9), .CO(n8), .S(product[7]) );
  ADD32 U10 ( .A(n70), .B(n79), .CI(n10), .CO(n9), .S(product[6]) );
  ADD32 U11 ( .A(n80), .B(n87), .CI(n11), .CO(n10), .S(product[5]) );
  ADD32 U12 ( .A(n88), .B(n93), .CI(n12), .CO(n11), .S(product[4]) );
  ADD32 U13 ( .A(n13), .B(n96), .CI(n94), .CO(n12), .S(product[3]) );
  ADD32 U14 ( .A(n14), .B(n146), .CI(n98), .CO(n13), .S(product[2]) );
  ADD22 U15 ( .A(n161), .B(n154), .CO(n14), .S(product[1]) );
  ADD32 U16 ( .A(n100), .B(n107), .CI(n19), .CO(n15), .S(n16) );
  ADD32 U17 ( .A(n20), .B(n25), .CI(n23), .CO(n17), .S(n18) );
  ADD32 U18 ( .A(n101), .B(n115), .CI(n108), .CO(n19), .S(n20) );
  ADD32 U19 ( .A(n24), .B(n31), .CI(n29), .CO(n21), .S(n22) );
  ADD32 U20 ( .A(n33), .B(n116), .CI(n26), .CO(n23), .S(n24) );
  ADD32 U21 ( .A(n102), .B(n123), .CI(n109), .CO(n25), .S(n26) );
  ADD32 U22 ( .A(n37), .B(n39), .CI(n30), .CO(n27), .S(n28) );
  ADD32 U23 ( .A(n34), .B(n41), .CI(n32), .CO(n29), .S(n30) );
  ADD32 U24 ( .A(n117), .B(n124), .CI(n43), .CO(n31), .S(n32) );
  ADD32 U25 ( .A(n103), .B(n131), .CI(n110), .CO(n33), .S(n34) );
  ADD32 U26 ( .A(n47), .B(n40), .CI(n38), .CO(n35), .S(n36) );
  ADD32 U27 ( .A(n51), .B(n44), .CI(n49), .CO(n37), .S(n38) );
  ADD32 U28 ( .A(n53), .B(n55), .CI(n42), .CO(n39), .S(n40) );
  ADD32 U29 ( .A(n125), .B(n118), .CI(n132), .CO(n41), .S(n42) );
  ADD32 U30 ( .A(n104), .B(n139), .CI(n111), .CO(n43), .S(n44) );
  ADD32 U31 ( .A(n59), .B(n50), .CI(n48), .CO(n45), .S(n46) );
  ADD32 U32 ( .A(n61), .B(n54), .CI(n52), .CO(n47), .S(n48) );
  ADD32 U33 ( .A(n63), .B(n65), .CI(n56), .CO(n49), .S(n50) );
  ADD32 U34 ( .A(n133), .B(n140), .CI(n67), .CO(n51), .S(n52) );
  ADD32 U35 ( .A(n119), .B(n147), .CI(n126), .CO(n53), .S(n54) );
  ADD22 U36 ( .A(n105), .B(n112), .CO(n55), .S(n56) );
  ADD32 U37 ( .A(n62), .B(n71), .CI(n60), .CO(n57), .S(n58) );
  ADD32 U38 ( .A(n66), .B(n64), .CI(n73), .CO(n59), .S(n60) );
  ADD32 U39 ( .A(n75), .B(n77), .CI(n68), .CO(n61), .S(n62) );
  ADD32 U40 ( .A(n134), .B(n148), .CI(n141), .CO(n63), .S(n64) );
  ADD32 U41 ( .A(n120), .B(n155), .CI(n127), .CO(n65), .S(n66) );
  ADD22 U42 ( .A(n106), .B(n113), .CO(n67), .S(n68) );
  ADD32 U43 ( .A(n74), .B(n81), .CI(n72), .CO(n69), .S(n70) );
  ADD32 U44 ( .A(n78), .B(n83), .CI(n76), .CO(n71), .S(n72) );
  ADD32 U45 ( .A(n142), .B(n149), .CI(n85), .CO(n73), .S(n74) );
  ADD32 U46 ( .A(n128), .B(n156), .CI(n135), .CO(n75), .S(n76) );
  ADD22 U47 ( .A(n114), .B(n121), .CO(n77), .S(n78) );
  ADD32 U48 ( .A(n84), .B(n86), .CI(n82), .CO(n79), .S(n80) );
  ADD32 U49 ( .A(n91), .B(n150), .CI(n89), .CO(n81), .S(n82) );
  ADD32 U50 ( .A(n136), .B(n157), .CI(n143), .CO(n83), .S(n84) );
  ADD22 U51 ( .A(n122), .B(n129), .CO(n85), .S(n86) );
  ADD32 U52 ( .A(n92), .B(n95), .CI(n90), .CO(n87), .S(n88) );
  ADD32 U53 ( .A(n144), .B(n158), .CI(n151), .CO(n89), .S(n90) );
  ADD22 U54 ( .A(n130), .B(n137), .CO(n91), .S(n92) );
  ADD32 U55 ( .A(n152), .B(n159), .CI(n97), .CO(n93), .S(n94) );
  ADD22 U56 ( .A(n138), .B(n145), .CO(n95), .S(n96) );
  ADD22 U57 ( .A(n153), .B(n160), .CO(n97), .S(n98) );
  NOR20 U140 ( .A(n214), .B(n215), .Q(product[0]) );
  NOR20 U141 ( .A(n216), .B(n217), .Q(n99) );
  NOR20 U142 ( .A(n214), .B(n218), .Q(n161) );
  NOR20 U143 ( .A(n214), .B(n219), .Q(n160) );
  NOR20 U144 ( .A(n214), .B(n220), .Q(n159) );
  NOR20 U145 ( .A(n214), .B(n221), .Q(n158) );
  NOR20 U146 ( .A(n214), .B(n222), .Q(n157) );
  NOR20 U147 ( .A(n214), .B(n223), .Q(n156) );
  NOR20 U148 ( .A(n214), .B(n217), .Q(n155) );
  CLKIN0 U149 ( .A(a[0]), .Q(n214) );
  NOR20 U150 ( .A(n215), .B(n224), .Q(n154) );
  NOR20 U151 ( .A(n218), .B(n224), .Q(n153) );
  NOR20 U152 ( .A(n219), .B(n224), .Q(n152) );
  NOR20 U153 ( .A(n220), .B(n224), .Q(n151) );
  NOR20 U154 ( .A(n221), .B(n224), .Q(n150) );
  NOR20 U155 ( .A(n222), .B(n224), .Q(n149) );
  NOR20 U156 ( .A(n223), .B(n224), .Q(n148) );
  NOR20 U157 ( .A(n217), .B(n224), .Q(n147) );
  CLKIN0 U158 ( .A(a[1]), .Q(n224) );
  NOR20 U159 ( .A(n215), .B(n225), .Q(n146) );
  NOR20 U160 ( .A(n218), .B(n225), .Q(n145) );
  NOR20 U161 ( .A(n219), .B(n225), .Q(n144) );
  NOR20 U162 ( .A(n220), .B(n225), .Q(n143) );
  NOR20 U163 ( .A(n221), .B(n225), .Q(n142) );
  NOR20 U164 ( .A(n222), .B(n225), .Q(n141) );
  NOR20 U165 ( .A(n223), .B(n225), .Q(n140) );
  NOR20 U166 ( .A(n217), .B(n225), .Q(n139) );
  CLKIN0 U167 ( .A(a[2]), .Q(n225) );
  NOR20 U168 ( .A(n215), .B(n226), .Q(n138) );
  NOR20 U169 ( .A(n218), .B(n226), .Q(n137) );
  NOR20 U170 ( .A(n219), .B(n226), .Q(n136) );
  NOR20 U171 ( .A(n220), .B(n226), .Q(n135) );
  NOR20 U172 ( .A(n221), .B(n226), .Q(n134) );
  NOR20 U173 ( .A(n222), .B(n226), .Q(n133) );
  NOR20 U174 ( .A(n223), .B(n226), .Q(n132) );
  NOR20 U175 ( .A(n217), .B(n226), .Q(n131) );
  CLKIN0 U176 ( .A(a[3]), .Q(n226) );
  NOR20 U177 ( .A(n215), .B(n227), .Q(n130) );
  NOR20 U178 ( .A(n218), .B(n227), .Q(n129) );
  NOR20 U179 ( .A(n219), .B(n227), .Q(n128) );
  NOR20 U180 ( .A(n220), .B(n227), .Q(n127) );
  NOR20 U181 ( .A(n221), .B(n227), .Q(n126) );
  NOR20 U182 ( .A(n222), .B(n227), .Q(n125) );
  NOR20 U183 ( .A(n223), .B(n227), .Q(n124) );
  NOR20 U184 ( .A(n217), .B(n227), .Q(n123) );
  CLKIN0 U185 ( .A(a[4]), .Q(n227) );
  NOR20 U186 ( .A(n215), .B(n228), .Q(n122) );
  NOR20 U187 ( .A(n218), .B(n228), .Q(n121) );
  NOR20 U188 ( .A(n219), .B(n228), .Q(n120) );
  NOR20 U189 ( .A(n220), .B(n228), .Q(n119) );
  NOR20 U190 ( .A(n221), .B(n228), .Q(n118) );
  NOR20 U191 ( .A(n222), .B(n228), .Q(n117) );
  NOR20 U192 ( .A(n223), .B(n228), .Q(n116) );
  NOR20 U193 ( .A(n217), .B(n228), .Q(n115) );
  CLKIN0 U194 ( .A(a[5]), .Q(n228) );
  NOR20 U195 ( .A(n215), .B(n229), .Q(n114) );
  NOR20 U196 ( .A(n218), .B(n229), .Q(n113) );
  NOR20 U197 ( .A(n219), .B(n229), .Q(n112) );
  NOR20 U198 ( .A(n220), .B(n229), .Q(n111) );
  NOR20 U199 ( .A(n221), .B(n229), .Q(n110) );
  NOR20 U200 ( .A(n222), .B(n229), .Q(n109) );
  NOR20 U201 ( .A(n223), .B(n229), .Q(n108) );
  NOR20 U202 ( .A(n217), .B(n229), .Q(n107) );
  CLKIN0 U203 ( .A(a[6]), .Q(n229) );
  CLKIN0 U204 ( .A(b[7]), .Q(n217) );
  NOR20 U205 ( .A(n215), .B(n216), .Q(n106) );
  CLKIN0 U206 ( .A(b[0]), .Q(n215) );
  NOR20 U207 ( .A(n216), .B(n218), .Q(n105) );
  CLKIN0 U208 ( .A(b[1]), .Q(n218) );
  NOR20 U209 ( .A(n216), .B(n219), .Q(n104) );
  CLKIN0 U210 ( .A(b[2]), .Q(n219) );
  NOR20 U211 ( .A(n216), .B(n220), .Q(n103) );
  CLKIN0 U212 ( .A(b[3]), .Q(n220) );
  NOR20 U213 ( .A(n216), .B(n221), .Q(n102) );
  CLKIN0 U214 ( .A(b[4]), .Q(n221) );
  NOR20 U215 ( .A(n216), .B(n222), .Q(n101) );
  CLKIN0 U216 ( .A(b[5]), .Q(n222) );
  NOR20 U217 ( .A(n216), .B(n223), .Q(n100) );
  CLKIN0 U218 ( .A(b[6]), .Q(n223) );
  CLKIN0 U219 ( .A(a[7]), .Q(n216) );
endmodule


module mul ( a_i, b_i, mul_o );
  input [7:0] a_i;
  input [7:0] b_i;
  output [15:0] mul_o;


  mul_DW_mult_uns_0 mult_18 ( .a(a_i), .b(b_i), .product(mul_o) );
endmodule


module reg_0 ( clk_i, clk_en_i, resetb_i, data_i, data_o );
  input [7:0] data_i;
  output [7:0] data_o;
  input clk_i, clk_en_i, resetb_i;


  DFEC1 reg_s_regx7x ( .D(data_i[7]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[7]) );
  DFEC1 reg_s_regx6x ( .D(data_i[6]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[6]) );
  DFEC1 reg_s_regx5x ( .D(data_i[5]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[5]) );
  DFEC1 reg_s_regx4x ( .D(data_i[4]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[4]) );
  DFEC1 reg_s_regx3x ( .D(data_i[3]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[3]) );
  DFEC1 reg_s_regx2x ( .D(data_i[2]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[2]) );
  DFEC1 reg_s_regx1x ( .D(data_i[1]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[1]) );
  DFEC1 reg_s_regx0x ( .D(data_i[0]), .E(clk_en_i), .C(clk_i), .RN(resetb_i), 
        .Q(data_o[0]) );
endmodule


module FILTRE ( Filter_IN_i, clk_i, Resetb_i, ADC_Busy_i, Filter_out_o, 
        ADC_Convstb_o, ADC_Rd_csb_o );
  input [7:0] Filter_IN_i;
  output [7:0] Filter_out_o;
  input clk_i, Resetb_i, ADC_Busy_i;
  output ADC_Convstb_o, ADC_Rd_csb_o;
  wire   cpt_en_s, cpt_init_s, Delay_line_sample_shift_s, Accu_ctrl_s,
         Buff_oe_s;
  wire   [2:0] cpt_s;
  wire   [1:0] Rom_and_delay_line_addr_s;
  wire   [7:0] delay_line_data_s;
  wire   [7:0] rom_data_s;
  wire   [15:0] mul_res_data_s;
  wire   [16:9] accu_s;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7, 
        SYNOPSYS_UNCONNECTED__8;

  fsm fsm_1 ( .clk_i(clk_i), .resetb_i(Resetb_i), .adc_busy_i(ADC_Busy_i), 
        .adc_convstb_o(ADC_Convstb_o), .adc_rd_csb_o(ADC_Rd_csb_o), .cpt_i(
        cpt_s), .cpt_en_o(cpt_en_s), .cpt_init_o(cpt_init_s), 
        .Delay_line_sample_shift_o(Delay_line_sample_shift_s), .Accu_ctrl_o(
        Accu_ctrl_s), .Buff_oe_o(Buff_oe_s), .Rom_and_delay_line_addr_o(
        Rom_and_delay_line_addr_s) );
  cpt cpt_1 ( .clk_i(clk_i), .resetb_i(Resetb_i), .en_i(cpt_en_s), .init_i(
        cpt_init_s), .cpt_o(cpt_s) );
  dl_N_g4 dl_1 ( .clk_i(clk_i), .resetb_i(Resetb_i), .ctrl_i(
        Rom_and_delay_line_addr_s), .en_i(Delay_line_sample_shift_s), 
        .dl_data_i(Filter_IN_i), .dl_data_o(delay_line_data_s) );
  rom rom_f ( .add_i(Rom_and_delay_line_addr_s), .data_o(rom_data_s) );
  mul mul_f ( .a_i(delay_line_data_s), .b_i(rom_data_s), .mul_o(mul_res_data_s) );
  accu Accu_f ( .clk_i(clk_i), .resetb_i(Resetb_i), .data_i(mul_res_data_s), 
        .ctrl_i(Accu_ctrl_s), .data_o({accu_s, SYNOPSYS_UNCONNECTED__0, 
        SYNOPSYS_UNCONNECTED__1, SYNOPSYS_UNCONNECTED__2, 
        SYNOPSYS_UNCONNECTED__3, SYNOPSYS_UNCONNECTED__4, 
        SYNOPSYS_UNCONNECTED__5, SYNOPSYS_UNCONNECTED__6, 
        SYNOPSYS_UNCONNECTED__7, SYNOPSYS_UNCONNECTED__8}) );
  reg_0 reg_1 ( .clk_i(clk_i), .clk_en_i(Buff_oe_s), .resetb_i(Resetb_i), 
        .data_i(accu_s), .data_o(Filter_out_o) );
endmodule

