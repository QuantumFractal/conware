module shredder_array #(
    parameter WIDTH = 32
)(
    clk, 
    rstn, 
    in_data, 
    out_data
);

    input clk;
    input rstn;

    input[WIDTH-1:0] in_data;
    output[WIDTH-1:0] out_data;

    wire[2:0] sums[WIDTH + 2:0];

    assign sums[0] = 3'b000;
    assign sums[WIDTH+1] = 3'b000;

    genvar i;
    generate 
        for (i = 1; i <= WIDTH; i=i+1) begin : shredder_block
            shredder shredder_i(
                .clk(clk),
                .rstn(rstn),
                .din(in_data[i-1]),
                .nsum0(sums[i-1]),
                .nsum1(sums[i+1]),
                .sum_out(sums[i]),
                .next_state(out_data[i-1])
            );
        end
    endgenerate

endmodule