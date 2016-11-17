`timescale 1ns / 1ps

module regfile(
    input [2:0] reg_1,
    input [2:0] reg_2,
    input reset,
    input write,
    output [7:0] reg_1_data,
    output [7:0] reg_2_data,
    input [7:0] writeback,
    input [2:0] reg_write,
	output [7:0] x,y,z//For checking the outputs in test bench   
    );
    reg [7:0] register[0:7];
    assign reg_1_data = register[reg_1];
    assign reg_2_data = register[reg_2];
    always @ (negedge write)
    if (reset)
        begin
        register[0]<=8'b11101100;
        register[1]<=8'b0;
        register[2]<=8'b11101100;
        register[3]<=8'b11100000;
        register[4]<=8'b11101111;
        register[5]<=8'b0;
        register[6]<=8'b0;
        register[7]<=8'b0;
        end
        else
    begin
    register[reg_write]=writeback;
    end  
     assign x = register[4];
     assign y = register[2];
	 assign z = register[3];    
endmodule
