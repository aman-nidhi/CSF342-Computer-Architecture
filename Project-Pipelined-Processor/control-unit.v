`timescale 1ns / 1ps


module control_unit(
    input clk,
    input [1:0] func,
    output reg alu_control,
    output reg write,
    input status,
    input status_2,
    input reset
    
    );
    
    always @ (posedge clk)
     if (status)begin
    alu_control <= func;
    
    end
    always @ *
    if (status_2)
     write <=clk;
     else 
     if (reset)
      write <=clk;
      
endmodule
