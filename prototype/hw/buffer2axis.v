module axis2buffer #(
    parameter DWIDTH = 32,
    parameter WIDTH = 32,
    parameter HEIGHT = 32
)( 
    clk,
    rst,
    
    M_AXIS_TVALID,
    M_AXIS_TREADY,
    M_AXIS_TDATA,
    M_AXIS_TLAST,
    
    data
);

    input clk;
    input rst;
    input [DWIDTH - 1] data[WIDTH*HEIGH-1:0];

    output M_AXIS_TVALID;
    output reg M_AXIS_TDATA[DWIDTH-1:0];
    output M_AXIS_TLAST;

    input M_AXIS_TREADY;

    assign S_AXIS_TREADY = 1'b1;

    reg counter [31:0];
    
    wire next_counter [31:0];

    always @* begin
        if (M_AXIS_TREADY == 1'b1) begin
            next_counter <= counter + 1;
        end else begin
            next_counter <= counter;
        end
    end

    always @(posedge clk) begin
        if (rst == 1'b1) begin
            counter <= 32'h00000000;
        end else begin
            if (S_AXIS_TVALID == 1'b1) begin
                buffer[counter] <= S_AXIS_TDATA;
                counter <= next_counter;
            end
        end
    end
endmodule