`timescale 1ns / 1ps

module if_idreg(
    input clk,
    input reset,
    input [7:0] instr,
    output reg [1:0] func,
    output reg [2:0] rdst,
    output reg [2:0] rsrc,
    output reg status
    );
    
    always @ (posedge clk)
    if (reset)
    begin
    {func,rdst,rsrc}<=8'b00000000;
    status <= 1'b0;
    end
    else begin
    {func,rdst,rsrc}<=instr;
    status <=1'b1;
    end
    
    
endmodule
