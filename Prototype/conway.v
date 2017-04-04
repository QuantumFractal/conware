module conway(cur_state, sum, next_state);
    input cur_state;
    input[2:0] sum;

    output next_state;

    wire eq2, eq3;

    assign eq2 = (sum == 2);
    assign eq3 = (sum == 3);

    assign next_state = (cur_state & (eq2 | eq3)) | (~cur_state & eq3);
endmodule