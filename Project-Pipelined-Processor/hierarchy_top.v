`timescale 1ns / 1ps


module hierarchy_top(
    input clk,
    input reset,
    output [7:0] x,y,z
    );
    wire [7:0] instr;
    wire [1:0] func;
    wire [2:0] rdst,rsrc,rdst_2,imm_data_out;
    wire [7:0] reg1_data,reg2_data,write_data;
    wire [7:0] reg1_data_2,reg2_data_2;
    wire alu_control;
    wire write,status,status_2;
    instr_fetch a(clk,reset,instr);
    if_idreg b(clk,reset,instr,func,rdst,rsrc,status);
    regfile c(rdst,rsrc,reset,write,reg1_data,reg2_data,write_data,rdst_2,x,y,z);
    id_wbreg d(clk,reset,reg1_data,reg2_data,reg1_data_2,reg2_data_2,rdst,rsrc,rdst_2,imm_data_out,status,status_2);
    execute e(reg1_data_2,reg2_data_2,imm_data_out,alu_control,write_data);
    control_unit f(clk,func,alu_control,write,status,status_2,reset);

endmodule
