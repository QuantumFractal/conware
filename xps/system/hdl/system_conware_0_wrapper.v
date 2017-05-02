//-----------------------------------------------------------------------------
// system_conware_0_wrapper.v
//-----------------------------------------------------------------------------

module system_conware_0_wrapper
  (
    ACLK,
    ARESETN,
    CONWARE_BUFFER,
    S_AXIS_TREADY,
    S_AXIS_TDATA,
    S_AXIS_TLAST,
    S_AXIS_TVALID,
    M_AXIS_TVALID,
    M_AXIS_TDATA,
    M_AXIS_TLAST,
    M_AXIS_TREADY,
    M_AXIS_TKEEP,
    M_AXIS_TSTRB
  );
  input ACLK;
  input ARESETN;
  output [7:0] CONWARE_BUFFER;
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

  conware
    conware_0 (
      .ACLK ( ACLK ),
      .ARESETN ( ARESETN ),
      .CONWARE_BUFFER ( CONWARE_BUFFER ),
      .S_AXIS_TREADY ( S_AXIS_TREADY ),
      .S_AXIS_TDATA ( S_AXIS_TDATA ),
      .S_AXIS_TLAST ( S_AXIS_TLAST ),
      .S_AXIS_TVALID ( S_AXIS_TVALID ),
      .M_AXIS_TVALID ( M_AXIS_TVALID ),
      .M_AXIS_TDATA ( M_AXIS_TDATA ),
      .M_AXIS_TLAST ( M_AXIS_TLAST ),
      .M_AXIS_TREADY ( M_AXIS_TREADY ),
      .M_AXIS_TKEEP ( M_AXIS_TKEEP ),
      .M_AXIS_TSTRB ( M_AXIS_TSTRB )
    );

endmodule

