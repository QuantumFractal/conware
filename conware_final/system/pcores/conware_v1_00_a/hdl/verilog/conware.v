module conware #(
    parameter DWIDTH = 32,
    parameter WIDTH = 8,
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

    output wire [WIDTH-1:0] in_states;
    output wire [WIDTH-1:0] out_states;
    output wire [31:0] num_reads;
    output wire [31:0] num_writes;
    output wire [7:0] read_ctr;
    output wire [7:0] write_ctr;

    // Signals to handle internal handshake between in-buffer and out-buffer
    wire pvalid;
    wire pready;
    wire shredder_en;

    // We want to pull the data into the shredders when both the in buffer and
    // out buffer are ready to move data one step through the pipeline
    assign shredder_en = pvalid & pready;

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
        .out_ready(pready),

        .num_reads(num_reads),
        .counter(read_ctr)
    );

    shredder_array #(WIDTH) shredders(
        .clk(ACLK),
        .rstn(ARESETN),
        .enable(shredder_en),
        .in_data(in_states),
        .out_data(out_states)
    );

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

        .in_data(out_states),
        .in_valid(pvalid),
        .in_ready(pready),

        .num_writes(num_writes),
        .counter(write_ctr)
    );

endmodule