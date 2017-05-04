//-----------------------------------------------------------------------------
// system_conware_0_wrapper.v
//-----------------------------------------------------------------------------

module system_conware_0_wrapper
  (
    ACLK,
    ARESETN,
    S_AXIS_TREADY,
    S_AXIS_TDATA,
    S_AXIS_TLAST,
    S_AXIS_TVALID,
    M_AXIS_TVALID,
    M_AXIS_TDATA,
    M_AXIS_TLAST,
    M_AXIS_TREADY,
    M_AXIS_TKEEP,
    M_AXIS_TSTRB,
    in_states,
    out_states,
    num_reads,
    num_writes,
    read_ctr,
    write_ctr
  );
  input ACLK;
  input ARESETN;
  output S_AXIS_TREADY;
  input [31:0] S_AXIS_TDATA;
  input S_AXIS_TLAST;
  input S_AXIS_TVALID;
  output M_AXIS_TVALID;
  output [31:0] M_AXIS_TDATA;
  output M_AXIS_TLAST;
  input M_AXIS_TREADY;
  output [3:0] M_AXIS_TKEEP;
  output [3:0] M_AXIS_TSTRB;
  output [7:0] in_states;
  output [7:0] out_states;
  output [31:0] num_reads;
  output [31:0] num_writes;
  output [7:0] read_ctr;
  output [7:0] write_ctr;

  conware
    conware_0 (
      .ACLK ( ACLK ),
      .ARESETN ( ARESETN ),
      .S_AXIS_TREADY ( S_AXIS_TREADY ),
      .S_AXIS_TDATA ( S_AXIS_TDATA ),
      .S_AXIS_TLAST ( S_AXIS_TLAST ),
      .S_AXIS_TVALID ( S_AXIS_TVALID ),
      .M_AXIS_TVALID ( M_AXIS_TVALID ),
      .M_AXIS_TDATA ( M_AXIS_TDATA ),
      .M_AXIS_TLAST ( M_AXIS_TLAST ),
      .M_AXIS_TREADY ( M_AXIS_TREADY ),
      .M_AXIS_TKEEP ( M_AXIS_TKEEP ),
      .M_AXIS_TSTRB ( M_AXIS_TSTRB ),
      .in_states ( in_states ),
      .out_states ( out_states ),
      .num_reads ( num_reads ),
      .num_writes ( num_writes ),
      .read_ctr ( read_ctr ),
      .write_ctr ( write_ctr )
    );

endmodule

