module axis2buffer #(
    parameter DWIDTH = 32,
    parameter WIDTH = 8
)( 
    // Control signals
    clk,
    rstn,

    // Color conversion signals
    alive_color,
    dead_color,
    
    // AXIS Connection
    S_AXIS_TDATA,
    S_AXIS_TVALID,
    S_AXIS_TREADY,
    S_AXIS_TLAST,
    
    // Output to conware computation
    out_data,
    out_valid,
    out_ready
);

    // Port descriptions
    input clk;
    input rstn;

    input [DWIDTH-1:0] alive_color;
    input [DWIDTH-1:0] dead_color;

    input [DWIDTH-1:0] S_AXIS_TDATA;
    input S_AXIS_TVALID;
    input S_AXIS_TLAST;
    output reg S_AXIS_TREADY;

    output reg [WIDTH-1:0] out_data;
    output reg out_valid;
    input out_ready;

    // State params
    reg state;
    reg next_state;
    localparam Wait = 0;
    localparam Read = 1;

    // Internal values
    reg in_state;
    reg [7:0] counter;
    reg [7:0] next_counter;

    initial begin
        state <= Read;
        out_data <= 0;
        counter <= 0;
    end

    // Combinational Logic
    always @* begin

        if ((state == Read) && (S_AXIS_TVALID == 1)) begin
            in_state <= (S_AXIS_TDATA == alive_color)? 1'b1 : 1'b0;
        end else begin
            in_state <= out_data[counter];
        end
    
        case (state)

        Wait: begin
            next_counter <= 0;
            S_AXIS_TREADY <= 0;
            out_valid <= 1;

            if (out_ready) begin
                next_state <= Read;
            end else begin
                next_state <= Wait;
            end
        end

        Read: begin
            S_AXIS_TREADY <= 1;
            next_state <= Read;
            out_valid <= 0;

            if (S_AXIS_TVALID == 1) begin
                if (counter == WIDTH-1) begin
                    next_counter <= 0;
                    next_state <= Wait;
                end else begin
                    next_counter <= counter + 1;
                end

            end else begin
                // Data source stalled
                next_counter <= counter;
            end
        end

        endcase
    end

    // Clocked Logic
    always @(posedge clk) begin
        if (!rstn) begin
            counter <= 8'h00;
            state <= Read;
        end else begin
            out_data[counter] <= in_state;
            state <= next_state;
            counter <= next_counter;
        end
    end

endmodule