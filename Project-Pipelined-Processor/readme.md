## Computer Architer Project @BITS Pilani Hyderabad


Implement 3-stage pipelined processor in verilog. This processor supports load immediate (li) and shift right arithmetic (sra) instructions only. The processor has Reset, CLK as inputs and no outputs. The processor has instruction fetch unit, register file and Execution/Writeback unit. The processor also contains two pipelined registers IF/ID and ID/EXWB. When reset is activated the PC, IF/ID, ID/EXWB registers are initialized to 0, the instruction memory and registerfile get loaded by predefined values. When the instruction unit starts fetching the first instruction the pipeline registers contain unknown values. When the second instruction is being fetched in IF unit, the IF/ID registers will hold the instruction code for first instruction. When the third instruction is being fetched by IF unit, the IF/ID register contains the instruction code of second instruction and ID/EXWB register contains information related to first instruction. 


`May the MIPS be with you!`