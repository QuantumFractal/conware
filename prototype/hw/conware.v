module conware #(
    parameter DWIDTH = 32,
    parameter WIDTH = 32,
    parameter HEIGHT = 32
)(
    clk, 
    rst, 
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
    input rst;
    
    input alive_color[DWIDTH-1:0];
    input dead_color[DWIDTH-1:0];
    
    wire [DWIDTH-1:0] in_data [WIDTH*HEIGHT-1:0]; 
    wire in_states [WIDTH*HEIGHT-1:0];
    wire out_states [WIDTH*HEIGHT-1:0];
    wire [DWIDTH-1:0] out_data [WIDTH*HEIGHT-1:0]; 

    axis2buffer #(DWITDH, WIDTH, HEIGHT) a2b(
        .clk(clk),
        .rst(rst),
        .S_AXIS_TVALID(S_AXIS_TVALID),
        .S_AXIS_TREADY(S_AXIS_TREADY),
        .S_AXIS_TDATA(S_AXIS_TDATA),
        .S_AXIS_TLAST(S_AXIS_TLAST)
        .data(in_data)
    );

    color2state #(DWIDTH, WIDTH, HEIGHT) c2s(
        .in_data(in_data),
        .out_data(in_states),
        .alive_color(alive_color),
        .dead_color(dead_color)
    );

    conway_block #(WIDTH, HEIGHT) conway(
        .in_states(in_states),
        .out_states(out_states)
    );

    state2color #(DWIDTH, WIDTH, HEIGHT) s2c(
        .in_data(out_states),
        .out_data(out_data),
        .alive_color(alive_color),
        .dead_color(dead_color)
    );

    buffer2axis #(DWIDTH, WIDTH, HEIGHT) b2a(
        .clk(clk),
        .rst(rst),
        .M_AXIS_TVALID(M_AXIS_TVALID),
        .M_AXIS_TREADY(M_AXIS_TREADY),
        .M_AXIS_TDATA(M_AXIS_TDATA),
        .M_AXIS_TLAST(M_AXIS_TLAST),
        .data(out_data)
    )

endmodule