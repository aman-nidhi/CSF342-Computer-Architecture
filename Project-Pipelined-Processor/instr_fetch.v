`timescale 1ns / 1ps


module instr_fetch(
    input clk,
    input reset,
    output [7:0] instr
    );
    
    reg [7:0] pointer;
    wire [7:0] memory[0:3];
    assign instr = memory[pointer];
    always @ (posedge clk)
    begin
    if (reset)
    pointer <= 8'b00000000;
    else
    pointer <= pointer + 1;
    end
        
      // memory content

      assign memory[0]=8'b11100100;
      assign memory[1]=8'b00100010;
      assign memory[2]=8'b00010100;
      assign memory[3]=8'b11011010;    
endmodule
