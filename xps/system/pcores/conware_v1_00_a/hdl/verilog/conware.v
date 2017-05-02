module conware #(
    parameter DWIDTH = 32,
    parameter WIDTH = 32,
    parameter HEIGHT = 1
)(
    // Color conversion signals
    // alive_color,
    // dead_color,
    
    // Clock and Reset
    ACLK,
    ARESETN,

    // Input AXI stream ports
    S_AXIS_TVALID,
    S_AXIS_TREADY,
    S_AXIS_TDATA,
    S_AXIS_TLAST,
    
    // Output AXI stream ports
    M_AXIS_TVALID,
    M_AXIS_TREADY,
    M_AXIS_TDATA,
    M_AXIS_TLAST,
    M_AXIS_TKEEP,
    M_AXIS_TSTRB
    
);
    input ACLK;
    input ARESETN;
    
    // input [DWIDTH-1:0] alive_color;
    // input [DWIDTH-1:0] dead_color;

    input [DWIDTH-1:0] S_AXIS_TDATA;
    input S_AXIS_TVALID;
    input S_AXIS_TLAST;
    output S_AXIS_TREADY;

    output [DWIDTH-1:0] M_AXIS_TDATA;
    output M_AXIS_TVALID;
    output M_AXIS_TLAST;
    input M_AXIS_TREADY;
    output [3:0] M_AXIS_TKEEP; // TODO: This needs to change with DWIDTH
    output [3:0] M_AXIS_TSTRB;

    wire [WIDTH-1:0] in_states;
    wire [WIDTH-1:0] out_states;

    // Signals to handle internal handshake between in-buffer and out-buffer
    wire pvalid;
    wire pready;


    axis2buffer #(DWIDTH, WIDTH) a2b(
        .clk(ACLK),
        .rstn(ARESETN),

        .alive_color('hFFFFFFFF),
        .dead_color('h00000000),

        .S_AXIS_TVALID(S_AXIS_TVALID),
        .S_AXIS_TREADY(S_AXIS_TREADY),
        .S_AXIS_TDATA(S_AXIS_TDATA),
        .S_AXIS_TLAST(S_AXIS_TLAST),

        .out_data(in_states),
        .out_valid(pvalid),
        .out_ready(pready)
    );

    // shredder_array #(WIDTH) shredders(
    //     .clk(ACLK),
    //     .rstn(ARESETN),
    //     .in_data(in_states),
    //     .out_data(out_states)
    // );

    buffer2axis #(DWIDTH, WIDTH) b2a(
        .clk(ACLK),
        .rstn(ARESETN),

        .alive_color('hFFFFFFFF),
        .dead_color('h00000000),

        .M_AXIS_TVALID(M_AXIS_TVALID),
        .M_AXIS_TREADY(M_AXIS_TREADY),
        .M_AXIS_TDATA(M_AXIS_TDATA),
        .M_AXIS_TLAST(M_AXIS_TLAST),
        .M_AXIS_TKEEP(M_AXIS_TKEEP),
        .M_AXIS_TSTRB(M_AXIS_TSTRB),

        .in_data(in_states),
        .in_valid(pvalid),
        .in_ready(pready)
    );

endmodule