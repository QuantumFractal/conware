module conware #(
    parameter DWIDTH = 32,
    parameter WIDTH = 4,
    parameter HEIGHT = 1
)(
    clk, 
    rstn, 

    // Color conversion signals
    alive_color,
    dead_color,
    
    // Input AXI stream ports
    S_AXIS_TVALID,
    S_AXIS_TREADY,
    S_AXIS_TDATA,
    S_AXIS_TLAST,
    
    // Output AXI stream ports
    M_AXIS_TVALID,
    M_AXIS_TREADY,
    M_AXIS_TDATA,
    M_AXIS_TLAST
    
);
    input clk;
    input rstn;
    
    input [DWIDTH-1:0] alive_color;
    input [DWIDTH-1:0] dead_color;

    input [DWIDTH-1:0] S_AXIS_TDATA;
    input S_AXIS_TVALID;
    input S_AXIS_TLAST;
    output S_AXIS_TREADY;

    output [DWIDTH-1:0] M_AXIS_TDATA;
    output M_AXIS_TVALID;
    output M_AXIS_TLAST;
    input M_AXIS_TREADY;

    wire [WIDTH*HEIGHT-1:0] in_states;
    wire [WIDTH*HEIGHT-1:0] out_states;

    // Signals to handle internal handshake between in-buffer and out-buffer
    wire pvalid;
    wire pready;


    axis2buffer #(DWIDTH, WIDTH, HEIGHT) a2b(
        .clk(clk),
        .rstn(rstn),

        .alive_color(alive_color),
        .dead_color(dead_color),

        .S_AXIS_TVALID(S_AXIS_TVALID),
        .S_AXIS_TREADY(S_AXIS_TREADY),
        .S_AXIS_TDATA(S_AXIS_TDATA),
        .S_AXIS_TLAST(S_AXIS_TLAST),

        .out_data(in_states),
        .out_valid(pvalid),
        .out_ready(pready)
    );

    shredder_array #(WIDTH) shredders(
        .in_data(in_states),
        .out_data(out_states)
    );

    buffer2axis #(DWIDTH, WIDTH, HEIGHT) b2a(
        .clk(clk),
        .rstn(rstn),

        .alive_color(alive_color),
        .dead_color(dead_color),

        .M_AXIS_TVALID(M_AXIS_TVALID),
        .M_AXIS_TREADY(M_AXIS_TREADY),
        .M_AXIS_TDATA(M_AXIS_TDATA),
        .M_AXIS_TLAST(M_AXIS_TLAST),

        .in_data(out_states),
        .in_valid(pvalid),
        .in_ready(pready)
    );

endmodule