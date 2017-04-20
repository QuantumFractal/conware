module shredder(
    input clk, 
    input rst, 
    input din, 
    input[2:0] nsum0, 
    input[2:0] nsum1, 
    output[2:0] sum_out, 
    output next_state
);

    reg[2:0] shift_reg;
    wire[2:0] nsum;

    always @(posedge clk) begin
        if (rst == 1) begin
            shift_reg <= 3'b000;
        end else begin
            shift_reg <= (shift_reg << 1) | din;
        end
    end

    assign nsum = nsum0 + nsum1 + shift_reg[2] + shift_reg[0];
    assign sum_out = shift_reg[0] + shift_reg[1] + shift_reg[2];

    conway compute_unit(shift_reg[1], nsum, next_state);
endmodule