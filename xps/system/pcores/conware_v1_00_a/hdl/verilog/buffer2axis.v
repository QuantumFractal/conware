module buffer2axis #(
    parameter DWIDTH = 32,
    parameter WIDTH = 4,
    parameter HEIGHT = 4
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
    in_ready
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

    input [WIDTH*HEIGHT-1:0] in_data;
    input in_valid;
    output reg in_ready;

    // State params
    reg state;
    reg next_state;
    localparam Wait = 0;
    localparam Write = 1;

    // Internal values
    reg [DWIDTH - 1:0] buffer [WIDTH*HEIGHT-1:0];
    reg [31:0] counter;
    reg [31:0] next_counter;

    // Combinational Logic
    always @* begin
        M_AXIS_TLAST <= 0;
        M_AXIS_TDATA <= buffer[counter];

        case (state)

        Wait: begin
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

            if (counter == WIDTH*HEIGHT-1) begin
                M_AXIS_TLAST <= 1;
            end

            if (M_AXIS_TREADY == 1) begin
                if (counter == WIDTH*HEIGHT-1) begin
                    next_counter <= 0;
                    next_state <= Wait;
                end else begin
                    next_counter <= counter + 1;
                end

            end else begin
                next_counter <= counter;
            end
        end

        endcase
    end

    // Clocked Logic
    always @(posedge clk) begin
        if (!rstn) begin
            counter <= 32'h00000000;
            state <= Wait;
        end else begin
            state <= next_state;
            counter <= next_counter;
        end
    end

    // Handle resetting buffer and color conversion
    genvar i;
    generate 
        for (i = 0; i < WIDTH*HEIGHT; i=i+1) begin : converter_block
            always @(posedge clk) begin
                if (!rstn) begin
                    buffer[i] <= 'h00000000;
                end else if (state == Wait && in_valid == 1) begin
                    buffer[i] <= (in_data[i] == 1)? alive_color : dead_color;
                end
            end
            
        end
    endgenerate
endmodule