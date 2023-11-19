`timescale 1ns / 1ps

module forwarding(
    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB,
    input [4:0] IDEX_Rs,
    input [4:0] IDEX_Rt,
    input [4:0] EXMEM_Rd,
    input [4:0] MEMWB_Rd,
    input EXMEM_RegWrite,
    input MEMWB_RegWrite
    );    
    
    
    always @ (IDEX_Rs or IDEX_Rt or EXMEM_Rd  or MEMWB_Rd) begin
        assign ForwardA = 0;
        assign ForwardB = 0;
        
        if ((EXMEM_RegWrite && MEMWB_RegWrite && EXMEM_Rd != 0) && (EXMEM_Rd == IDEX_Rs)) begin
            assign ForwardA = 2;
        end
        
        if ((EXMEM_RegWrite && MEMWB_RegWrite && EXMEM_Rd != 0) && (EXMEM_Rd == IDEX_Rt)) begin
            assign ForwardB = 2;
        end
        
        if ((EXMEM_RegWrite && MEMWB_RegWrite && MEMWB_Rd != 0) && (EXMEM_Rd != IDEX_Rs) && (MEMWB_Rd == IDEX_Rs)) begin
            assign ForwardA = 1;
        end 
        
        if ((EXMEM_RegWrite && MEMWB_RegWrite && MEMWB_Rd != 0) && (EXMEM_Rd != IDEX_Rt) && (MEMWB_Rd == IDEX_Rt)) begin
            assign ForwardB = 1;
        end
    end

endmodule