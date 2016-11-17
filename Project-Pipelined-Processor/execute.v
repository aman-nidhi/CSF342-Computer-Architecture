`timescale 1ns / 1ps


module execute(
    input [7:0] data_a,
    input [7:0] data_b,
	input [2:0] imm_data,
    input control,
    output reg [7:0] data_out
    );
	wire [1:0] empty;
	wire sign;
	assign {sign,empty}=imm_data;
    always @*
    if (control)
	    data_out = {sign,sign,sign,sign,sign,imm_data};
    else
        data_out = data_a >> imm_data;
        
endmodule
