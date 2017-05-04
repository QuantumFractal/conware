////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.20131013
//  \   \         Application: netgen
//  /   /         Filename: conware_synthesis.v
// /___/   /\     Timestamp: Sat Apr 29 00:05:50 2017
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -insert_glbl true -w -dir netgen/synthesis -ofmt verilog -sim conware.ngc conware_synthesis.v 
// Device	: xc7z020-1-clg484
// Input file	: conware.ngc
// Output file	: C:\Users\micha\Documents\projects\conware\xps\system\pcores\conware_v1_00_a\devl\projnav\netgen\synthesis\conware_synthesis.v
// # of Modules	: 1
// Design Name	: conware
// Xilinx        : C:\Xilinx\14.7\ISE_DS\ISE\
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module conware (
  ACLK, ARESETN, S_AXIS_TVALID, S_AXIS_TLAST, M_AXIS_TREADY, S_AXIS_TREADY, M_AXIS_TVALID, M_AXIS_TLAST, S_AXIS_TDATA, M_AXIS_TDATA, buffer
);
  input ACLK;
  input ARESETN;
  input S_AXIS_TVALID;
  input S_AXIS_TLAST;
  input M_AXIS_TREADY;
  output S_AXIS_TREADY;
  output M_AXIS_TVALID;
  output M_AXIS_TLAST;
  input [31 : 0] S_AXIS_TDATA;
  output [31 : 0] M_AXIS_TDATA;
  output [31 : 0] buffer;
  wire S_AXIS_TDATA_31_IBUF_0;
  wire S_AXIS_TDATA_30_IBUF_1;
  wire S_AXIS_TDATA_29_IBUF_2;
  wire S_AXIS_TDATA_28_IBUF_3;
  wire S_AXIS_TDATA_27_IBUF_4;
  wire S_AXIS_TDATA_26_IBUF_5;
  wire S_AXIS_TDATA_25_IBUF_6;
  wire S_AXIS_TDATA_24_IBUF_7;
  wire S_AXIS_TDATA_23_IBUF_8;
  wire S_AXIS_TDATA_22_IBUF_9;
  wire S_AXIS_TDATA_21_IBUF_10;
  wire S_AXIS_TDATA_20_IBUF_11;
  wire S_AXIS_TDATA_19_IBUF_12;
  wire S_AXIS_TDATA_18_IBUF_13;
  wire S_AXIS_TDATA_17_IBUF_14;
  wire S_AXIS_TDATA_16_IBUF_15;
  wire S_AXIS_TDATA_15_IBUF_16;
  wire S_AXIS_TDATA_14_IBUF_17;
  wire S_AXIS_TDATA_13_IBUF_18;
  wire S_AXIS_TDATA_12_IBUF_19;
  wire S_AXIS_TDATA_11_IBUF_20;
  wire S_AXIS_TDATA_10_IBUF_21;
  wire S_AXIS_TDATA_9_IBUF_22;
  wire S_AXIS_TDATA_8_IBUF_23;
  wire S_AXIS_TDATA_7_IBUF_24;
  wire S_AXIS_TDATA_6_IBUF_25;
  wire S_AXIS_TDATA_5_IBUF_26;
  wire S_AXIS_TDATA_4_IBUF_27;
  wire S_AXIS_TDATA_3_IBUF_28;
  wire S_AXIS_TDATA_2_IBUF_29;
  wire S_AXIS_TDATA_1_IBUF_30;
  wire S_AXIS_TDATA_0_IBUF_31;
  wire ACLK_BUFGP_32;
  wire ARESETN_IBUF_33;
  wire S_AXIS_TVALID_IBUF_34;
  wire M_AXIS_TREADY_IBUF_35;
  wire \a2b/out_data_31_36 ;
  wire \a2b/out_data_30_37 ;
  wire \a2b/out_data_29_38 ;
  wire \a2b/out_data_28_39 ;
  wire \a2b/out_data_27_40 ;
  wire \a2b/out_data_26_41 ;
  wire \a2b/out_data_25_42 ;
  wire \a2b/out_data_24_43 ;
  wire \a2b/out_data_23_44 ;
  wire \a2b/out_data_22_45 ;
  wire \a2b/out_data_21_46 ;
  wire \a2b/out_data_20_47 ;
  wire \a2b/out_data_19_48 ;
  wire \a2b/out_data_18_49 ;
  wire \a2b/out_data_17_50 ;
  wire \a2b/out_data_16_51 ;
  wire \a2b/out_data_15_52 ;
  wire \a2b/out_data_14_53 ;
  wire \a2b/out_data_13_54 ;
  wire \a2b/out_data_12_55 ;
  wire \a2b/out_data_11_56 ;
  wire \a2b/out_data_10_57 ;
  wire \a2b/out_data_9_58 ;
  wire \a2b/out_data_8_59 ;
  wire \a2b/out_data_7_60 ;
  wire \a2b/out_data_6_61 ;
  wire \a2b/out_data_5_62 ;
  wire \a2b/out_data_4_63 ;
  wire \a2b/out_data_3_64 ;
  wire \a2b/out_data_2_65 ;
  wire \a2b/out_data_1_66 ;
  wire \a2b/out_data_0_67 ;
  wire \a2b/state_68 ;
  wire \b2a/state_101 ;
  wire M_AXIS_TLAST_OBUF_102;
  wire \a2b/_n0230_inv1 ;
  wire \a2b/_n0182_inv1 ;
  wire \a2b/_n0227_inv1 ;
  wire \a2b/_n0179_inv2 ;
  wire \a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_7_107 ;
  wire \a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_8_108 ;
  wire \a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_81_109 ;
  wire \a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_9_110 ;
  wire \a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_3_111 ;
  wire \a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_82_112 ;
  wire \a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_91_113 ;
  wire \a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_92_114 ;
  wire \a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_10_115 ;
  wire \a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_4_116 ;
  wire \a2b/Mcount_counter4 ;
  wire \a2b/Mcount_counter3 ;
  wire \a2b/Mcount_counter2 ;
  wire \a2b/Mcount_counter1 ;
  wire \a2b/Mcount_counter ;
  wire \a2b/GND_2_o_GND_2_o_equal_6_o_inv ;
  wire \a2b/Mcount_counter_val ;
  wire \a2b/rstn_inv ;
  wire \a2b/in_state ;
  wire \a2b/next_state ;
  wire \b2a/Mcount_counter4 ;
  wire \b2a/Mcount_counter3 ;
  wire \b2a/Mcount_counter2 ;
  wire \b2a/Mcount_counter1 ;
  wire \b2a/Mcount_counter ;
  wire \b2a/GND_3_o_GND_3_o_equal_8_o_inv ;
  wire \b2a/Mcount_counter_val ;
  wire \b2a/_n0057_inv ;
  wire \b2a/GND_3_o_GND_3_o_equal_8_o ;
  wire \b2a/next_state ;
  wire \a2b/Mmux_in_state1 ;
  wire \a2b/Mmux_in_state11_167 ;
  wire \a2b/Mmux_in_state12_168 ;
  wire \a2b/Mmux_in_state13_169 ;
  wire \a2b/Mmux_in_state14_170 ;
  wire \a2b/Mmux_in_state15_171 ;
  wire \a2b/out_data_31_rstpot_275 ;
  wire \a2b/out_data_1_rstpot_276 ;
  wire \a2b/out_data_2_rstpot_277 ;
  wire \a2b/out_data_0_rstpot_278 ;
  wire \a2b/out_data_3_rstpot_279 ;
  wire \a2b/out_data_4_rstpot_280 ;
  wire \a2b/out_data_6_rstpot_281 ;
  wire \a2b/out_data_7_rstpot_282 ;
  wire \a2b/out_data_5_rstpot_283 ;
  wire \a2b/out_data_8_rstpot_284 ;
  wire \a2b/out_data_9_rstpot_285 ;
  wire \a2b/out_data_11_rstpot_286 ;
  wire \a2b/out_data_12_rstpot_287 ;
  wire \a2b/out_data_10_rstpot_288 ;
  wire \a2b/out_data_13_rstpot_289 ;
  wire \a2b/out_data_14_rstpot_290 ;
  wire \a2b/out_data_16_rstpot_291 ;
  wire \a2b/out_data_17_rstpot_292 ;
  wire \a2b/out_data_15_rstpot_293 ;
  wire \a2b/out_data_18_rstpot_294 ;
  wire \a2b/out_data_19_rstpot_295 ;
  wire \a2b/out_data_21_rstpot_296 ;
  wire \a2b/out_data_22_rstpot_297 ;
  wire \a2b/out_data_20_rstpot_298 ;
  wire \a2b/out_data_23_rstpot_299 ;
  wire \a2b/out_data_24_rstpot_300 ;
  wire \a2b/out_data_26_rstpot_301 ;
  wire \a2b/out_data_27_rstpot_302 ;
  wire \a2b/out_data_25_rstpot_303 ;
  wire \a2b/out_data_28_rstpot_304 ;
  wire \a2b/out_data_29_rstpot_305 ;
  wire \a2b/out_data_30_rstpot_306 ;
  wire N2;
  wire [31 : 0] \b2a/buffer ;
  wire [4 : 0] \a2b/Mcount_counter_lut ;
  wire [3 : 0] \a2b/Mcount_counter_cy ;
  wire [5 : 0] \a2b/counter ;
  wire [4 : 0] \b2a/Mcount_counter_lut ;
  wire [3 : 0] \b2a/Mcount_counter_cy ;
  wire [4 : 0] \b2a/counter ;
  GND   XST_GND (
    .G(\a2b/counter [5])
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  \a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_7  (
    .I0(\a2b/out_data_16_51 ),
    .I1(\a2b/out_data_17_50 ),
    .I2(\a2b/out_data_19_48 ),
    .I3(\a2b/out_data_18_49 ),
    .I4(\a2b/counter [0]),
    .I5(\a2b/counter [1]),
    .O(\a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_7_107 )
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  \a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_8  (
    .I0(\a2b/out_data_20_47 ),
    .I1(\a2b/out_data_21_46 ),
    .I2(\a2b/out_data_23_44 ),
    .I3(\a2b/out_data_22_45 ),
    .I4(\a2b/counter [0]),
    .I5(\a2b/counter [1]),
    .O(\a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_8_108 )
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  \a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_81  (
    .I0(\a2b/out_data_24_43 ),
    .I1(\a2b/out_data_25_42 ),
    .I2(\a2b/out_data_27_40 ),
    .I3(\a2b/out_data_26_41 ),
    .I4(\a2b/counter [0]),
    .I5(\a2b/counter [1]),
    .O(\a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_81_109 )
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  \a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_9  (
    .I0(\a2b/out_data_28_39 ),
    .I1(\a2b/out_data_29_38 ),
    .I2(\a2b/out_data_31_36 ),
    .I3(\a2b/out_data_30_37 ),
    .I4(\a2b/counter [0]),
    .I5(\a2b/counter [1]),
    .O(\a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_9_110 )
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  \a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_3  (
    .I0(\a2b/counter [3]),
    .I1(\a2b/counter [2]),
    .I2(\a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_81_109 ),
    .I3(\a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_9_110 ),
    .I4(\a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_8_108 ),
    .I5(\a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_7_107 ),
    .O(\a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_3_111 )
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  \a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_82  (
    .I0(\a2b/out_data_0_67 ),
    .I1(\a2b/out_data_1_66 ),
    .I2(\a2b/out_data_3_64 ),
    .I3(\a2b/out_data_2_65 ),
    .I4(\a2b/counter [0]),
    .I5(\a2b/counter [1]),
    .O(\a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_82_112 )
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  \a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_91  (
    .I0(\a2b/out_data_4_63 ),
    .I1(\a2b/out_data_5_62 ),
    .I2(\a2b/out_data_7_60 ),
    .I3(\a2b/out_data_6_61 ),
    .I4(\a2b/counter [0]),
    .I5(\a2b/counter [1]),
    .O(\a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_91_113 )
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  \a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_92  (
    .I0(\a2b/out_data_8_59 ),
    .I1(\a2b/out_data_9_58 ),
    .I2(\a2b/out_data_11_56 ),
    .I3(\a2b/out_data_10_57 ),
    .I4(\a2b/counter [0]),
    .I5(\a2b/counter [1]),
    .O(\a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_92_114 )
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  \a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_10  (
    .I0(\a2b/out_data_12_55 ),
    .I1(\a2b/out_data_13_54 ),
    .I2(\a2b/out_data_15_52 ),
    .I3(\a2b/out_data_14_53 ),
    .I4(\a2b/counter [0]),
    .I5(\a2b/counter [1]),
    .O(\a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_10_115 )
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  \a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_4  (
    .I0(\a2b/counter [3]),
    .I1(\a2b/counter [2]),
    .I2(\a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_92_114 ),
    .I3(\a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_10_115 ),
    .I4(\a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_91_113 ),
    .I5(\a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_82_112 ),
    .O(\a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_4_116 )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \a2b/counter_3  (
    .C(ACLK_BUFGP_32),
    .CE(S_AXIS_TVALID_IBUF_34),
    .D(\a2b/Mcount_counter3 ),
    .R(\a2b/Mcount_counter_val ),
    .Q(\a2b/counter [3])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \a2b/counter_2  (
    .C(ACLK_BUFGP_32),
    .CE(S_AXIS_TVALID_IBUF_34),
    .D(\a2b/Mcount_counter2 ),
    .R(\a2b/Mcount_counter_val ),
    .Q(\a2b/counter [2])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \a2b/counter_4  (
    .C(ACLK_BUFGP_32),
    .CE(S_AXIS_TVALID_IBUF_34),
    .D(\a2b/Mcount_counter4 ),
    .R(\a2b/Mcount_counter_val ),
    .Q(\a2b/counter [4])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \a2b/counter_0  (
    .C(ACLK_BUFGP_32),
    .CE(S_AXIS_TVALID_IBUF_34),
    .D(\a2b/Mcount_counter ),
    .R(\a2b/Mcount_counter_val ),
    .Q(\a2b/counter [0])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \a2b/counter_1  (
    .C(ACLK_BUFGP_32),
    .CE(S_AXIS_TVALID_IBUF_34),
    .D(\a2b/Mcount_counter1 ),
    .R(\a2b/Mcount_counter_val ),
    .Q(\a2b/counter [1])
  );
  XORCY   \a2b/Mcount_counter_xor<4>  (
    .CI(\a2b/Mcount_counter_cy [3]),
    .LI(\a2b/Mcount_counter_lut [4]),
    .O(\a2b/Mcount_counter4 )
  );
  XORCY   \a2b/Mcount_counter_xor<3>  (
    .CI(\a2b/Mcount_counter_cy [2]),
    .LI(\a2b/Mcount_counter_lut [3]),
    .O(\a2b/Mcount_counter3 )
  );
  MUXCY   \a2b/Mcount_counter_cy<3>  (
    .CI(\a2b/Mcount_counter_cy [2]),
    .DI(\a2b/counter [5]),
    .S(\a2b/Mcount_counter_lut [3]),
    .O(\a2b/Mcount_counter_cy [3])
  );
  XORCY   \a2b/Mcount_counter_xor<2>  (
    .CI(\a2b/Mcount_counter_cy [1]),
    .LI(\a2b/Mcount_counter_lut [2]),
    .O(\a2b/Mcount_counter2 )
  );
  MUXCY   \a2b/Mcount_counter_cy<2>  (
    .CI(\a2b/Mcount_counter_cy [1]),
    .DI(\a2b/counter [5]),
    .S(\a2b/Mcount_counter_lut [2]),
    .O(\a2b/Mcount_counter_cy [2])
  );
  XORCY   \a2b/Mcount_counter_xor<1>  (
    .CI(\a2b/Mcount_counter_cy [0]),
    .LI(\a2b/Mcount_counter_lut [1]),
    .O(\a2b/Mcount_counter1 )
  );
  MUXCY   \a2b/Mcount_counter_cy<1>  (
    .CI(\a2b/Mcount_counter_cy [0]),
    .DI(\a2b/counter [5]),
    .S(\a2b/Mcount_counter_lut [1]),
    .O(\a2b/Mcount_counter_cy [1])
  );
  XORCY   \a2b/Mcount_counter_xor<0>  (
    .CI(\a2b/GND_2_o_GND_2_o_equal_6_o_inv ),
    .LI(\a2b/Mcount_counter_lut [0]),
    .O(\a2b/Mcount_counter )
  );
  MUXCY   \a2b/Mcount_counter_cy<0>  (
    .CI(\a2b/GND_2_o_GND_2_o_equal_6_o_inv ),
    .DI(\a2b/counter [5]),
    .S(\a2b/Mcount_counter_lut [0]),
    .O(\a2b/Mcount_counter_cy [0])
  );
  FDS   \a2b/state  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/next_state ),
    .S(\a2b/rstn_inv ),
    .Q(\a2b/state_68 )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \b2a/counter_4  (
    .C(ACLK_BUFGP_32),
    .CE(M_AXIS_TREADY_IBUF_35),
    .D(\b2a/Mcount_counter4 ),
    .R(\b2a/Mcount_counter_val ),
    .Q(\b2a/counter [4])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \b2a/counter_3  (
    .C(ACLK_BUFGP_32),
    .CE(M_AXIS_TREADY_IBUF_35),
    .D(\b2a/Mcount_counter3 ),
    .R(\b2a/Mcount_counter_val ),
    .Q(\b2a/counter [3])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \b2a/counter_1  (
    .C(ACLK_BUFGP_32),
    .CE(M_AXIS_TREADY_IBUF_35),
    .D(\b2a/Mcount_counter1 ),
    .R(\b2a/Mcount_counter_val ),
    .Q(\b2a/counter [1])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \b2a/counter_0  (
    .C(ACLK_BUFGP_32),
    .CE(M_AXIS_TREADY_IBUF_35),
    .D(\b2a/Mcount_counter ),
    .R(\b2a/Mcount_counter_val ),
    .Q(\b2a/counter [0])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \b2a/counter_2  (
    .C(ACLK_BUFGP_32),
    .CE(M_AXIS_TREADY_IBUF_35),
    .D(\b2a/Mcount_counter2 ),
    .R(\b2a/Mcount_counter_val ),
    .Q(\b2a/counter [2])
  );
  XORCY   \b2a/Mcount_counter_xor<4>  (
    .CI(\b2a/Mcount_counter_cy [3]),
    .LI(\b2a/Mcount_counter_lut [4]),
    .O(\b2a/Mcount_counter4 )
  );
  XORCY   \b2a/Mcount_counter_xor<3>  (
    .CI(\b2a/Mcount_counter_cy [2]),
    .LI(\b2a/Mcount_counter_lut [3]),
    .O(\b2a/Mcount_counter3 )
  );
  MUXCY   \b2a/Mcount_counter_cy<3>  (
    .CI(\b2a/Mcount_counter_cy [2]),
    .DI(\a2b/counter [5]),
    .S(\b2a/Mcount_counter_lut [3]),
    .O(\b2a/Mcount_counter_cy [3])
  );
  XORCY   \b2a/Mcount_counter_xor<2>  (
    .CI(\b2a/Mcount_counter_cy [1]),
    .LI(\b2a/Mcount_counter_lut [2]),
    .O(\b2a/Mcount_counter2 )
  );
  MUXCY   \b2a/Mcount_counter_cy<2>  (
    .CI(\b2a/Mcount_counter_cy [1]),
    .DI(\a2b/counter [5]),
    .S(\b2a/Mcount_counter_lut [2]),
    .O(\b2a/Mcount_counter_cy [2])
  );
  XORCY   \b2a/Mcount_counter_xor<1>  (
    .CI(\b2a/Mcount_counter_cy [0]),
    .LI(\b2a/Mcount_counter_lut [1]),
    .O(\b2a/Mcount_counter1 )
  );
  MUXCY   \b2a/Mcount_counter_cy<1>  (
    .CI(\b2a/Mcount_counter_cy [0]),
    .DI(\a2b/counter [5]),
    .S(\b2a/Mcount_counter_lut [1]),
    .O(\b2a/Mcount_counter_cy [1])
  );
  XORCY   \b2a/Mcount_counter_xor<0>  (
    .CI(\b2a/GND_3_o_GND_3_o_equal_8_o_inv ),
    .LI(\b2a/Mcount_counter_lut [0]),
    .O(\b2a/Mcount_counter )
  );
  MUXCY   \b2a/Mcount_counter_cy<0>  (
    .CI(\b2a/GND_3_o_GND_3_o_equal_8_o_inv ),
    .DI(\a2b/counter [5]),
    .S(\b2a/Mcount_counter_lut [0]),
    .O(\b2a/Mcount_counter_cy [0])
  );
  FDR   \b2a/state  (
    .C(ACLK_BUFGP_32),
    .D(\b2a/next_state ),
    .R(\a2b/rstn_inv ),
    .Q(\b2a/state_101 )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_31  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_31_36 ),
    .Q(\b2a/buffer [31])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_30  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_30_37 ),
    .Q(\b2a/buffer [30])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_29  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_29_38 ),
    .Q(\b2a/buffer [29])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_28  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_28_39 ),
    .Q(\b2a/buffer [28])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_27  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_27_40 ),
    .Q(\b2a/buffer [27])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_26  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_26_41 ),
    .Q(\b2a/buffer [26])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_25  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_25_42 ),
    .Q(\b2a/buffer [25])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_24  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_24_43 ),
    .Q(\b2a/buffer [24])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_23  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_23_44 ),
    .Q(\b2a/buffer [23])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_22  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_22_45 ),
    .Q(\b2a/buffer [22])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_21  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_21_46 ),
    .Q(\b2a/buffer [21])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_20  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_20_47 ),
    .Q(\b2a/buffer [20])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_19  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_19_48 ),
    .Q(\b2a/buffer [19])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_18  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_18_49 ),
    .Q(\b2a/buffer [18])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_17  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_17_50 ),
    .Q(\b2a/buffer [17])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_16  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_16_51 ),
    .Q(\b2a/buffer [16])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_15  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_15_52 ),
    .Q(\b2a/buffer [15])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_14  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_14_53 ),
    .Q(\b2a/buffer [14])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_13  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_13_54 ),
    .Q(\b2a/buffer [13])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_12  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_12_55 ),
    .Q(\b2a/buffer [12])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_11  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_11_56 ),
    .Q(\b2a/buffer [11])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_10  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_10_57 ),
    .Q(\b2a/buffer [10])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_9  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_9_58 ),
    .Q(\b2a/buffer [9])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_8  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_8_59 ),
    .Q(\b2a/buffer [8])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_7  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_7_60 ),
    .Q(\b2a/buffer [7])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_6  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_6_61 ),
    .Q(\b2a/buffer [6])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_5  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_5_62 ),
    .Q(\b2a/buffer [5])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_4  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_4_63 ),
    .Q(\b2a/buffer [4])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_3  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_3_64 ),
    .Q(\b2a/buffer [3])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_2  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_2_65 ),
    .Q(\b2a/buffer [2])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_1  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_1_66 ),
    .Q(\b2a/buffer [1])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \b2a/buffer_0  (
    .C(ACLK_BUFGP_32),
    .CE(\b2a/_n0057_inv ),
    .D(\a2b/out_data_0_67 ),
    .Q(\b2a/buffer [0])
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  \a2b/_n0230_inv11  (
    .I0(\a2b/counter [0]),
    .I1(\a2b/counter [4]),
    .I2(ARESETN_IBUF_33),
    .O(\a2b/_n0230_inv1 )
  );
  LUT3 #(
    .INIT ( 8'h40 ))
  \a2b/_n0182_inv11  (
    .I0(\a2b/counter [0]),
    .I1(\a2b/counter [4]),
    .I2(ARESETN_IBUF_33),
    .O(\a2b/_n0182_inv1 )
  );
  LUT3 #(
    .INIT ( 8'h40 ))
  \a2b/_n0227_inv11  (
    .I0(\a2b/counter [4]),
    .I1(\a2b/counter [0]),
    .I2(ARESETN_IBUF_33),
    .O(\a2b/_n0227_inv1 )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \a2b/_n0179_inv21  (
    .I0(\a2b/counter [0]),
    .I1(\a2b/counter [4]),
    .I2(ARESETN_IBUF_33),
    .O(\a2b/_n0179_inv2 )
  );
  LUT4 #(
    .INIT ( 16'h8ADF ))
  \a2b/Mmux_next_state11  (
    .I0(\a2b/state_68 ),
    .I1(\a2b/GND_2_o_GND_2_o_equal_6_o_inv ),
    .I2(S_AXIS_TVALID_IBUF_34),
    .I3(\b2a/state_101 ),
    .O(\a2b/next_state )
  );
  LUT5 #(
    .INIT ( 32'h7FFFFFFF ))
  \a2b/GND_2_o_GND_2_o_equal_6_o_inv1  (
    .I0(\a2b/counter [4]),
    .I1(\a2b/counter [3]),
    .I2(\a2b/counter [2]),
    .I3(\a2b/counter [1]),
    .I4(\a2b/counter [0]),
    .O(\a2b/GND_2_o_GND_2_o_equal_6_o_inv )
  );
  LUT2 #(
    .INIT ( 4'h7 ))
  \a2b/Mcount_counter_val1  (
    .I0(ARESETN_IBUF_33),
    .I1(\a2b/state_68 ),
    .O(\a2b/Mcount_counter_val )
  );
  LUT4 #(
    .INIT ( 16'h2A7F ))
  \b2a/Mmux_next_state11  (
    .I0(\b2a/state_101 ),
    .I1(M_AXIS_TREADY_IBUF_35),
    .I2(\b2a/GND_3_o_GND_3_o_equal_8_o ),
    .I3(\a2b/state_68 ),
    .O(\b2a/next_state )
  );
  LUT2 #(
    .INIT ( 4'h7 ))
  \b2a/Mcount_counter_val1  (
    .I0(ARESETN_IBUF_33),
    .I1(\b2a/state_101 ),
    .O(\b2a/Mcount_counter_val )
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  \b2a/_n0057_inv1  (
    .I0(\b2a/state_101 ),
    .I1(\a2b/state_68 ),
    .I2(ARESETN_IBUF_33),
    .O(\b2a/_n0057_inv )
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  \b2a/GND_3_o_GND_3_o_equal_8_o<7>1  (
    .I0(\b2a/counter [4]),
    .I1(\b2a/counter [3]),
    .I2(\b2a/counter [2]),
    .I3(\b2a/counter [1]),
    .I4(\b2a/counter [0]),
    .O(\b2a/GND_3_o_GND_3_o_equal_8_o )
  );
  LUT6 #(
    .INIT ( 64'h8000000000000000 ))
  \a2b/Mmux_in_state11  (
    .I0(S_AXIS_TDATA_3_IBUF_28),
    .I1(S_AXIS_TDATA_4_IBUF_27),
    .I2(S_AXIS_TDATA_23_IBUF_8),
    .I3(S_AXIS_TDATA_2_IBUF_29),
    .I4(S_AXIS_TDATA_21_IBUF_10),
    .I5(S_AXIS_TDATA_22_IBUF_9),
    .O(\a2b/Mmux_in_state1 )
  );
  LUT6 #(
    .INIT ( 64'h8000000000000000 ))
  \a2b/Mmux_in_state12  (
    .I0(S_AXIS_TDATA_9_IBUF_22),
    .I1(S_AXIS_TVALID_IBUF_34),
    .I2(S_AXIS_TDATA_7_IBUF_24),
    .I3(S_AXIS_TDATA_8_IBUF_23),
    .I4(S_AXIS_TDATA_5_IBUF_26),
    .I5(S_AXIS_TDATA_6_IBUF_25),
    .O(\a2b/Mmux_in_state11_167 )
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  \a2b/Mmux_in_state13  (
    .I0(S_AXIS_TDATA_30_IBUF_1),
    .I1(S_AXIS_TDATA_31_IBUF_0),
    .I2(S_AXIS_TDATA_29_IBUF_2),
    .I3(S_AXIS_TDATA_28_IBUF_3),
    .I4(S_AXIS_TDATA_27_IBUF_4),
    .I5(S_AXIS_TDATA_26_IBUF_5),
    .O(\a2b/Mmux_in_state12_168 )
  );
  LUT5 #(
    .INIT ( 32'h00000080 ))
  \a2b/Mmux_in_state14  (
    .I0(\a2b/Mmux_in_state1 ),
    .I1(\a2b/Mmux_in_state11_167 ),
    .I2(\a2b/Mmux_in_state12_168 ),
    .I3(S_AXIS_TDATA_24_IBUF_7),
    .I4(S_AXIS_TDATA_25_IBUF_6),
    .O(\a2b/Mmux_in_state13_169 )
  );
  LUT6 #(
    .INIT ( 64'h8000000000000000 ))
  \a2b/Mmux_in_state15  (
    .I0(S_AXIS_TDATA_14_IBUF_17),
    .I1(S_AXIS_TDATA_15_IBUF_16),
    .I2(S_AXIS_TDATA_12_IBUF_19),
    .I3(S_AXIS_TDATA_13_IBUF_18),
    .I4(S_AXIS_TDATA_10_IBUF_21),
    .I5(S_AXIS_TDATA_11_IBUF_20),
    .O(\a2b/Mmux_in_state14_170 )
  );
  LUT6 #(
    .INIT ( 64'h8000000000000000 ))
  \a2b/Mmux_in_state16  (
    .I0(S_AXIS_TDATA_1_IBUF_30),
    .I1(S_AXIS_TDATA_20_IBUF_11),
    .I2(S_AXIS_TDATA_18_IBUF_13),
    .I3(S_AXIS_TDATA_19_IBUF_12),
    .I4(S_AXIS_TDATA_16_IBUF_15),
    .I5(S_AXIS_TDATA_17_IBUF_14),
    .O(\a2b/Mmux_in_state15_171 )
  );
  IBUF   S_AXIS_TDATA_31_IBUF (
    .I(S_AXIS_TDATA[31]),
    .O(S_AXIS_TDATA_31_IBUF_0)
  );
  IBUF   S_AXIS_TDATA_30_IBUF (
    .I(S_AXIS_TDATA[30]),
    .O(S_AXIS_TDATA_30_IBUF_1)
  );
  IBUF   S_AXIS_TDATA_29_IBUF (
    .I(S_AXIS_TDATA[29]),
    .O(S_AXIS_TDATA_29_IBUF_2)
  );
  IBUF   S_AXIS_TDATA_28_IBUF (
    .I(S_AXIS_TDATA[28]),
    .O(S_AXIS_TDATA_28_IBUF_3)
  );
  IBUF   S_AXIS_TDATA_27_IBUF (
    .I(S_AXIS_TDATA[27]),
    .O(S_AXIS_TDATA_27_IBUF_4)
  );
  IBUF   S_AXIS_TDATA_26_IBUF (
    .I(S_AXIS_TDATA[26]),
    .O(S_AXIS_TDATA_26_IBUF_5)
  );
  IBUF   S_AXIS_TDATA_25_IBUF (
    .I(S_AXIS_TDATA[25]),
    .O(S_AXIS_TDATA_25_IBUF_6)
  );
  IBUF   S_AXIS_TDATA_24_IBUF (
    .I(S_AXIS_TDATA[24]),
    .O(S_AXIS_TDATA_24_IBUF_7)
  );
  IBUF   S_AXIS_TDATA_23_IBUF (
    .I(S_AXIS_TDATA[23]),
    .O(S_AXIS_TDATA_23_IBUF_8)
  );
  IBUF   S_AXIS_TDATA_22_IBUF (
    .I(S_AXIS_TDATA[22]),
    .O(S_AXIS_TDATA_22_IBUF_9)
  );
  IBUF   S_AXIS_TDATA_21_IBUF (
    .I(S_AXIS_TDATA[21]),
    .O(S_AXIS_TDATA_21_IBUF_10)
  );
  IBUF   S_AXIS_TDATA_20_IBUF (
    .I(S_AXIS_TDATA[20]),
    .O(S_AXIS_TDATA_20_IBUF_11)
  );
  IBUF   S_AXIS_TDATA_19_IBUF (
    .I(S_AXIS_TDATA[19]),
    .O(S_AXIS_TDATA_19_IBUF_12)
  );
  IBUF   S_AXIS_TDATA_18_IBUF (
    .I(S_AXIS_TDATA[18]),
    .O(S_AXIS_TDATA_18_IBUF_13)
  );
  IBUF   S_AXIS_TDATA_17_IBUF (
    .I(S_AXIS_TDATA[17]),
    .O(S_AXIS_TDATA_17_IBUF_14)
  );
  IBUF   S_AXIS_TDATA_16_IBUF (
    .I(S_AXIS_TDATA[16]),
    .O(S_AXIS_TDATA_16_IBUF_15)
  );
  IBUF   S_AXIS_TDATA_15_IBUF (
    .I(S_AXIS_TDATA[15]),
    .O(S_AXIS_TDATA_15_IBUF_16)
  );
  IBUF   S_AXIS_TDATA_14_IBUF (
    .I(S_AXIS_TDATA[14]),
    .O(S_AXIS_TDATA_14_IBUF_17)
  );
  IBUF   S_AXIS_TDATA_13_IBUF (
    .I(S_AXIS_TDATA[13]),
    .O(S_AXIS_TDATA_13_IBUF_18)
  );
  IBUF   S_AXIS_TDATA_12_IBUF (
    .I(S_AXIS_TDATA[12]),
    .O(S_AXIS_TDATA_12_IBUF_19)
  );
  IBUF   S_AXIS_TDATA_11_IBUF (
    .I(S_AXIS_TDATA[11]),
    .O(S_AXIS_TDATA_11_IBUF_20)
  );
  IBUF   S_AXIS_TDATA_10_IBUF (
    .I(S_AXIS_TDATA[10]),
    .O(S_AXIS_TDATA_10_IBUF_21)
  );
  IBUF   S_AXIS_TDATA_9_IBUF (
    .I(S_AXIS_TDATA[9]),
    .O(S_AXIS_TDATA_9_IBUF_22)
  );
  IBUF   S_AXIS_TDATA_8_IBUF (
    .I(S_AXIS_TDATA[8]),
    .O(S_AXIS_TDATA_8_IBUF_23)
  );
  IBUF   S_AXIS_TDATA_7_IBUF (
    .I(S_AXIS_TDATA[7]),
    .O(S_AXIS_TDATA_7_IBUF_24)
  );
  IBUF   S_AXIS_TDATA_6_IBUF (
    .I(S_AXIS_TDATA[6]),
    .O(S_AXIS_TDATA_6_IBUF_25)
  );
  IBUF   S_AXIS_TDATA_5_IBUF (
    .I(S_AXIS_TDATA[5]),
    .O(S_AXIS_TDATA_5_IBUF_26)
  );
  IBUF   S_AXIS_TDATA_4_IBUF (
    .I(S_AXIS_TDATA[4]),
    .O(S_AXIS_TDATA_4_IBUF_27)
  );
  IBUF   S_AXIS_TDATA_3_IBUF (
    .I(S_AXIS_TDATA[3]),
    .O(S_AXIS_TDATA_3_IBUF_28)
  );
  IBUF   S_AXIS_TDATA_2_IBUF (
    .I(S_AXIS_TDATA[2]),
    .O(S_AXIS_TDATA_2_IBUF_29)
  );
  IBUF   S_AXIS_TDATA_1_IBUF (
    .I(S_AXIS_TDATA[1]),
    .O(S_AXIS_TDATA_1_IBUF_30)
  );
  IBUF   S_AXIS_TDATA_0_IBUF (
    .I(S_AXIS_TDATA[0]),
    .O(S_AXIS_TDATA_0_IBUF_31)
  );
  IBUF   ARESETN_IBUF (
    .I(ARESETN),
    .O(ARESETN_IBUF_33)
  );
  IBUF   S_AXIS_TVALID_IBUF (
    .I(S_AXIS_TVALID),
    .O(S_AXIS_TVALID_IBUF_34)
  );
  IBUF   M_AXIS_TREADY_IBUF (
    .I(M_AXIS_TREADY),
    .O(M_AXIS_TREADY_IBUF_35)
  );
  OBUF   M_AXIS_TDATA_31_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[31])
  );
  OBUF   M_AXIS_TDATA_30_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[30])
  );
  OBUF   M_AXIS_TDATA_29_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[29])
  );
  OBUF   M_AXIS_TDATA_28_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[28])
  );
  OBUF   M_AXIS_TDATA_27_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[27])
  );
  OBUF   M_AXIS_TDATA_26_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[26])
  );
  OBUF   M_AXIS_TDATA_25_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[25])
  );
  OBUF   M_AXIS_TDATA_24_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[24])
  );
  OBUF   M_AXIS_TDATA_23_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[23])
  );
  OBUF   M_AXIS_TDATA_22_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[22])
  );
  OBUF   M_AXIS_TDATA_21_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[21])
  );
  OBUF   M_AXIS_TDATA_20_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[20])
  );
  OBUF   M_AXIS_TDATA_19_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[19])
  );
  OBUF   M_AXIS_TDATA_18_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[18])
  );
  OBUF   M_AXIS_TDATA_17_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[17])
  );
  OBUF   M_AXIS_TDATA_16_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[16])
  );
  OBUF   M_AXIS_TDATA_15_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[15])
  );
  OBUF   M_AXIS_TDATA_14_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[14])
  );
  OBUF   M_AXIS_TDATA_13_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[13])
  );
  OBUF   M_AXIS_TDATA_12_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[12])
  );
  OBUF   M_AXIS_TDATA_11_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[11])
  );
  OBUF   M_AXIS_TDATA_10_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[10])
  );
  OBUF   M_AXIS_TDATA_9_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[9])
  );
  OBUF   M_AXIS_TDATA_8_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[8])
  );
  OBUF   M_AXIS_TDATA_7_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[7])
  );
  OBUF   M_AXIS_TDATA_6_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[6])
  );
  OBUF   M_AXIS_TDATA_5_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[5])
  );
  OBUF   M_AXIS_TDATA_4_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[4])
  );
  OBUF   M_AXIS_TDATA_3_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[3])
  );
  OBUF   M_AXIS_TDATA_2_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[2])
  );
  OBUF   M_AXIS_TDATA_1_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[1])
  );
  OBUF   M_AXIS_TDATA_0_OBUF (
    .I(\a2b/counter [5]),
    .O(M_AXIS_TDATA[0])
  );
  OBUF   buffer_31_OBUF (
    .I(\b2a/buffer [31]),
    .O(buffer[31])
  );
  OBUF   buffer_30_OBUF (
    .I(\b2a/buffer [30]),
    .O(buffer[30])
  );
  OBUF   buffer_29_OBUF (
    .I(\b2a/buffer [29]),
    .O(buffer[29])
  );
  OBUF   buffer_28_OBUF (
    .I(\b2a/buffer [28]),
    .O(buffer[28])
  );
  OBUF   buffer_27_OBUF (
    .I(\b2a/buffer [27]),
    .O(buffer[27])
  );
  OBUF   buffer_26_OBUF (
    .I(\b2a/buffer [26]),
    .O(buffer[26])
  );
  OBUF   buffer_25_OBUF (
    .I(\b2a/buffer [25]),
    .O(buffer[25])
  );
  OBUF   buffer_24_OBUF (
    .I(\b2a/buffer [24]),
    .O(buffer[24])
  );
  OBUF   buffer_23_OBUF (
    .I(\b2a/buffer [23]),
    .O(buffer[23])
  );
  OBUF   buffer_22_OBUF (
    .I(\b2a/buffer [22]),
    .O(buffer[22])
  );
  OBUF   buffer_21_OBUF (
    .I(\b2a/buffer [21]),
    .O(buffer[21])
  );
  OBUF   buffer_20_OBUF (
    .I(\b2a/buffer [20]),
    .O(buffer[20])
  );
  OBUF   buffer_19_OBUF (
    .I(\b2a/buffer [19]),
    .O(buffer[19])
  );
  OBUF   buffer_18_OBUF (
    .I(\b2a/buffer [18]),
    .O(buffer[18])
  );
  OBUF   buffer_17_OBUF (
    .I(\b2a/buffer [17]),
    .O(buffer[17])
  );
  OBUF   buffer_16_OBUF (
    .I(\b2a/buffer [16]),
    .O(buffer[16])
  );
  OBUF   buffer_15_OBUF (
    .I(\b2a/buffer [15]),
    .O(buffer[15])
  );
  OBUF   buffer_14_OBUF (
    .I(\b2a/buffer [14]),
    .O(buffer[14])
  );
  OBUF   buffer_13_OBUF (
    .I(\b2a/buffer [13]),
    .O(buffer[13])
  );
  OBUF   buffer_12_OBUF (
    .I(\b2a/buffer [12]),
    .O(buffer[12])
  );
  OBUF   buffer_11_OBUF (
    .I(\b2a/buffer [11]),
    .O(buffer[11])
  );
  OBUF   buffer_10_OBUF (
    .I(\b2a/buffer [10]),
    .O(buffer[10])
  );
  OBUF   buffer_9_OBUF (
    .I(\b2a/buffer [9]),
    .O(buffer[9])
  );
  OBUF   buffer_8_OBUF (
    .I(\b2a/buffer [8]),
    .O(buffer[8])
  );
  OBUF   buffer_7_OBUF (
    .I(\b2a/buffer [7]),
    .O(buffer[7])
  );
  OBUF   buffer_6_OBUF (
    .I(\b2a/buffer [6]),
    .O(buffer[6])
  );
  OBUF   buffer_5_OBUF (
    .I(\b2a/buffer [5]),
    .O(buffer[5])
  );
  OBUF   buffer_4_OBUF (
    .I(\b2a/buffer [4]),
    .O(buffer[4])
  );
  OBUF   buffer_3_OBUF (
    .I(\b2a/buffer [3]),
    .O(buffer[3])
  );
  OBUF   buffer_2_OBUF (
    .I(\b2a/buffer [2]),
    .O(buffer[2])
  );
  OBUF   buffer_1_OBUF (
    .I(\b2a/buffer [1]),
    .O(buffer[1])
  );
  OBUF   buffer_0_OBUF (
    .I(\b2a/buffer [0]),
    .O(buffer[0])
  );
  OBUF   S_AXIS_TREADY_OBUF (
    .I(\a2b/state_68 ),
    .O(S_AXIS_TREADY)
  );
  OBUF   M_AXIS_TVALID_OBUF (
    .I(\b2a/state_101 ),
    .O(M_AXIS_TVALID)
  );
  OBUF   M_AXIS_TLAST_OBUF (
    .I(M_AXIS_TLAST_OBUF_102),
    .O(M_AXIS_TLAST)
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_31  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_31_rstpot_275 ),
    .Q(\a2b/out_data_31_36 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_1  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_1_rstpot_276 ),
    .Q(\a2b/out_data_1_66 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_2  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_2_rstpot_277 ),
    .Q(\a2b/out_data_2_65 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_0  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_0_rstpot_278 ),
    .Q(\a2b/out_data_0_67 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_3  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_3_rstpot_279 ),
    .Q(\a2b/out_data_3_64 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_4  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_4_rstpot_280 ),
    .Q(\a2b/out_data_4_63 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_6  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_6_rstpot_281 ),
    .Q(\a2b/out_data_6_61 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_7  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_7_rstpot_282 ),
    .Q(\a2b/out_data_7_60 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_5  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_5_rstpot_283 ),
    .Q(\a2b/out_data_5_62 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_8  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_8_rstpot_284 ),
    .Q(\a2b/out_data_8_59 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_9  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_9_rstpot_285 ),
    .Q(\a2b/out_data_9_58 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_11  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_11_rstpot_286 ),
    .Q(\a2b/out_data_11_56 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_12  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_12_rstpot_287 ),
    .Q(\a2b/out_data_12_55 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_10  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_10_rstpot_288 ),
    .Q(\a2b/out_data_10_57 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_13  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_13_rstpot_289 ),
    .Q(\a2b/out_data_13_54 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_14  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_14_rstpot_290 ),
    .Q(\a2b/out_data_14_53 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_16  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_16_rstpot_291 ),
    .Q(\a2b/out_data_16_51 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_17  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_17_rstpot_292 ),
    .Q(\a2b/out_data_17_50 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_15  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_15_rstpot_293 ),
    .Q(\a2b/out_data_15_52 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_18  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_18_rstpot_294 ),
    .Q(\a2b/out_data_18_49 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_19  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_19_rstpot_295 ),
    .Q(\a2b/out_data_19_48 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_21  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_21_rstpot_296 ),
    .Q(\a2b/out_data_21_46 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_22  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_22_rstpot_297 ),
    .Q(\a2b/out_data_22_45 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_20  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_20_rstpot_298 ),
    .Q(\a2b/out_data_20_47 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_23  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_23_rstpot_299 ),
    .Q(\a2b/out_data_23_44 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_24  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_24_rstpot_300 ),
    .Q(\a2b/out_data_24_43 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_26  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_26_rstpot_301 ),
    .Q(\a2b/out_data_26_41 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_27  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_27_rstpot_302 ),
    .Q(\a2b/out_data_27_40 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_25  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_25_rstpot_303 ),
    .Q(\a2b/out_data_25_42 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_28  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_28_rstpot_304 ),
    .Q(\a2b/out_data_28_39 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_29  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_29_rstpot_305 ),
    .Q(\a2b/out_data_29_38 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \a2b/out_data_30  (
    .C(ACLK_BUFGP_32),
    .D(\a2b/out_data_30_rstpot_306 ),
    .Q(\a2b/out_data_30_37 )
  );
  LUT6 #(
    .INIT ( 64'hEAAAAAAA2AAAAAAA ))
  \a2b/out_data_31_rstpot  (
    .I0(\a2b/out_data_31_36 ),
    .I1(\a2b/_n0179_inv2 ),
    .I2(\a2b/counter [1]),
    .I3(\a2b/counter [2]),
    .I4(\a2b/counter [3]),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_31_rstpot_275 )
  );
  LUT6 #(
    .INIT ( 64'hAAABAAAAAAA8AAAA ))
  \a2b/out_data_1_rstpot  (
    .I0(\a2b/out_data_1_66 ),
    .I1(\a2b/counter [3]),
    .I2(\a2b/counter [2]),
    .I3(\a2b/counter [1]),
    .I4(\a2b/_n0227_inv1 ),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_1_rstpot_276 )
  );
  LUT6 #(
    .INIT ( 64'hAAAEAAAAAAA2AAAA ))
  \a2b/out_data_2_rstpot  (
    .I0(\a2b/out_data_2_65 ),
    .I1(\a2b/_n0230_inv1 ),
    .I2(\a2b/counter [2]),
    .I3(\a2b/counter [3]),
    .I4(\a2b/counter [1]),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_2_rstpot_277 )
  );
  LUT6 #(
    .INIT ( 64'hAAABAAAAAAA8AAAA ))
  \a2b/out_data_0_rstpot  (
    .I0(\a2b/out_data_0_67 ),
    .I1(\a2b/counter [3]),
    .I2(\a2b/counter [2]),
    .I3(\a2b/counter [1]),
    .I4(\a2b/_n0230_inv1 ),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_0_rstpot_278 )
  );
  LUT6 #(
    .INIT ( 64'hAAAEAAAAAAA2AAAA ))
  \a2b/out_data_3_rstpot  (
    .I0(\a2b/out_data_3_64 ),
    .I1(\a2b/_n0227_inv1 ),
    .I2(\a2b/counter [2]),
    .I3(\a2b/counter [3]),
    .I4(\a2b/counter [1]),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_3_rstpot_279 )
  );
  LUT6 #(
    .INIT ( 64'hAAAEAAAAAAA2AAAA ))
  \a2b/out_data_4_rstpot  (
    .I0(\a2b/out_data_4_63 ),
    .I1(\a2b/counter [2]),
    .I2(\a2b/counter [1]),
    .I3(\a2b/counter [3]),
    .I4(\a2b/_n0230_inv1 ),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_4_rstpot_280 )
  );
  LUT6 #(
    .INIT ( 64'hAAEAAAAAAA2AAAAA ))
  \a2b/out_data_6_rstpot  (
    .I0(\a2b/out_data_6_61 ),
    .I1(\a2b/_n0230_inv1 ),
    .I2(\a2b/counter [1]),
    .I3(\a2b/counter [3]),
    .I4(\a2b/counter [2]),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_6_rstpot_281 )
  );
  LUT6 #(
    .INIT ( 64'hAAEAAAAAAA2AAAAA ))
  \a2b/out_data_7_rstpot  (
    .I0(\a2b/out_data_7_60 ),
    .I1(\a2b/_n0227_inv1 ),
    .I2(\a2b/counter [1]),
    .I3(\a2b/counter [3]),
    .I4(\a2b/counter [2]),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_7_rstpot_282 )
  );
  LUT6 #(
    .INIT ( 64'hAAAEAAAAAAA2AAAA ))
  \a2b/out_data_5_rstpot  (
    .I0(\a2b/out_data_5_62 ),
    .I1(\a2b/counter [2]),
    .I2(\a2b/counter [1]),
    .I3(\a2b/counter [3]),
    .I4(\a2b/_n0227_inv1 ),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_5_rstpot_283 )
  );
  LUT6 #(
    .INIT ( 64'hAAAEAAAAAAA2AAAA ))
  \a2b/out_data_8_rstpot  (
    .I0(\a2b/out_data_8_59 ),
    .I1(\a2b/_n0230_inv1 ),
    .I2(\a2b/counter [1]),
    .I3(\a2b/counter [2]),
    .I4(\a2b/counter [3]),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_8_rstpot_284 )
  );
  LUT6 #(
    .INIT ( 64'hAAAEAAAAAAA2AAAA ))
  \a2b/out_data_9_rstpot  (
    .I0(\a2b/out_data_9_58 ),
    .I1(\a2b/_n0227_inv1 ),
    .I2(\a2b/counter [1]),
    .I3(\a2b/counter [2]),
    .I4(\a2b/counter [3]),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_9_rstpot_285 )
  );
  LUT6 #(
    .INIT ( 64'hAAEAAAAAAA2AAAAA ))
  \a2b/out_data_11_rstpot  (
    .I0(\a2b/out_data_11_56 ),
    .I1(\a2b/counter [3]),
    .I2(\a2b/counter [1]),
    .I3(\a2b/counter [2]),
    .I4(\a2b/_n0227_inv1 ),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_11_rstpot_286 )
  );
  LUT6 #(
    .INIT ( 64'hAAEAAAAAAA2AAAAA ))
  \a2b/out_data_12_rstpot  (
    .I0(\a2b/out_data_12_55 ),
    .I1(\a2b/counter [3]),
    .I2(\a2b/_n0230_inv1 ),
    .I3(\a2b/counter [1]),
    .I4(\a2b/counter [2]),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_12_rstpot_287 )
  );
  LUT6 #(
    .INIT ( 64'hAAEAAAAAAA2AAAAA ))
  \a2b/out_data_10_rstpot  (
    .I0(\a2b/out_data_10_57 ),
    .I1(\a2b/counter [3]),
    .I2(\a2b/counter [1]),
    .I3(\a2b/counter [2]),
    .I4(\a2b/_n0230_inv1 ),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_10_rstpot_288 )
  );
  LUT6 #(
    .INIT ( 64'hAAEAAAAAAA2AAAAA ))
  \a2b/out_data_13_rstpot  (
    .I0(\a2b/out_data_13_54 ),
    .I1(\a2b/counter [3]),
    .I2(\a2b/_n0227_inv1 ),
    .I3(\a2b/counter [1]),
    .I4(\a2b/counter [2]),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_13_rstpot_289 )
  );
  LUT6 #(
    .INIT ( 64'hEAAAAAAA2AAAAAAA ))
  \a2b/out_data_14_rstpot  (
    .I0(\a2b/out_data_14_53 ),
    .I1(\a2b/_n0230_inv1 ),
    .I2(\a2b/counter [1]),
    .I3(\a2b/counter [2]),
    .I4(\a2b/counter [3]),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_14_rstpot_290 )
  );
  LUT6 #(
    .INIT ( 64'hAAABAAAAAAA8AAAA ))
  \a2b/out_data_16_rstpot  (
    .I0(\a2b/out_data_16_51 ),
    .I1(\a2b/counter [3]),
    .I2(\a2b/counter [2]),
    .I3(\a2b/counter [1]),
    .I4(\a2b/_n0182_inv1 ),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_16_rstpot_291 )
  );
  LUT6 #(
    .INIT ( 64'hAAABAAAAAAA8AAAA ))
  \a2b/out_data_17_rstpot  (
    .I0(\a2b/out_data_17_50 ),
    .I1(\a2b/counter [3]),
    .I2(\a2b/counter [2]),
    .I3(\a2b/counter [1]),
    .I4(\a2b/_n0179_inv2 ),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_17_rstpot_292 )
  );
  LUT6 #(
    .INIT ( 64'hEAAAAAAA2AAAAAAA ))
  \a2b/out_data_15_rstpot  (
    .I0(\a2b/out_data_15_52 ),
    .I1(\a2b/_n0227_inv1 ),
    .I2(\a2b/counter [1]),
    .I3(\a2b/counter [2]),
    .I4(\a2b/counter [3]),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_15_rstpot_293 )
  );
  LUT6 #(
    .INIT ( 64'hAAAEAAAAAAA2AAAA ))
  \a2b/out_data_18_rstpot  (
    .I0(\a2b/out_data_18_49 ),
    .I1(\a2b/_n0182_inv1 ),
    .I2(\a2b/counter [2]),
    .I3(\a2b/counter [3]),
    .I4(\a2b/counter [1]),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_18_rstpot_294 )
  );
  LUT6 #(
    .INIT ( 64'hAAAEAAAAAAA2AAAA ))
  \a2b/out_data_19_rstpot  (
    .I0(\a2b/out_data_19_48 ),
    .I1(\a2b/_n0179_inv2 ),
    .I2(\a2b/counter [2]),
    .I3(\a2b/counter [3]),
    .I4(\a2b/counter [1]),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_19_rstpot_295 )
  );
  LUT6 #(
    .INIT ( 64'hAAAEAAAAAAA2AAAA ))
  \a2b/out_data_21_rstpot  (
    .I0(\a2b/out_data_21_46 ),
    .I1(\a2b/counter [2]),
    .I2(\a2b/counter [1]),
    .I3(\a2b/counter [3]),
    .I4(\a2b/_n0179_inv2 ),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_21_rstpot_296 )
  );
  LUT6 #(
    .INIT ( 64'hAAEAAAAAAA2AAAAA ))
  \a2b/out_data_22_rstpot  (
    .I0(\a2b/out_data_22_45 ),
    .I1(\a2b/_n0182_inv1 ),
    .I2(\a2b/counter [1]),
    .I3(\a2b/counter [3]),
    .I4(\a2b/counter [2]),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_22_rstpot_297 )
  );
  LUT6 #(
    .INIT ( 64'hAAAEAAAAAAA2AAAA ))
  \a2b/out_data_20_rstpot  (
    .I0(\a2b/out_data_20_47 ),
    .I1(\a2b/counter [2]),
    .I2(\a2b/counter [1]),
    .I3(\a2b/counter [3]),
    .I4(\a2b/_n0182_inv1 ),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_20_rstpot_298 )
  );
  LUT6 #(
    .INIT ( 64'hAAEAAAAAAA2AAAAA ))
  \a2b/out_data_23_rstpot  (
    .I0(\a2b/out_data_23_44 ),
    .I1(\a2b/_n0179_inv2 ),
    .I2(\a2b/counter [1]),
    .I3(\a2b/counter [3]),
    .I4(\a2b/counter [2]),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_23_rstpot_299 )
  );
  LUT6 #(
    .INIT ( 64'hAAAEAAAAAAA2AAAA ))
  \a2b/out_data_24_rstpot  (
    .I0(\a2b/out_data_24_43 ),
    .I1(\a2b/_n0182_inv1 ),
    .I2(\a2b/counter [1]),
    .I3(\a2b/counter [2]),
    .I4(\a2b/counter [3]),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_24_rstpot_300 )
  );
  LUT6 #(
    .INIT ( 64'hAAEAAAAAAA2AAAAA ))
  \a2b/out_data_26_rstpot  (
    .I0(\a2b/out_data_26_41 ),
    .I1(\a2b/counter [3]),
    .I2(\a2b/counter [1]),
    .I3(\a2b/counter [2]),
    .I4(\a2b/_n0182_inv1 ),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_26_rstpot_301 )
  );
  LUT6 #(
    .INIT ( 64'hAAEAAAAAAA2AAAAA ))
  \a2b/out_data_27_rstpot  (
    .I0(\a2b/out_data_27_40 ),
    .I1(\a2b/counter [3]),
    .I2(\a2b/counter [1]),
    .I3(\a2b/counter [2]),
    .I4(\a2b/_n0179_inv2 ),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_27_rstpot_302 )
  );
  LUT6 #(
    .INIT ( 64'hAAAEAAAAAAA2AAAA ))
  \a2b/out_data_25_rstpot  (
    .I0(\a2b/out_data_25_42 ),
    .I1(\a2b/_n0179_inv2 ),
    .I2(\a2b/counter [1]),
    .I3(\a2b/counter [2]),
    .I4(\a2b/counter [3]),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_25_rstpot_303 )
  );
  LUT6 #(
    .INIT ( 64'hAAEAAAAAAA2AAAAA ))
  \a2b/out_data_28_rstpot  (
    .I0(\a2b/out_data_28_39 ),
    .I1(\a2b/counter [3]),
    .I2(\a2b/_n0182_inv1 ),
    .I3(\a2b/counter [1]),
    .I4(\a2b/counter [2]),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_28_rstpot_304 )
  );
  LUT6 #(
    .INIT ( 64'hAAEAAAAAAA2AAAAA ))
  \a2b/out_data_29_rstpot  (
    .I0(\a2b/out_data_29_38 ),
    .I1(\a2b/counter [3]),
    .I2(\a2b/_n0179_inv2 ),
    .I3(\a2b/counter [1]),
    .I4(\a2b/counter [2]),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_29_rstpot_305 )
  );
  LUT6 #(
    .INIT ( 64'hEAAAAAAA2AAAAAAA ))
  \a2b/out_data_30_rstpot  (
    .I0(\a2b/out_data_30_37 ),
    .I1(\a2b/_n0182_inv1 ),
    .I2(\a2b/counter [1]),
    .I3(\a2b/counter [2]),
    .I4(\a2b/counter [3]),
    .I5(\a2b/in_state ),
    .O(\a2b/out_data_30_rstpot_306 )
  );
  LUT6 #(
    .INIT ( 64'hBFBFBFA0A0BFA0A0 ))
  \a2b/Mmux_in_state18  (
    .I0(N2),
    .I1(S_AXIS_TVALID_IBUF_34),
    .I2(\a2b/state_68 ),
    .I3(\a2b/counter [4]),
    .I4(\a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_4_116 ),
    .I5(\a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_3_111 ),
    .O(\a2b/in_state )
  );
  LUT5 #(
    .INIT ( 32'h2AAAAAAA ))
  \b2a/Mcount_counter_lut<0>  (
    .I0(\b2a/counter [0]),
    .I1(\b2a/counter [4]),
    .I2(\b2a/counter [3]),
    .I3(\b2a/counter [2]),
    .I4(\b2a/counter [1]),
    .O(\b2a/Mcount_counter_lut [0])
  );
  LUT5 #(
    .INIT ( 32'h2AAAAAAA ))
  \a2b/Mcount_counter_lut<0>  (
    .I0(\a2b/counter [0]),
    .I1(\a2b/counter [4]),
    .I2(\a2b/counter [3]),
    .I3(\a2b/counter [2]),
    .I4(\a2b/counter [1]),
    .O(\a2b/Mcount_counter_lut [0])
  );
  LUT5 #(
    .INIT ( 32'h2AAAAAAA ))
  \b2a/Mcount_counter_lut<1>  (
    .I0(\b2a/counter [1]),
    .I1(\b2a/counter [4]),
    .I2(\b2a/counter [3]),
    .I3(\b2a/counter [2]),
    .I4(\b2a/counter [0]),
    .O(\b2a/Mcount_counter_lut [1])
  );
  LUT5 #(
    .INIT ( 32'h2AAAAAAA ))
  \a2b/Mcount_counter_lut<1>  (
    .I0(\a2b/counter [1]),
    .I1(\a2b/counter [4]),
    .I2(\a2b/counter [3]),
    .I3(\a2b/counter [2]),
    .I4(\a2b/counter [0]),
    .O(\a2b/Mcount_counter_lut [1])
  );
  LUT5 #(
    .INIT ( 32'h2AAAAAAA ))
  \b2a/Mcount_counter_lut<2>  (
    .I0(\b2a/counter [2]),
    .I1(\b2a/counter [4]),
    .I2(\b2a/counter [3]),
    .I3(\b2a/counter [1]),
    .I4(\b2a/counter [0]),
    .O(\b2a/Mcount_counter_lut [2])
  );
  LUT5 #(
    .INIT ( 32'h2AAAAAAA ))
  \a2b/Mcount_counter_lut<2>  (
    .I0(\a2b/counter [2]),
    .I1(\a2b/counter [4]),
    .I2(\a2b/counter [3]),
    .I3(\a2b/counter [1]),
    .I4(\a2b/counter [0]),
    .O(\a2b/Mcount_counter_lut [2])
  );
  LUT5 #(
    .INIT ( 32'h2AAAAAAA ))
  \b2a/Mcount_counter_lut<3>  (
    .I0(\b2a/counter [3]),
    .I1(\b2a/counter [4]),
    .I2(\b2a/counter [2]),
    .I3(\b2a/counter [1]),
    .I4(\b2a/counter [0]),
    .O(\b2a/Mcount_counter_lut [3])
  );
  LUT5 #(
    .INIT ( 32'h2AAAAAAA ))
  \a2b/Mcount_counter_lut<3>  (
    .I0(\a2b/counter [3]),
    .I1(\a2b/counter [4]),
    .I2(\a2b/counter [2]),
    .I3(\a2b/counter [1]),
    .I4(\a2b/counter [0]),
    .O(\a2b/Mcount_counter_lut [3])
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \a2b/Mmux_counter[4]_out_data[31]_Mux_3_o_2_f7_SW0  (
    .I0(\a2b/Mmux_in_state14_170 ),
    .I1(\a2b/Mmux_in_state15_171 ),
    .I2(\a2b/Mmux_in_state13_169 ),
    .I3(S_AXIS_TDATA_0_IBUF_31),
    .O(N2)
  );
  LUT5 #(
    .INIT ( 32'h7FFFFFFF ))
  \b2a/GND_3_o_GND_3_o_equal_8_o_inv1  (
    .I0(\b2a/counter [4]),
    .I1(\b2a/counter [3]),
    .I2(\b2a/counter [2]),
    .I3(\b2a/counter [1]),
    .I4(\b2a/counter [0]),
    .O(\b2a/GND_3_o_GND_3_o_equal_8_o_inv )
  );
  LUT5 #(
    .INIT ( 32'h2AAAAAAA ))
  \b2a/Mcount_counter_lut<4>  (
    .I0(\b2a/counter [4]),
    .I1(\b2a/counter [3]),
    .I2(\b2a/counter [2]),
    .I3(\b2a/counter [1]),
    .I4(\b2a/counter [0]),
    .O(\b2a/Mcount_counter_lut [4])
  );
  LUT5 #(
    .INIT ( 32'h2AAAAAAA ))
  \a2b/Mcount_counter_lut<4>  (
    .I0(\a2b/counter [4]),
    .I1(\a2b/counter [3]),
    .I2(\a2b/counter [2]),
    .I3(\a2b/counter [1]),
    .I4(\a2b/counter [0]),
    .O(\a2b/Mcount_counter_lut [4])
  );
  LUT6 #(
    .INIT ( 64'h8000000000000000 ))
  \b2a/Mmux_M_AXIS_TLAST11  (
    .I0(\b2a/state_101 ),
    .I1(\b2a/counter [4]),
    .I2(\b2a/counter [3]),
    .I3(\b2a/counter [2]),
    .I4(\b2a/counter [1]),
    .I5(\b2a/counter [0]),
    .O(M_AXIS_TLAST_OBUF_102)
  );
  BUFGP   ACLK_BUFGP (
    .I(ACLK),
    .O(ACLK_BUFGP_32)
  );
  INV   \a2b/rstn_inv1_INV_0  (
    .I(ARESETN_IBUF_33),
    .O(\a2b/rstn_inv )
  );
endmodule


`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

