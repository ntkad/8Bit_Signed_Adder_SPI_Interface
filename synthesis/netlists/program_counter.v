/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Sat Jan 24 11:35:55 2026
/////////////////////////////////////////////////////////////


module program_counter_DW01_add_0 ( A, B, CI, SUM, CO );
  input [5:0] A;
  input [5:0] B;
  output [5:0] SUM;
  input CI;
  output CO;
  wire   n1, n2;
  wire   [5:1] carry;

  ADDF_B U1_3 ( .A(A[3]), .B(B[3]), .CIN(carry[3]), .COUT(carry[4]), .SUM(
        SUM[3]) );
  ADDF_B U1_1 ( .A(A[1]), .B(B[1]), .CIN(n2), .COUT(carry[2]), .SUM(SUM[1]) );
  ADDF_E U1_2 ( .A(A[2]), .B(B[2]), .CIN(carry[2]), .COUT(carry[3]), .SUM(
        SUM[2]) );
  ADDF_D U1_4 ( .A(A[4]), .B(B[4]), .CIN(carry[4]), .COUT(carry[5]), .SUM(
        SUM[4]) );
  XOR3_D U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .Z(SUM[5]) );
  INVERT_D U1 ( .A(n1), .Z(n2) );
  AND2_H U2 ( .A(A[0]), .B(B[0]), .Z(carry[1]) );
  INVERT_D U3 ( .A(carry[1]), .Z(n1) );
  XOR2_B U4 ( .A(A[0]), .B(B[0]), .Z(SUM[0]) );
endmodule


module program_counter ( clk, rst_n, update_msbs, update_lsbs, jump, 
        jump_destination, branch, branch_offset, mem_addr );
  input [5:0] jump_destination;
  input [5:0] branch_offset;
  output [7:0] mem_addr;
  input clk, rst_n, update_msbs, update_lsbs, jump, branch;
  wire   n133, n134, n135, n136, n137, n138, n139, n140, N6, N7, N8, N9, N10,
         N15, N16, N17, N18, N19, N20, n7, n9, n14, n16, n17, n19, n20, n21,
         n22, n23, n24, n25, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36,
         n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50,
         n52, n53, n54, n55, n56, n57, n58, n60, n61, n62, n63, n64, n65, n66,
         n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80,
         n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n95,
         n97, n98, n99, n101, n103, n104, n105, n107, n108, n109, n111, n112,
         n113, n114, n115, n116, n117, n118, n119, n120, n121, n122, n123,
         n124, n125, n126, n127, n128, n129, n130, n131, n132;
  wire   [5:0] jump_destination_q;
  wire   [5:0] branch_offset_q;

  DFFR_K branch_q_reg ( .D(branch), .CLK(clk), .RN(n117), .QBAR(n19) );
  DFFR_K \branch_offset_q_reg[5]  ( .D(branch_offset[5]), .CLK(clk), .RN(n117), 
        .Q(branch_offset_q[5]) );
  DFFR_K \branch_offset_q_reg[4]  ( .D(branch_offset[4]), .CLK(clk), .RN(n117), 
        .Q(branch_offset_q[4]) );
  DFFR_K \branch_offset_q_reg[3]  ( .D(branch_offset[3]), .CLK(clk), .RN(n117), 
        .Q(branch_offset_q[3]) );
  DFFR_K \branch_offset_q_reg[2]  ( .D(branch_offset[2]), .CLK(clk), .RN(n117), 
        .Q(branch_offset_q[2]) );
  DFFR_K \branch_offset_q_reg[1]  ( .D(branch_offset[1]), .CLK(clk), .RN(n118), 
        .Q(branch_offset_q[1]) );
  DFFR_K update_msbs_q_reg ( .D(update_msbs), .CLK(clk), .RN(n118), .Q(n20), 
        .QBAR(n41) );
  DFFR_K jump_q_reg ( .D(jump), .CLK(clk), .RN(n118), .Q(n34) );
  DFFR_K \jump_destination_q_reg[5]  ( .D(jump_destination[5]), .CLK(clk), 
        .RN(n119), .Q(jump_destination_q[5]) );
  DFFR_K \jump_destination_q_reg[4]  ( .D(jump_destination[4]), .CLK(clk), 
        .RN(n119), .Q(jump_destination_q[4]) );
  DFFR_K \jump_destination_q_reg[3]  ( .D(jump_destination[3]), .CLK(clk), 
        .RN(n119), .Q(jump_destination_q[3]) );
  DFFR_K \jump_destination_q_reg[2]  ( .D(jump_destination[2]), .CLK(clk), 
        .RN(n119), .Q(jump_destination_q[2]) );
  DFFR_K \jump_destination_q_reg[1]  ( .D(jump_destination[1]), .CLK(clk), 
        .RN(n119), .QBAR(n42) );
  DFFR_K \jump_destination_q_reg[0]  ( .D(jump_destination[0]), .CLK(clk), 
        .RN(n120), .Q(jump_destination_q[0]) );
  DFFR_K \mem_addr_reg[1]  ( .D(n29), .CLK(clk), .RN(n120), .Q(n139), .QBAR(
        n17) );
  DFFR_K \mem_addr_reg[7]  ( .D(n27), .CLK(clk), .RN(n120), .Q(n133) );
  DFFR_K \mem_addr_reg[3]  ( .D(n33), .CLK(clk), .RN(n119), .Q(n137), .QBAR(
        n36) );
  DFFR_K \mem_addr_reg[4]  ( .D(n25), .CLK(clk), .RN(n120), .Q(n136), .QBAR(
        n37) );
  DFFR_K \mem_addr_reg[5]  ( .D(n24), .CLK(clk), .RN(n117), .Q(n135), .QBAR(
        n38) );
  DFFR_K \mem_addr_reg[6]  ( .D(n23), .CLK(clk), .RN(n118), .Q(n134) );
  AO33_E U15 ( .A1(n92), .A2(n132), .A3(n35), .B1(n129), .B2(n131), .B3(n17), 
        .Z(n29) );
  program_counter_DW01_add_0 add_75 ( .A({mem_addr[7], n97, mem_addr[5:2]}), 
        .B({branch_offset_q[5:1], n47}), .CI(1'b0), .SUM({N20, N19, N18, N17, 
        N16, N15}) );
  DFFR_K \branch_offset_q_reg[0]  ( .D(branch_offset[0]), .CLK(clk), .RN(n118), 
        .QBAR(n40) );
  DFFR_K \mem_addr_reg[2]  ( .D(n28), .CLK(clk), .RN(n120), .Q(n138), .QBAR(
        n114) );
  DFFR_K \mem_addr_reg[0]  ( .D(n48), .CLK(clk), .RN(n120), .Q(n140), .QBAR(
        n22) );
  DFFR_H update_lsbs_q_reg ( .D(update_lsbs), .CLK(clk), .RN(n118), .Q(n21), 
        .QBAR(n115) );
  INVERT_I U26 ( .A(n124), .Z(n123) );
  INVERTBAL_J U27 ( .A(n134), .Z(n95) );
  INVERT_D U28 ( .A(n49), .Z(n62) );
  NOR2_D U29 ( .A(n60), .B(n87), .Z(n31) );
  INVERT_H U30 ( .A(n7), .Z(n60) );
  AND2_I U31 ( .A(n61), .B(n87), .Z(n32) );
  OR2_H U32 ( .A(n71), .B(n72), .Z(n33) );
  AO22_F U33 ( .A1(n46), .A2(n44), .B1(n115), .B2(n89), .Z(n35) );
  INVERT_D U34 ( .A(n16), .Z(n75) );
  INVERT_K U35 ( .A(n109), .Z(mem_addr[3]) );
  AO21_F U36 ( .A1(n92), .A2(n89), .B(n129), .Z(n39) );
  INVERT_K U37 ( .A(n105), .Z(mem_addr[2]) );
  INVERT_I U38 ( .A(n138), .Z(n105) );
  INVERT_H U39 ( .A(n88), .Z(n89) );
  INVERT_L U40 ( .A(n113), .Z(n81) );
  INVERT_H U41 ( .A(n44), .Z(n131) );
  INVERT_I U42 ( .A(n34), .Z(n87) );
  INVERT_J U43 ( .A(n123), .Z(n121) );
  INVERT_H U44 ( .A(n22), .Z(n43) );
  INVERT_H U45 ( .A(n43), .Z(n44) );
  INVERT_H U46 ( .A(n90), .Z(n88) );
  INVERT_H U47 ( .A(n21), .Z(n45) );
  INVERT_H U48 ( .A(n45), .Z(n46) );
  INVERT_H U49 ( .A(n40), .Z(n47) );
  INVERT_H U50 ( .A(n84), .Z(n85) );
  OA21_F U51 ( .A1(n85), .A2(n43), .B(n75), .Z(n30) );
  INVERT_C U52 ( .A(n30), .Z(n48) );
  AO2222_F U53 ( .A1(n112), .A2(mem_addr[7]), .B1(N20), .B2(n108), .C1(n104), 
        .C2(jump_destination_q[5]), .D1(n81), .D2(N10), .Z(n27) );
  BUFFER_F U54 ( .A(N6), .Z(n49) );
  INVERT_H U55 ( .A(n140), .Z(n50) );
  INVERT_H U56 ( .A(n50), .Z(mem_addr[0]) );
  BUFFER_J U57 ( .A(n126), .Z(n116) );
  NOR2_C U58 ( .A(n52), .B(n53), .Z(n16) );
  INVERT_F U59 ( .A(n92), .Z(n54) );
  INVERT_D U60 ( .A(n115), .Z(n55) );
  NOR2_C U61 ( .A(n54), .B(n55), .Z(n56) );
  INVERT_E U62 ( .A(n56), .Z(n52) );
  NOR2_C U63 ( .A(n50), .B(n88), .Z(n57) );
  INVERT_E U64 ( .A(n57), .Z(n53) );
  XNOR2_C U65 ( .A(n80), .B(mem_addr[4]), .Z(N7) );
  INVERT_H U66 ( .A(n9), .Z(n90) );
  NAND2BAL_E U67 ( .A(n87), .B(n19), .Z(n9) );
  INVERT_E U68 ( .A(n86), .Z(n84) );
  INVERT_H U69 ( .A(n139), .Z(n58) );
  INVERT_H U70 ( .A(n58), .Z(mem_addr[1]) );
  INVERT_H U71 ( .A(n95), .Z(n98) );
  INVERT_I U72 ( .A(n95), .Z(n97) );
  INVERT_H U73 ( .A(n60), .Z(n61) );
  NOR2_D U74 ( .A(n112), .B(n81), .Z(n7) );
  XOR2_C U75 ( .A(n97), .B(n83), .Z(N9) );
  AO2222_F U76 ( .A1(n112), .A2(n97), .B1(N19), .B2(n108), .C1(n104), .C2(
        jump_destination_q[4]), .D1(N9), .D2(n81), .Z(n23) );
  XNOR2_C U77 ( .A(n116), .B(mem_addr[5]), .Z(N8) );
  AO2222_F U78 ( .A1(n112), .A2(mem_addr[5]), .B1(N18), .B2(n108), .C1(n104), 
        .C2(jump_destination_q[3]), .D1(N8), .D2(n81), .Z(n24) );
  AO2222_F U79 ( .A1(n112), .A2(mem_addr[4]), .B1(N17), .B2(n108), .C1(n104), 
        .C2(jump_destination_q[2]), .D1(N7), .D2(n81), .Z(n25) );
  INVERT_H U80 ( .A(n104), .Z(n63) );
  INVERT_H U81 ( .A(n108), .Z(n64) );
  INVERT_H U82 ( .A(N16), .Z(n65) );
  INVERT_E U83 ( .A(n112), .Z(n66) );
  NOR2_C U84 ( .A(n41), .B(n62), .Z(n67) );
  NOR2_C U85 ( .A(n42), .B(n63), .Z(n68) );
  NOR2_C U86 ( .A(n64), .B(n65), .Z(n69) );
  NOR2_C U87 ( .A(n36), .B(n66), .Z(n70) );
  NOR2_C U88 ( .A(n67), .B(n68), .Z(n73) );
  INVERT_E U89 ( .A(n73), .Z(n71) );
  NOR2_C U90 ( .A(n69), .B(n70), .Z(n74) );
  INVERT_E U91 ( .A(n74), .Z(n72) );
  INVERT_L U92 ( .A(n111), .Z(n112) );
  XNOR2_B U93 ( .A(mem_addr[3]), .B(n114), .Z(N6) );
  AO2222_F U94 ( .A1(n112), .A2(mem_addr[2]), .B1(N15), .B2(n108), .C1(n104), 
        .C2(jump_destination_q[0]), .D1(n81), .D2(n114), .Z(n28) );
  INVERT_E U95 ( .A(n76), .Z(n126) );
  INVERT_E U96 ( .A(mem_addr[3]), .Z(n77) );
  NOR2_C U97 ( .A(n77), .B(n78), .Z(n76) );
  NOR2_C U98 ( .A(n37), .B(n105), .Z(n79) );
  INVERT_E U99 ( .A(n79), .Z(n78) );
  AND2_H U100 ( .A(mem_addr[3]), .B(mem_addr[2]), .Z(n125) );
  INVERT_D U101 ( .A(n125), .Z(n80) );
  XOR2_B U102 ( .A(mem_addr[7]), .B(n128), .Z(N10) );
  AND2_H U103 ( .A(n83), .B(n98), .Z(n128) );
  INVERT_E U104 ( .A(n127), .Z(n82) );
  INVERT_F U105 ( .A(n82), .Z(n83) );
  NOR2_C U106 ( .A(n38), .B(n116), .Z(n127) );
  AND2_H U107 ( .A(n46), .B(n92), .Z(n14) );
  INVERT_D U108 ( .A(n14), .Z(n86) );
  INVERT_F U109 ( .A(n130), .Z(n91) );
  INVERT_I U110 ( .A(n91), .Z(n92) );
  INVERT_H U111 ( .A(n133), .Z(n93) );
  INVERT_J U112 ( .A(n93), .Z(mem_addr[7]) );
  INVERT_H U113 ( .A(n95), .Z(mem_addr[6]) );
  INVERT_H U114 ( .A(n135), .Z(n99) );
  INVERT_K U115 ( .A(n99), .Z(mem_addr[5]) );
  INVERT_H U116 ( .A(n136), .Z(n101) );
  INVERT_K U117 ( .A(n101), .Z(mem_addr[4]) );
  INVERT_H U118 ( .A(n31), .Z(n103) );
  INVERT_K U119 ( .A(n103), .Z(n104) );
  INVERT_H U120 ( .A(n32), .Z(n107) );
  INVERT_K U121 ( .A(n107), .Z(n108) );
  INVERT_H U122 ( .A(n137), .Z(n109) );
  INVERT_H U123 ( .A(n39), .Z(n111) );
  INVERT_H U124 ( .A(n20), .Z(n113) );
  INVERT_F U125 ( .A(n85), .Z(n129) );
  INVERT_E U126 ( .A(n81), .Z(n130) );
  INVERT_J U127 ( .A(n123), .Z(n122) );
  INVERT_H U128 ( .A(rst_n), .Z(n124) );
  INVERT_K U129 ( .A(n121), .Z(n120) );
  INVERT_K U130 ( .A(n121), .Z(n119) );
  INVERT_K U131 ( .A(n122), .Z(n118) );
  INVERT_K U132 ( .A(n122), .Z(n117) );
  INVERT_D U133 ( .A(n17), .Z(n132) );
endmodule

