`timescale 1ns / 1ps


module id_wbreg(
    input clk,
    input reset,
    input [7:0] data_a,
    input [7:0] data_b,
    output reg [7:0] data_a_out,
    output reg [7:0] data_b_out,
    input [2:0] rdst,imm_data,
    output reg [2:0] rdst_out,imm_data_out,
    input status,
    output reg status_1   
    );
    
    always @ (posedge clk)
    if (reset)
    begin
        data_a_out <= 8'b00000000;
        data_b_out <= 8'b00000000;
        rdst_out <= 3'b000;
		imm_data_out <= 3'b000;
        status_1 <= 1'b0;
        end
    else
    begin
    data_a_out <= data_a;
    data_b_out <= data_b;
    rdst_out <= rdst;
	imm_data_out <= imm_data;
    status_1 <= status;
    end
    
endmodule
