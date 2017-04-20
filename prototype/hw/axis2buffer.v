module axis2buffer #(
    parameter DWIDTH = 32,
    parameter WIDTH = 32,
    parameter HEIGHT = 32
)( 
    // Control signals
    clk,
    rstn,
    
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

    input [DWIDTH-1:0] S_AXIS_TDATA;
    input S_AXIS_TVALID;
    input S_AXIS_TLAST;
    output S_AXIS_TREADY;

    output reg [DWIDTH - 1:0] out_data [WIDTH*HEIGHT-1:0];
    output out_valid;
    input out_ready;

    // State params
    reg state;
    localparam Wait = 0;
    localparam Read = 1;

    // Internal values
    reg [31:0] counter;

    assign S_AXIS_TREADY = (state == Read);

    always @(posedge clk) begin
        if (!rstn) begin
            counter <= 32'h00000000;
            state <= Wait;
        end else begin
            case (state)
            Wait: begin
                if (out_ready) begin
                    state <= Read;
                end else begin
                    state <= Wait;

                end
            end
            Read: begin
                
                if (S_AXIS_TVALID == 1) begin
                    out_data[counter] <= S_AXIS_TDATA;
                    if (counter == WIDTH*HEIGHT-1) begin
                        counter <= 0;
                        state <= Wait;
                    end else begin
                        counter <= counter + 1;
                    end

                end else begin
                    counter <= counter;
                end

            end
            endcase
        end
    end
endmodule