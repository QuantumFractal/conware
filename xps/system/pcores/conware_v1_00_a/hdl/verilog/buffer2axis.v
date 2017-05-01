module buffer2axis #(
    parameter DWIDTH = 32,
    parameter WIDTH = 4
)( 
    // Control signals
    clk,
    rstn,

    // Color conversion signals
    alive_color,
    dead_color,
    
    // AXIS Connection
    M_AXIS_TDATA,
    M_AXIS_TVALID,
    M_AXIS_TREADY,
    M_AXIS_TLAST,
    
    // Output to conware computation
    in_data,
    in_valid,
    in_ready,

    buffer
);

    // Port descriptions
    input clk;
    input rstn;

    input [DWIDTH-1:0] alive_color;
    input [DWIDTH-1:0] dead_color;

    output reg [DWIDTH-1:0] M_AXIS_TDATA;
    output reg M_AXIS_TVALID;
    output reg M_AXIS_TLAST;
    input M_AXIS_TREADY;

    input [WIDTH-1:0] in_data;
    input in_valid;
    output reg in_ready;

    // State params
    reg state;
    reg next_state;
    localparam Wait = 0;
    localparam Write = 1;

    // Internal values
    output reg [WIDTH - 1:0] buffer;
    reg [WIDTH - 1:0] next_buffer;
    reg [7:0] counter;
    reg [7:0] next_counter;

    initial begin
        buffer <= 0;
        counter <= 0;
    end
    
    // Combinational Logic
    always @* begin
        next_counter <= 0;

        if (buffer[counter]) begin
            M_AXIS_TDATA <= alive_color;
        end else begin
            M_AXIS_TDATA <= dead_color;
        end
          
        if (state == Wait && next_state == Write) begin
            next_buffer <= in_data;
        end else begin
            next_buffer <= buffer;
        end

        case (state)

        Wait: begin
            M_AXIS_TLAST <= 0;
            next_counter <= 0;
            M_AXIS_TVALID <= 0;
            in_ready <= 1;

            if (in_valid == 1) begin
                next_state <= Write;
            end else begin
                next_state <= Wait;
            end
        end

        Write: begin
            M_AXIS_TVALID <= 1;
            in_ready <= 0;

            if (counter == WIDTH-1) begin
                M_AXIS_TLAST <= 1;
            end else begin
                M_AXIS_TLAST <= 0;
            end

            if (M_AXIS_TREADY == 1) begin
                if (counter == WIDTH-1) begin
                    next_counter <= 0;
                    next_state <= Wait;
                end else begin
                    next_counter <= counter + 1;
                    next_state <= Write;
                end

            end else begin
                next_counter <= counter;
                next_state <= Write;
            end
        end

        endcase
    end

    // Clocked Logic
    always @(posedge clk) begin
        if (!rstn) begin
            counter <= 8'h00;
            state <= Wait;
        end else begin
            buffer <= next_buffer;
            state <= next_state;
            counter <= next_counter;
        end
    end
endmodule