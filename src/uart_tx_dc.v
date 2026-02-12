
module uart_tx ( clk, rst_n, rx_data, rx_int, rs232_tx, clk_bps, bps_start );
  input [7:0] rx_data;
  input clk, rst_n, rx_int, clk_bps;
  output rs232_tx, bps_start;
  wire   n92, rx_int0, rx_int2, rx_int1, tx_en, n1, n2, n3, n4, n5, n6, n7, n8,
         n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22,
         n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n38,
         n46, n47, n49, n50, n51, n52, n53, n54, n55, n56, n57, n59, n60, n66,
         n67, n69, n70, n71, n73, n89, n90, n91;
  wire   [7:0] tx_data;
  wire   [3:0] num;
  tri   bps_start;

  DFPNSRBQQB1 rx_int1_reg ( .D(rx_int0), .CK(clk), .RB(rst_n), .Q(rx_int1), 
        .QB(n38) );
  NR02D1 U3 ( .A1(n47), .A2(n1), .YN(n49) );
  OAIB21D1 U4 ( .A1B(tx_data[0]), .A2(n2), .B(n3), .YN(n50) );
  ND02D1 U5 ( .A1(rx_data[0]), .A2(n2), .YN(n3) );
  OAIB21D1 U6 ( .A1B(tx_data[1]), .A2(n2), .B(n4), .YN(n51) );
  ND02D1 U7 ( .A1(rx_data[1]), .A2(n2), .YN(n4) );
  OAI21D1 U8 ( .A1(n2), .A2(n5), .B(n6), .YN(n52) );
  ND02D1 U9 ( .A1(rx_data[2]), .A2(n2), .YN(n6) );
  OAIB21D1 U10 ( .A1B(tx_data[3]), .A2(n2), .B(n7), .YN(n53) );
  ND02D1 U11 ( .A1(rx_data[3]), .A2(n2), .YN(n7) );
  OAIB21D1 U12 ( .A1B(tx_data[4]), .A2(n2), .B(n8), .YN(n54) );
  ND02D1 U13 ( .A1(rx_data[4]), .A2(n2), .YN(n8) );
  OAIB21D1 U14 ( .A1B(tx_data[5]), .A2(n2), .B(n9), .YN(n55) );
  ND02D1 U15 ( .A1(rx_data[5]), .A2(n2), .YN(n9) );
  OAI21D1 U16 ( .A1(n2), .A2(n10), .B(n11), .YN(n56) );
  ND02D1 U17 ( .A1(rx_data[6]), .A2(n2), .YN(n11) );
  OAI21D1 U18 ( .A1(n2), .A2(n12), .B(n13), .YN(n57) );
  ND02D1 U19 ( .A1(rx_data[7]), .A2(n2), .YN(n13) );
  OAI21D1 U20 ( .A1(n14), .A2(n15), .B(n16), .YN(n59) );
  ND02D1 U21 ( .A1(n73), .A2(n15), .YN(n16) );
  ND02D1 U22 ( .A1(tx_en), .A2(clk_bps), .YN(n15) );
  AOI221D1 U23 ( .A1(num[2]), .A2(n17), .B1(n18), .B2(n19), .C(n20), .YN(n14)
         );
  AOI13D1 U24 ( .A1(n21), .A2(n12), .A3(n22), .B(n23), .YN(n20) );
  OAI21D1 U26 ( .A1(n24), .A2(n5), .B(n25), .YN(n18) );
  AOI33D1 U27 ( .A1(num[1]), .A2(n22), .A3(tx_data[1]), .B1(num[0]), .B2(n21), 
        .B3(tx_data[0]), .YN(n25) );
  OAI221D1 U29 ( .A1(num[1]), .A2(n26), .B1(n24), .B2(n10), .C(n27), .YN(n17)
         );
  AOI13D1 U30 ( .A1(num[1]), .A2(n22), .A3(tx_data[5]), .B(num[3]), .YN(n27)
         );
  AOI22D1 U32 ( .A1(tx_data[3]), .A2(n22), .B1(tx_data[4]), .B2(num[0]), .YN(
        n26) );
  IN01D0 U33 ( .A(n28), .YN(n60) );
  AOI32D1 U34 ( .A1(n29), .A2(n19), .A3(clk_bps), .B1(n30), .B2(num[2]), .YN(
        n28) );
  IN01D0 U35 ( .A(n30), .YN(n29) );
  XN02D1 U36 ( .A(n21), .B(n31), .Y(n66) );
  OAIB21D1 U38 ( .A1B(tx_en), .A2(n1), .B(n32), .YN(n67) );
  OAI21D1 U39 ( .A1(n46), .A2(n1), .B(n32), .YN(n89) );
  OAI32D1 U43 ( .A1(n30), .A2(num[3]), .A3(n19), .B1(n34), .B2(n23), .YN(n69)
         );
  AOI12D1 U44 ( .A1(clk_bps), .A2(n19), .B(n91), .YN(n34) );
  ND02D1 U46 ( .A1(n31), .A2(num[1]), .YN(n30) );
  NR02D1 U47 ( .A1(n35), .A2(n22), .YN(n31) );
  XN02D1 U49 ( .A(n35), .B(num[0]), .Y(n70) );
  OAI21D1 U50 ( .A1(n90), .A2(clk_bps), .B(tx_en), .YN(n35) );
  NR03D1 U51 ( .A1(n24), .A2(num[2]), .A3(n23), .YN(n33) );
  ND02D1 U53 ( .A1(num[1]), .A2(num[0]), .YN(n24) );
  DFPSYNCHQQB1 bps_start_r_reg ( .D(1'b0), .S(n89), .CK(clk), .QB(n46) );
  DFPTNB bps_start_r_tri_enable_reg ( .D(n49), .CK(clk), .SB(rst_n), .QB(n47)
         );
  DFPTNB rs232_tx_r_reg ( .D(n59), .CK(clk), .SB(rst_n), .Q(n92) );
  DFPNSRBQQB1 rx_int2_reg ( .D(rx_int1), .CK(clk), .RB(rst_n), .Q(rx_int2) );
  DFPNSRBQQB1 tx_en_reg ( .D(n67), .CK(clk), .RB(rst_n), .Q(tx_en) );
  DFPNSRBQQB1 rx_int0_reg ( .D(rx_int), .CK(clk), .RB(rst_n), .Q(rx_int0) );
  DFPNSRBQQB1 \tx_data_reg[5]  ( .D(n55), .CK(clk), .RB(rst_n), .Q(tx_data[5])
         );
  DFPNSRBQQB1 \tx_data_reg[4]  ( .D(n54), .CK(clk), .RB(rst_n), .Q(tx_data[4])
         );
  DFPNSRBQQB1 \tx_data_reg[3]  ( .D(n53), .CK(clk), .RB(rst_n), .Q(tx_data[3])
         );
  DFPNSRBQQB1 \tx_data_reg[1]  ( .D(n51), .CK(clk), .RB(rst_n), .Q(tx_data[1])
         );
  DFPNSRBQQB1 \tx_data_reg[0]  ( .D(n50), .CK(clk), .RB(rst_n), .Q(tx_data[0])
         );
  DFPNSRBQQB1 \tx_data_reg[7]  ( .D(n57), .CK(clk), .RB(rst_n), .QB(n12) );
  DFPNSRBQQB1 \tx_data_reg[6]  ( .D(n56), .CK(clk), .RB(rst_n), .QB(n10) );
  DFPNSRBQQB1 \tx_data_reg[2]  ( .D(n52), .CK(clk), .RB(rst_n), .QB(n5) );
  DFPNSRBQQB1 \num_reg[0]  ( .D(n70), .CK(clk), .RB(rst_n), .Q(num[0]), .QB(
        n22) );
  DFPNSRBQQB1 \num_reg[1]  ( .D(n66), .CK(clk), .RB(rst_n), .Q(num[1]), .QB(
        n21) );
  DFPNSRBQQB1 \num_reg[2]  ( .D(n60), .CK(clk), .RB(rst_n), .Q(num[2]), .QB(
        n19) );
  DFPNSRBQQB1 \num_reg[3]  ( .D(n69), .CK(clk), .RB(rst_n), .Q(num[3]), .QB(
        n23) );
  IT01D3 bps_start_r_tri ( .A(n46), .OE(n47), .YN(bps_start) );
  OR02D1 U57 ( .A1(n2), .A2(n90), .Y(n1) );
  IN01D3 U58 ( .A(n92), .YN(n71) );
  IN01D17 U59 ( .A(n71), .YN(rs232_tx) );
  IN01D1 U60 ( .A(n71), .YN(n73) );
  NI01D1 U62 ( .A(n33), .Y(n90) );
  IN01D1 U63 ( .A(n29), .YN(n91) );
  ND02D2 U64 ( .A1(rx_int2), .A2(n38), .YN(n32) );
  IN01D3 U65 ( .A(n32), .YN(n2) );
endmodule

