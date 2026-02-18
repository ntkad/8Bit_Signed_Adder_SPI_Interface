/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Fri Jan 30 16:37:18 2026
/////////////////////////////////////////////////////////////


module signed_adder8_core_DW01_add_0 ( A, B, CI, SUM, CO );
  input [7:0] A;
  input [7:0] B;
  output [7:0] SUM;
  input CI;
  output CO;
  wire   n1, n2;
  wire   [7:1] carry;

  ADDF_F U1_7 ( .A(A[7]), .B(B[7]), .CIN(carry[7]), .SUM(SUM[7]) );
  ADDF_F U1_6 ( .A(A[6]), .B(B[6]), .CIN(carry[6]), .COUT(carry[7]), .SUM(
        SUM[6]) );
  ADDF_F U1_5 ( .A(A[5]), .B(B[5]), .CIN(carry[5]), .COUT(carry[6]), .SUM(
        SUM[5]) );
  ADDF_F U1_4 ( .A(A[4]), .B(B[4]), .CIN(carry[4]), .COUT(carry[5]), .SUM(
        SUM[4]) );
  ADDF_F U1_3 ( .A(A[3]), .B(B[3]), .CIN(carry[3]), .COUT(carry[4]), .SUM(
        SUM[3]) );
  ADDF_F U1_2 ( .A(A[2]), .B(B[2]), .CIN(carry[2]), .COUT(carry[3]), .SUM(
        SUM[2]) );
  ADDF_F U1_1 ( .A(A[1]), .B(B[1]), .CIN(n2), .COUT(carry[2]), .SUM(SUM[1]) );
  INVERT_D U1 ( .A(carry[1]), .Z(n1) );
  INVERT_E U2 ( .A(n1), .Z(n2) );
  AND2_H U3 ( .A(A[0]), .B(B[0]), .Z(carry[1]) );
  XOR2_B U4 ( .A(A[0]), .B(B[0]), .Z(SUM[0]) );
endmodule


module signed_adder8_core ( clk, rst_n, input_a, input_b, adder_out, overflow, 
        underflow );
  input [7:0] input_a;
  input [7:0] input_b;
  output [7:0] adder_out;
  input clk, rst_n;
  output overflow, underflow;
  wire   ovf_comb, unf_comb, n1, n2, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n18, n19;
  wire   [7:0] a_reg;
  wire   [7:0] b_reg;
  wire   [7:0] sum_comb;

  DFFR_K \a_reg_reg[7]  ( .D(input_a[7]), .CLK(clk), .RN(n15), .Q(a_reg[7]), 
        .QBAR(n1) );
  DFFR_K \b_reg_reg[7]  ( .D(input_b[7]), .CLK(clk), .RN(n15), .Q(b_reg[7]), 
        .QBAR(n2) );
  DFFR_K \a_reg_reg[6]  ( .D(input_a[6]), .CLK(clk), .RN(n12), .Q(a_reg[6]) );
  DFFR_K \a_reg_reg[5]  ( .D(input_a[5]), .CLK(clk), .RN(n12), .Q(a_reg[5]) );
  DFFR_K \a_reg_reg[4]  ( .D(input_a[4]), .CLK(clk), .RN(n12), .Q(a_reg[4]) );
  DFFR_K \a_reg_reg[3]  ( .D(input_a[3]), .CLK(clk), .RN(n12), .Q(a_reg[3]) );
  DFFR_K \a_reg_reg[2]  ( .D(input_a[2]), .CLK(clk), .RN(n12), .Q(a_reg[2]) );
  DFFR_K \a_reg_reg[1]  ( .D(input_a[1]), .CLK(clk), .RN(n12), .Q(a_reg[1]) );
  DFFR_K \a_reg_reg[0]  ( .D(input_a[0]), .CLK(clk), .RN(n12), .QBAR(n5) );
  DFFR_K \b_reg_reg[6]  ( .D(input_b[6]), .CLK(clk), .RN(n13), .Q(b_reg[6]) );
  DFFR_K \b_reg_reg[5]  ( .D(input_b[5]), .CLK(clk), .RN(n13), .Q(b_reg[5]) );
  DFFR_K \b_reg_reg[4]  ( .D(input_b[4]), .CLK(clk), .RN(n13), .Q(b_reg[4]) );
  DFFR_K \b_reg_reg[3]  ( .D(input_b[3]), .CLK(clk), .RN(n13), .Q(b_reg[3]) );
  DFFR_K \b_reg_reg[2]  ( .D(input_b[2]), .CLK(clk), .RN(n13), .Q(b_reg[2]) );
  DFFR_K \b_reg_reg[1]  ( .D(input_b[1]), .CLK(clk), .RN(n13), .Q(b_reg[1]) );
  DFFR_K \b_reg_reg[0]  ( .D(input_b[0]), .CLK(clk), .RN(n13), .QBAR(n4) );
  DFFR_K underflow_reg ( .D(unf_comb), .CLK(clk), .RN(n14), .Q(underflow) );
  DFFR_K overflow_reg ( .D(ovf_comb), .CLK(clk), .RN(n14), .Q(overflow) );
  DFFR_K \adder_out_reg[7]  ( .D(sum_comb[7]), .CLK(clk), .RN(n14), .Q(
        adder_out[7]) );
  DFFR_K \adder_out_reg[6]  ( .D(sum_comb[6]), .CLK(clk), .RN(n14), .Q(
        adder_out[6]) );
  DFFR_K \adder_out_reg[5]  ( .D(sum_comb[5]), .CLK(clk), .RN(n14), .Q(
        adder_out[5]) );
  DFFR_K \adder_out_reg[4]  ( .D(sum_comb[4]), .CLK(clk), .RN(n14), .Q(
        adder_out[4]) );
  DFFR_K \adder_out_reg[3]  ( .D(sum_comb[3]), .CLK(clk), .RN(n14), .Q(
        adder_out[3]) );
  DFFR_K \adder_out_reg[2]  ( .D(sum_comb[2]), .CLK(clk), .RN(n15), .Q(
        adder_out[2]) );
  DFFR_K \adder_out_reg[1]  ( .D(sum_comb[1]), .CLK(clk), .RN(n15), .Q(
        adder_out[1]) );
  DFFR_K \adder_out_reg[0]  ( .D(sum_comb[0]), .CLK(clk), .RN(n15), .Q(
        adder_out[0]) );
  signed_adder8_core_DW01_add_0 add_165 ( .A({a_reg[7:1], n11}), .B({
        b_reg[7:1], n8}), .CI(1'b0), .SUM(sum_comb) );
  INVERT_H U3 ( .A(n2), .Z(n6) );
  INVERT_H U4 ( .A(n6), .Z(n7) );
  INVERT_H U6 ( .A(n4), .Z(n8) );
  INVERT_H U7 ( .A(n1), .Z(n9) );
  INVERT_H U8 ( .A(n9), .Z(n10) );
  INVERT_H U9 ( .A(n5), .Z(n11) );
  AND3_H U10 ( .A(n10), .B(sum_comb[7]), .C(n7), .Z(ovf_comb) );
  INVERT_J U11 ( .A(n19), .Z(n18) );
  INVERT_K U12 ( .A(n18), .Z(n17) );
  INVERT_K U13 ( .A(n18), .Z(n16) );
  INVERT_H U14 ( .A(rst_n), .Z(n19) );
  INVERT_M U15 ( .A(n16), .Z(n14) );
  INVERT_M U16 ( .A(n17), .Z(n13) );
  INVERT_M U17 ( .A(n17), .Z(n12) );
  INVERT_K U18 ( .A(n16), .Z(n15) );
  NOR3_B U19 ( .A(n10), .B(sum_comb[7]), .C(n7), .Z(unf_comb) );
endmodule


module signed_adder8 ( rst_n, SCLK, MOSI, CSN, MISO, MISO_enable );
  input rst_n, SCLK, MOSI, CSN;
  output MISO, MISO_enable;
  wire   N15, N16, N17, n375, \reg_input_a[4] , \reg_input_b[2] , core_ovf,
         core_unf, rw_bit, \reg_result[4] , N78, N88, N89, n9, n10, n11, n12,
         n15, n22, n23, n25, n28, n30, n34, n35, n37, n39, n42, n43, n44, n47,
         n50, n52, n53, n54, n56, n57, n58, n59, n61, n62, n63, n65, n66, n67,
         n68, n69, n71, n72, n74, n75, n77, n78, n79, n80, n81, n82, n83, n84,
         n85, n86, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99,
         n100, n101, n102, n103, n104, n105, n106, n107, n108, n109, n111,
         n112, n113, n114, n115, n116, n117, n118, n119, n120, n121, n122,
         n123, n124, n125, n126, n127, n128, n129, n130, n131, n132, n133,
         n134, n135, n136, n137, n138, n139, n140, n141, n142, n143, n144,
         n145, n146, n147, n148, n149, n150, n151, n152, n153, n154, n155,
         n156, n157, n158, n159, n160, n161, n162, n163, n164, n165, n166,
         n167, n168, n169, n170, n171, n172, n173, n174, n175, n176, n177,
         n178, n179, n180, n181, n182, n183, n184, n185, n186, n187, n188,
         n189, n190, n191, n192, n193, n194, n195, n196, n197, n198, n199,
         n200, n202, n203, n204, n205, n206, n207, n208, n209, n210, n211,
         n212, n213, n214, n215, n216, n217, n218, n219, n220, n221, n222,
         n223, n224, n225, n226, n227, n228, n229, n230, n231, n232, n233,
         n234, n235, n236, n237, n238, n239, n240, n241, n242, n243, n244,
         n245, n246, n247, n248, n249, n250, n251, n252, n253, n254, n255,
         n256, n257, n258, n259, n260, n261, n262, n263, n264, n265, n266,
         n267, n268, n269, n270, n271, n272, n273, n274, n275, n276, n277,
         n278, n279, n280, n281, n282, n283, n284, n285, n286, n287, n288,
         n289, n290, n291, n292, n293, n294, n295, n296, n297, n298, n299,
         n300, n301, n302, n303, n304, n305, n306, n307, n308, n309, n310,
         n311, n312, n313, n314, n315, n316, n317, n318, n319, n320, n321,
         n322, n323, n324, n325, n326, n327, n328, n329, n330, n331, n332,
         n333, n334, n335, n336, n337, n338, n339, n340, n341, n342, n343,
         n344, n345, n346, n347, n348, n349, n350, n351, n352, n353, n354,
         n355, n356, n357, n358, n359, n360, n361, n362, n363, n364, n365,
         n366, n367, n368, n369, n370, n371, n372, n373, n374;
  wire   [7:0] core_sum;
  wire   [6:0] shift_in_reg;
  wire   [7:0] reg_status;
  wire   [7:0] shift_out_reg;

  DFFS_E \bit_cnt_reg[3]  ( .D(n191), .CLK(SCLK), .S(n330), .QBAR(n58) );
  DFFR_K start_capture_reg ( .D(N78), .CLK(SCLK), .RN(n324), .Q(n52), .QBAR(
        n121) );
  DFFR_K \bit_cnt_reg[2]  ( .D(n108), .CLK(SCLK), .RN(n328), .Q(N17), .QBAR(
        n57) );
  DFFR_K \addr_latched_reg[1]  ( .D(n105), .CLK(SCLK), .RN(n327), .Q(n128), 
        .QBAR(n120) );
  DFFR_K \addr_latched_reg[0]  ( .D(n104), .CLK(SCLK), .RN(n327), .Q(n139), 
        .QBAR(n54) );
  DFFR_K rw_bit_reg ( .D(n103), .CLK(SCLK), .RN(n327), .Q(rw_bit), .QBAR(n304)
         );
  DFFR_K \shift_in_reg_reg[0]  ( .D(n102), .CLK(SCLK), .RN(n327), .QBAR(n151)
         );
  DFFR_K \shift_in_reg_reg[1]  ( .D(n101), .CLK(SCLK), .RN(n327), .Q(
        shift_in_reg[1]), .QBAR(n152) );
  DFFR_K \shift_in_reg_reg[2]  ( .D(n100), .CLK(SCLK), .RN(n327), .QBAR(n149)
         );
  DFFR_K \shift_in_reg_reg[3]  ( .D(n99), .CLK(SCLK), .RN(n327), .Q(
        shift_in_reg[3]), .QBAR(n133) );
  DFFR_K \shift_in_reg_reg[4]  ( .D(n98), .CLK(SCLK), .RN(n327), .Q(
        shift_in_reg[4]), .QBAR(n141) );
  DFFR_K \shift_in_reg_reg[5]  ( .D(n97), .CLK(SCLK), .RN(n327), .QBAR(n150)
         );
  DFFR_K \shift_in_reg_reg[6]  ( .D(n96), .CLK(SCLK), .RN(n327), .QBAR(n115)
         );
  DFFR_K \reg_input_b_reg[0]  ( .D(n95), .CLK(SCLK), .RN(n327), .QBAR(n144) );
  DFFR_K \reg_input_b_reg[1]  ( .D(n94), .CLK(SCLK), .RN(n326), .QBAR(n125) );
  DFFR_K \reg_input_b_reg[2]  ( .D(n93), .CLK(SCLK), .RN(n326), .Q(
        \reg_input_b[2] ), .QBAR(n153) );
  DFFR_K \reg_input_b_reg[3]  ( .D(n92), .CLK(SCLK), .RN(n326), .QBAR(n123) );
  DFFR_K \reg_input_b_reg[4]  ( .D(n91), .CLK(SCLK), .RN(n326), .QBAR(n147) );
  DFFR_K \reg_input_b_reg[5]  ( .D(n90), .CLK(SCLK), .RN(n326), .QBAR(n136) );
  DFFR_K \reg_input_b_reg[6]  ( .D(n89), .CLK(SCLK), .RN(n326), .QBAR(n122) );
  DFFR_K \reg_input_b_reg[7]  ( .D(n88), .CLK(SCLK), .RN(n326), .QBAR(n148) );
  DFFR_K MISO_enable_reg ( .D(n193), .CLK(SCLK), .RN(n326), .Q(n375), .QBAR(
        n53) );
  DFFR_K \reg_input_a_reg[7]  ( .D(n86), .CLK(SCLK), .RN(n326), .QBAR(n124) );
  DFFR_K \reg_input_a_reg[6]  ( .D(n85), .CLK(SCLK), .RN(n326), .QBAR(n117) );
  DFFR_K \reg_input_a_reg[5]  ( .D(n84), .CLK(SCLK), .RN(n325), .QBAR(n137) );
  DFFR_K \reg_input_a_reg[4]  ( .D(n83), .CLK(SCLK), .RN(n325), .Q(
        \reg_input_a[4] ), .QBAR(n140) );
  DFFR_K \reg_input_a_reg[3]  ( .D(n82), .CLK(SCLK), .RN(n325), .QBAR(n116) );
  DFFR_K \reg_input_a_reg[2]  ( .D(n81), .CLK(SCLK), .RN(n325), .QBAR(n146) );
  DFFR_K \reg_input_a_reg[1]  ( .D(n80), .CLK(SCLK), .RN(n325), .QBAR(n118) );
  DFFR_K \reg_input_a_reg[0]  ( .D(n79), .CLK(SCLK), .RN(n325), .QBAR(n135) );
  DFFR_K \reg_status_reg[5]  ( .D(n77), .CLK(SCLK), .RN(n325), .Q(
        reg_status[5]), .QBAR(n138) );
  DFFR_K \reg_result_reg[0]  ( .D(n119), .CLK(SCLK), .RN(n325), .QBAR(n132) );
  DFF_K \shift_out_reg_reg[1]  ( .D(n74), .CLK(SCLK), .Q(shift_out_reg[1]), 
        .QBAR(n353) );
  DFFR_K \reg_result_reg[2]  ( .D(n129), .CLK(SCLK), .RN(n325), .QBAR(n113) );
  DFF_K \shift_out_reg_reg[2]  ( .D(n72), .CLK(SCLK), .Q(shift_out_reg[2]), 
        .QBAR(n354) );
  DFFR_K \reg_result_reg[3]  ( .D(n71), .CLK(SCLK), .RN(n324), .QBAR(n142) );
  DFF_K \shift_out_reg_reg[3]  ( .D(n112), .CLK(SCLK), .Q(shift_out_reg[3]), 
        .QBAR(n355) );
  DFF_K \shift_out_reg_reg[4]  ( .D(n68), .CLK(SCLK), .Q(shift_out_reg[4]), 
        .QBAR(n356) );
  DFFR_K \reg_result_reg[5]  ( .D(n67), .CLK(SCLK), .RN(n324), .QBAR(n134) );
  DFF_K \shift_out_reg_reg[5]  ( .D(n66), .CLK(SCLK), .Q(shift_out_reg[5]), 
        .QBAR(n357) );
  DFFR_K \reg_result_reg[6]  ( .D(n65), .CLK(SCLK), .RN(n324), .QBAR(n143) );
  DFF_K \shift_out_reg_reg[6]  ( .D(n111), .CLK(SCLK), .Q(shift_out_reg[6]), 
        .QBAR(n358) );
  DFFR_K \reg_result_reg[7]  ( .D(n63), .CLK(SCLK), .RN(n325), .QBAR(n114) );
  DFF_K \shift_out_reg_reg[7]  ( .D(n62), .CLK(SCLK), .Q(shift_out_reg[7]), 
        .QBAR(n359) );
  DFF_K \shift_out_reg_reg[0]  ( .D(n61), .CLK(SCLK), .Q(shift_out_reg[0]), 
        .QBAR(n352) );
  OAI21_D U72 ( .A1(n277), .A2(n23), .B(n261), .Z(n43) );
  NAND3_D U86 ( .A(n283), .B(n368), .C(n291), .Z(n42) );
  signed_adder8_core u_core ( .clk(SCLK), .rst_n(n324), .input_a({n248, n247, 
        n237, \reg_input_a[4] , n246, n245, n244, n235}), .input_b({n241, n251, 
        n236, n240, n242, \reg_input_b[2] , n243, n239}), .adder_out(core_sum), 
        .overflow(core_ovf), .underflow(core_unf) );
  DFFR_E MISO_reg ( .D(N89), .CLK(n361), .RN(n328), .Q(MISO) );
  DFFS_E \bit_cnt_reg[0]  ( .D(n109), .CLK(SCLK), .S(n329), .Q(N15), .QBAR(n59) );
  DFFS_E \bit_cnt_reg[1]  ( .D(n192), .CLK(SCLK), .S(n329), .Q(N16), .QBAR(n56) );
  DFFR_H \reg_status_reg[4]  ( .D(n78), .CLK(SCLK), .RN(n326), .Q(
        reg_status[4]), .QBAR(n130) );
  DFFR_H \reg_result_reg[4]  ( .D(n69), .CLK(SCLK), .RN(n324), .Q(
        \reg_result[4] ), .QBAR(n131) );
  DFFR_K \reg_result_reg[1]  ( .D(n75), .CLK(SCLK), .RN(n325), .QBAR(n145) );
  INVERT_I U100 ( .A(rst_n), .Z(n335) );
  INVERT_J U101 ( .A(n176), .Z(n178) );
  INVERT_J U102 ( .A(n272), .Z(n372) );
  INVERT_H U103 ( .A(n213), .Z(n282) );
  INVERT_D U104 ( .A(n39), .Z(n212) );
  NAND2_E U105 ( .A(shift_out_reg[5]), .B(n293), .Z(n315) );
  INVERT_E U106 ( .A(n320), .Z(n211) );
  AO2222_F U107 ( .A1(shift_out_reg[6]), .A2(n293), .B1(n251), .B2(n178), .C1(
        n247), .C2(n175), .D1(n165), .D2(n173), .Z(n111) );
  NOR2_D U108 ( .A(n181), .B(n182), .Z(n37) );
  AO2222_F U109 ( .A1(shift_out_reg[3]), .A2(n293), .B1(n242), .B2(n178), .C1(
        n246), .C2(n175), .D1(n166), .D2(n173), .Z(n112) );
  INVERT_H U110 ( .A(n10), .Z(n226) );
  INVERT_H U111 ( .A(n11), .Z(n300) );
  NOR2_D U112 ( .A(n277), .B(n278), .Z(n22) );
  INVERT_H U113 ( .A(n12), .Z(n301) );
  INVERT_I U114 ( .A(n302), .Z(n176) );
  INVERT_I U115 ( .A(n226), .Z(n302) );
  INVERT_M U116 ( .A(n168), .Z(n169) );
  INVERT_H U117 ( .A(n249), .Z(n250) );
  INVERT_L U118 ( .A(n172), .Z(n173) );
  AO22_F U119 ( .A1(n167), .A2(n169), .B1(core_sum[0]), .B2(n305), .Z(n119) );
  INVERT_I U120 ( .A(n156), .Z(n271) );
  OR2_J U121 ( .A(n287), .B(n293), .Z(n126) );
  AND2_H U122 ( .A(n308), .B(n309), .Z(n127) );
  INVERT_H U123 ( .A(n224), .Z(n225) );
  NAND2_D U124 ( .A(n194), .B(n196), .Z(n193) );
  INVERT_H U125 ( .A(n368), .Z(n277) );
  AO22_F U126 ( .A1(n170), .A2(n169), .B1(core_sum[2]), .B2(n305), .Z(n129) );
  INVERT_H U127 ( .A(n335), .Z(n334) );
  INVERT_H U128 ( .A(MOSI), .Z(n154) );
  INVERT_L U129 ( .A(n154), .Z(n155) );
  INVERT_H U130 ( .A(n128), .Z(n156) );
  INVERT_H U131 ( .A(n145), .Z(n157) );
  AO22_F U132 ( .A1(n345), .A2(n343), .B1(n344), .B2(n285), .Z(n337) );
  INVERT_D U133 ( .A(n337), .Z(n158) );
  AO22_F U134 ( .A1(n349), .A2(n343), .B1(n348), .B2(n285), .Z(n339) );
  INVERT_D U135 ( .A(n339), .Z(n159) );
  NAND2BAL_E U136 ( .A(n236), .B(n302), .Z(n316) );
  NAND2BAL_E U137 ( .A(n315), .B(n316), .Z(n317) );
  NAND2BAL_E U138 ( .A(n235), .B(n175), .Z(n307) );
  AO2222_F U139 ( .A1(shift_out_reg[1]), .A2(n293), .B1(n243), .B2(n177), .C1(
        n244), .C2(n175), .D1(n157), .D2(n173), .Z(n74) );
  NAND2BAL_E U140 ( .A(n167), .B(n173), .Z(n306) );
  NOR2_C U141 ( .A(n160), .B(n161), .Z(n320) );
  NOR2_C U142 ( .A(n140), .B(n174), .Z(n162) );
  NOR2_C U143 ( .A(n130), .B(n209), .Z(n163) );
  NOR2_C U144 ( .A(n131), .B(n172), .Z(n160) );
  NOR2_C U145 ( .A(n162), .B(n163), .Z(n164) );
  INVERT_E U146 ( .A(n164), .Z(n161) );
  INVERT_H U147 ( .A(n143), .Z(n165) );
  INVERT_H U148 ( .A(n142), .Z(n166) );
  INVERT_H U149 ( .A(n132), .Z(n167) );
  INVERT_I U150 ( .A(n369), .Z(n168) );
  INVERT_H U151 ( .A(n305), .Z(n369) );
  INVERT_H U152 ( .A(n113), .Z(n170) );
  INVERT_H U153 ( .A(n114), .Z(n171) );
  AO22_F U154 ( .A1(\reg_result[4] ), .A2(n169), .B1(core_sum[4]), .B2(n305), 
        .Z(n69) );
  AO22_F U155 ( .A1(n166), .A2(n169), .B1(core_sum[3]), .B2(n305), .Z(n71) );
  AO22_F U156 ( .A1(n157), .A2(n169), .B1(core_sum[1]), .B2(n305), .Z(n75) );
  AO22_F U157 ( .A1(reg_status[4]), .A2(n169), .B1(core_unf), .B2(n305), .Z(
        n78) );
  AO22_F U158 ( .A1(n25), .A2(n265), .B1(n296), .B2(n266), .Z(n99) );
  INVERT_I U159 ( .A(n301), .Z(n172) );
  AO2222_F U160 ( .A1(shift_out_reg[7]), .A2(n293), .B1(n241), .B2(n177), .C1(
        n248), .C2(n175), .D1(n171), .D2(n173), .Z(n62) );
  INVERT_I U161 ( .A(n300), .Z(n174) );
  INVERT_M U162 ( .A(n174), .Z(n175) );
  AO2222_F U163 ( .A1(shift_out_reg[2]), .A2(n293), .B1(\reg_input_b[2] ), 
        .B2(n178), .C1(n245), .C2(n175), .D1(n170), .D2(n173), .Z(n72) );
  INVERT_I U164 ( .A(n176), .Z(n177) );
  AO22_F U165 ( .A1(n25), .A2(n238), .B1(n296), .B2(n270), .Z(n96) );
  AO22_F U166 ( .A1(n25), .A2(n266), .B1(n296), .B2(n268), .Z(n100) );
  INVERT_I U167 ( .A(n303), .Z(n179) );
  INVERT_M U168 ( .A(n179), .Z(n180) );
  AO22_F U169 ( .A1(n155), .A2(n180), .B1(n294), .B2(n235), .Z(n79) );
  AO22_F U170 ( .A1(n269), .A2(n180), .B1(n294), .B2(n244), .Z(n80) );
  AO22_F U171 ( .A1(n265), .A2(n180), .B1(n294), .B2(\reg_input_a[4] ), .Z(n83) );
  AO22_F U172 ( .A1(n238), .A2(n229), .B1(n298), .B2(n241), .Z(n88) );
  AO22_F U173 ( .A1(n155), .A2(n229), .B1(n298), .B2(n239), .Z(n95) );
  AO22_F U174 ( .A1(n270), .A2(n229), .B1(n298), .B2(n251), .Z(n89) );
  AO22_F U175 ( .A1(n263), .A2(n229), .B1(n298), .B2(n236), .Z(n90) );
  AO22_F U176 ( .A1(n265), .A2(n229), .B1(n298), .B2(n240), .Z(n91) );
  AO22_F U177 ( .A1(n266), .A2(n229), .B1(n298), .B2(n242), .Z(n92) );
  AO22_F U178 ( .A1(n240), .A2(n177), .B1(shift_out_reg[4]), .B2(n293), .Z(
        n319) );
  INVERT_D U179 ( .A(n273), .Z(n183) );
  INVERT_H U180 ( .A(n289), .Z(n184) );
  NOR2_C U181 ( .A(n139), .B(n183), .Z(n185) );
  INVERT_E U182 ( .A(n185), .Z(n181) );
  NOR2_C U183 ( .A(n184), .B(n224), .Z(n186) );
  INVERT_E U184 ( .A(n186), .Z(n182) );
  INVERT_H U185 ( .A(n279), .Z(n187) );
  INVERT_H U186 ( .A(n57), .Z(n279) );
  AND2_H U187 ( .A(n23), .B(n187), .Z(n39) );
  AND2_H U188 ( .A(n306), .B(n307), .Z(n310) );
  AND2_H U189 ( .A(n173), .B(n202), .Z(n312) );
  INVERT_D U190 ( .A(n312), .Z(n188) );
  AND2_H U191 ( .A(n311), .B(n314), .Z(n318) );
  INVERT_D U192 ( .A(n318), .Z(n189) );
  NAND2BAL_E U193 ( .A(n210), .B(reg_status[5]), .Z(n313) );
  AND2_H U194 ( .A(n188), .B(n313), .Z(n314) );
  AO22_F U195 ( .A1(n351), .A2(n343), .B1(n350), .B2(n285), .Z(n338) );
  INVERT_D U196 ( .A(n338), .Z(n190) );
  INVERT_H U197 ( .A(n357), .Z(n346) );
  INVERT_H U198 ( .A(n356), .Z(n347) );
  AND4_F U199 ( .A(N88), .B(n280), .C(n368), .D(n374), .Z(N89) );
  INVERT_H U200 ( .A(n234), .Z(n232) );
  INVERT_E U201 ( .A(n35), .Z(n234) );
  OAI21_D U202 ( .A1(n225), .A2(n370), .B(n368), .Z(n109) );
  OA21_F U203 ( .A1(n291), .A2(n283), .B(n368), .Z(n106) );
  INVERT_D U204 ( .A(n106), .Z(n191) );
  OA21_F U205 ( .A1(n342), .A2(n259), .B(n43), .Z(n107) );
  INVERT_D U206 ( .A(n107), .Z(n192) );
  INVERT_H U207 ( .A(n28), .Z(n367) );
  NAND2_F U208 ( .A(n252), .B(n370), .Z(n28) );
  NAND2_D U209 ( .A(n310), .B(n127), .Z(n61) );
  NAND2BAL_E U210 ( .A(n276), .B(n195), .Z(n194) );
  NAND2BAL_E U211 ( .A(n50), .B(n197), .Z(n196) );
  NAND2BAL_E U212 ( .A(n23), .B(n184), .Z(n198) );
  INVERT_F U213 ( .A(n198), .Z(n195) );
  NAND2BAL_E U214 ( .A(n368), .B(n374), .Z(n199) );
  INVERT_F U215 ( .A(n199), .Z(n197) );
  NOR2_I U216 ( .A(n256), .B(n370), .Z(n23) );
  INVERT_N U217 ( .A(CSN), .Z(n368) );
  NAND2BAL_E U218 ( .A(n283), .B(n371), .Z(n50) );
  INVERT_H U219 ( .A(n375), .Z(n200) );
  INVERT_H U220 ( .A(n200), .Z(MISO_enable) );
  INVERT_H U221 ( .A(n134), .Z(n202) );
  AO22_F U222 ( .A1(n28), .A2(n289), .B1(n155), .B2(n367), .Z(n103) );
  INVERT_C U223 ( .A(n203), .Z(n77) );
  INVERT_H U224 ( .A(core_ovf), .Z(n204) );
  NOR2_C U225 ( .A(n204), .B(n121), .Z(n205) );
  NOR2_C U226 ( .A(n305), .B(n138), .Z(n206) );
  NOR2_C U227 ( .A(n205), .B(n206), .Z(n203) );
  INVERT_H U228 ( .A(n37), .Z(n207) );
  INVERT_I U229 ( .A(n207), .Z(n208) );
  INVERT_I U230 ( .A(n299), .Z(n297) );
  INVERT_K U231 ( .A(n290), .Z(n291) );
  INVERT_H U232 ( .A(n298), .Z(n363) );
  INVERT_H U233 ( .A(n373), .Z(n286) );
  INVERT_H U234 ( .A(n15), .Z(n209) );
  INVERT_H U235 ( .A(n209), .Z(n210) );
  AND3_I U236 ( .A(n372), .B(n287), .C(n360), .Z(n15) );
  OR2_H U237 ( .A(n319), .B(n211), .Z(n68) );
  NAND2_E U238 ( .A(n175), .B(n237), .Z(n311) );
  INVERT_E U239 ( .A(n212), .Z(n213) );
  INVERT_J U240 ( .A(n275), .Z(n276) );
  INVERT_F U241 ( .A(n22), .Z(n275) );
  AO22_F U242 ( .A1(n25), .A2(n270), .B1(n296), .B2(n263), .Z(n97) );
  INVERT_C U243 ( .A(n214), .Z(n98) );
  INVERT_E U244 ( .A(n296), .Z(n215) );
  NOR2_C U245 ( .A(n133), .B(n215), .Z(n216) );
  NOR2_D U246 ( .A(n141), .B(n362), .Z(n217) );
  NOR2_C U247 ( .A(n216), .B(n217), .Z(n214) );
  INVERT_L U248 ( .A(n295), .Z(n296) );
  AO22_F U249 ( .A1(n25), .A2(n268), .B1(n296), .B2(n269), .Z(n101) );
  AO22_F U250 ( .A1(n25), .A2(n269), .B1(n296), .B2(n155), .Z(n102) );
  AO22_F U251 ( .A1(n268), .A2(n180), .B1(n294), .B2(n245), .Z(n81) );
  AO22_F U252 ( .A1(n266), .A2(n180), .B1(n294), .B2(n246), .Z(n82) );
  AO22_F U253 ( .A1(n263), .A2(n180), .B1(n294), .B2(n237), .Z(n84) );
  AO22_F U254 ( .A1(n270), .A2(n180), .B1(n294), .B2(n247), .Z(n85) );
  AO22_F U255 ( .A1(n238), .A2(n180), .B1(n294), .B2(n248), .Z(n86) );
  INVERT_C U256 ( .A(n218), .Z(n93) );
  NOR2_C U257 ( .A(n153), .B(n363), .Z(n219) );
  NOR2_D U258 ( .A(n298), .B(n152), .Z(n220) );
  NOR2_C U259 ( .A(n219), .B(n220), .Z(n218) );
  AO22_F U260 ( .A1(n269), .A2(n229), .B1(n298), .B2(n243), .Z(n94) );
  INVERT_E U261 ( .A(n221), .Z(n341) );
  NOR2_C U262 ( .A(n254), .B(n336), .Z(n222) );
  NOR2_C U263 ( .A(n158), .B(n342), .Z(n223) );
  NOR2_C U264 ( .A(n222), .B(n223), .Z(n221) );
  AOI22_C U265 ( .A1(n347), .A2(n343), .B1(n346), .B2(n285), .Z(n336) );
  INVERT_I U266 ( .A(n254), .Z(n342) );
  OAI22_B U267 ( .A1(n342), .A2(n159), .B1(n254), .B2(n190), .Z(n340) );
  INVERT_H U268 ( .A(n364), .Z(n224) );
  AO22_F U269 ( .A1(n287), .A2(n231), .B1(n155), .B2(n365), .Z(n104) );
  AND3_I U270 ( .A(n360), .B(n287), .C(n120), .Z(n10) );
  NAND3_C U271 ( .A(n289), .B(n287), .C(n225), .Z(n35) );
  INVERT_K U272 ( .A(n286), .Z(n287) );
  AO21_F U273 ( .A1(n250), .A2(n43), .B(n321), .Z(n108) );
  AND3_I U274 ( .A(n261), .B(n368), .C(n283), .Z(n321) );
  NAND2BAL_E U275 ( .A(n239), .B(n178), .Z(n308) );
  AO22_F U276 ( .A1(n250), .A2(n341), .B1(n340), .B2(n187), .Z(N88) );
  INVERT_F U277 ( .A(n294), .Z(n303) );
  INVERT_F U278 ( .A(n271), .Z(n272) );
  NAND2BAL_E U279 ( .A(n274), .B(n227), .Z(n11) );
  INVERT_H U280 ( .A(n126), .Z(n227) );
  INVERT_H U281 ( .A(n34), .Z(n299) );
  AND2_I U282 ( .A(n233), .B(n273), .Z(n34) );
  INVERT_H U283 ( .A(n363), .Z(n228) );
  INVERT_L U284 ( .A(n228), .Z(n229) );
  INVERT_E U285 ( .A(n47), .Z(n230) );
  INVERT_H U286 ( .A(n230), .Z(n231) );
  INVERT_F U287 ( .A(n232), .Z(n233) );
  INVERT_K U288 ( .A(n259), .Z(n370) );
  INVERT_J U289 ( .A(n258), .Z(n259) );
  INVERT_I U290 ( .A(n135), .Z(n235) );
  INVERT_I U291 ( .A(n136), .Z(n236) );
  INVERT_I U292 ( .A(n137), .Z(n237) );
  INVERT_I U293 ( .A(n115), .Z(n238) );
  INVERT_I U294 ( .A(n144), .Z(n239) );
  INVERT_I U295 ( .A(n147), .Z(n240) );
  INVERT_I U296 ( .A(n148), .Z(n241) );
  INVERT_I U297 ( .A(n123), .Z(n242) );
  INVERT_I U298 ( .A(n125), .Z(n243) );
  INVERT_I U299 ( .A(n118), .Z(n244) );
  INVERT_I U300 ( .A(n146), .Z(n245) );
  INVERT_I U301 ( .A(n116), .Z(n246) );
  INVERT_I U302 ( .A(n117), .Z(n247) );
  INVERT_I U303 ( .A(n124), .Z(n248) );
  INVERT_H U304 ( .A(N17), .Z(n249) );
  INVERT_I U305 ( .A(n122), .Z(n251) );
  BUFFER_L U306 ( .A(n30), .Z(n252) );
  NAND2_F U307 ( .A(n252), .B(n259), .Z(n44) );
  AND2_I U308 ( .A(n276), .B(n256), .Z(n30) );
  INVERT_H U309 ( .A(N16), .Z(n253) );
  INVERT_I U310 ( .A(n253), .Z(n254) );
  INVERT_F U311 ( .A(n257), .Z(n255) );
  INVERT_I U312 ( .A(n255), .Z(n256) );
  INVERT_E U313 ( .A(n342), .Z(n257) );
  INVERT_H U314 ( .A(n59), .Z(n258) );
  INVERT_H U315 ( .A(n42), .Z(n260) );
  INVERT_I U316 ( .A(n260), .Z(n261) );
  INVERT_H U317 ( .A(shift_in_reg[4]), .Z(n262) );
  INVERT_I U318 ( .A(n262), .Z(n263) );
  INVERT_H U319 ( .A(shift_in_reg[3]), .Z(n264) );
  INVERT_I U320 ( .A(n264), .Z(n265) );
  INVERT_I U321 ( .A(n149), .Z(n266) );
  INVERT_H U322 ( .A(shift_in_reg[1]), .Z(n267) );
  INVERT_I U323 ( .A(n267), .Z(n268) );
  INVERT_I U324 ( .A(n151), .Z(n269) );
  INVERT_I U325 ( .A(n150), .Z(n270) );
  AO22_F U326 ( .A1(n372), .A2(n44), .B1(n155), .B2(n366), .Z(n105) );
  AND3_H U327 ( .A(n155), .B(n372), .C(n233), .Z(N78) );
  NAND2_E U328 ( .A(n227), .B(n372), .Z(n12) );
  INVERT_I U329 ( .A(n285), .Z(n343) );
  INVERT_K U330 ( .A(n284), .Z(n285) );
  INVERT_F U331 ( .A(n271), .Z(n273) );
  INVERT_H U332 ( .A(n271), .Z(n274) );
  INVERT_F U333 ( .A(n371), .Z(n280) );
  NOR2_C U334 ( .A(n279), .B(n280), .Z(n281) );
  INVERT_E U335 ( .A(n281), .Z(n278) );
  INVERT_H U336 ( .A(n291), .Z(n371) );
  INVERT_J U337 ( .A(n282), .Z(n283) );
  INVERT_H U338 ( .A(N15), .Z(n284) );
  INVERT_E U339 ( .A(n54), .Z(n373) );
  INVERT_H U340 ( .A(rw_bit), .Z(n288) );
  INVERT_K U341 ( .A(n288), .Z(n289) );
  INVERT_H U342 ( .A(n58), .Z(n290) );
  INVERT_I U343 ( .A(n322), .Z(n292) );
  INVERT_N U344 ( .A(n292), .Z(n293) );
  BUFFER_J U345 ( .A(n9), .Z(n322) );
  INVERT_M U346 ( .A(n208), .Z(n294) );
  INVERT_H U347 ( .A(n362), .Z(n295) );
  INVERT_H U348 ( .A(n25), .Z(n362) );
  INVERT_M U349 ( .A(n297), .Z(n298) );
  NAND3_J U350 ( .A(n291), .B(n368), .C(n289), .Z(n25) );
  AO22_F U351 ( .A1(n202), .A2(n169), .B1(core_sum[5]), .B2(n305), .Z(n67) );
  AO22_F U352 ( .A1(n165), .A2(n169), .B1(core_sum[6]), .B2(n305), .Z(n65) );
  NAND2_E U353 ( .A(shift_out_reg[0]), .B(n293), .Z(n309) );
  AO22_F U354 ( .A1(n171), .A2(n169), .B1(core_sum[7]), .B2(n305), .Z(n63) );
  OR2_H U355 ( .A(n189), .B(n317), .Z(n66) );
  INVERT_I U356 ( .A(n52), .Z(n323) );
  INVERT_N U357 ( .A(n323), .Z(n305) );
  INVERT_H U358 ( .A(n293), .Z(n360) );
  INVERT_H U359 ( .A(n261), .Z(n364) );
  INVERT_H U360 ( .A(n53), .Z(n374) );
  INVERT_A U361 ( .A(SCLK), .Z(n361) );
  INVERT_M U362 ( .A(n332), .Z(n324) );
  INVERT_K U363 ( .A(n335), .Z(n333) );
  NAND3_C U364 ( .A(n56), .B(n370), .C(n276), .Z(n47) );
  INVERT_N U365 ( .A(n330), .Z(n326) );
  INVERT_N U366 ( .A(n329), .Z(n327) );
  INVERT_H U367 ( .A(n330), .Z(n328) );
  INVERT_I U368 ( .A(n333), .Z(n332) );
  INVERT_N U369 ( .A(n331), .Z(n325) );
  INVERT_I U370 ( .A(n333), .Z(n331) );
  NAND4_C U371 ( .A(n276), .B(n23), .C(n324), .D(n304), .Z(n9) );
  INVERT_K U372 ( .A(n334), .Z(n329) );
  INVERT_K U373 ( .A(n333), .Z(n330) );
  INVERT_D U374 ( .A(n359), .Z(n344) );
  INVERT_D U375 ( .A(n358), .Z(n345) );
  INVERT_D U376 ( .A(n355), .Z(n348) );
  INVERT_D U377 ( .A(n354), .Z(n349) );
  INVERT_D U378 ( .A(n353), .Z(n350) );
  INVERT_D U379 ( .A(n352), .Z(n351) );
  INVERT_D U380 ( .A(n231), .Z(n365) );
  INVERT_D U381 ( .A(n44), .Z(n366) );
endmodule

