module color2state #(
    paramater DWIDTH = 32,
    parameter WIDTH = 32,
    parameter HEIGHT = 32
)( 
    in_data, 
    out_data,
    alive_color,
    dead_color
);

    input [DWIDTH-1:0] in_data[WIDTH*HEIGHT-1:0];
    output out_data[WIDTH*HEIGHT-1:0];

    genvar i, j;
    generate 
        for (i = 0; i < WIDTH*HEIGHT; i=i+1) begin : converter_block
            assign out_data[i] = in_data[i] is alive_color? 1b'1 : 1b'0;
        end
    endgenerate


endmodule