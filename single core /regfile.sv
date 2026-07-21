// This is gonna be the memory or the reg file of the tiny single core processor.
module regfile(
    input logic clk, // for write operations which are synchronous to the clock
    input logic rst_n, // for resetting the reg file to 0
    input logic [4:0] rs1 , rs2 , rd, // rs1 and rs2 are the source registers of two input ports A and B in our alu, rd is the destination register to write the result of the alu operation
    input logic [31:0] write_data, // data to be written to the destination register rd
    input logic reg_write_en, // enable signal to write to the destination register rd
    output logic [31:0] read_data1, read_data2 // data read from the source registers rs1 and rs2   
);

logic [31:0] registers [31:0]; // 32 registers of 32 bits each , this is our main frame array which we'll use to assign values to the registers and read values from the registers.

assign read_data1 = (rs1 == 5'b0)? 32'b0 : registers[rs1]; // read data from source register rs1
assign read_data2 = (rs2 == 5'b0)? 32'b0 : registers[rs2]; // read data from source register rs2
 // Reads have to be ansyc and the writes have to be synchronous to the clock, so we do not have to worry about the read and write operations clashing with each other. we have put the rs1 and rs2 to be 0, so that we can read the x0 
//register which is always 0 in RISC-V architecture. The write operation is synchronous to the clock and will only happen on the positive edge of the clock when reg_write_en is high and rd is not x0. The reset operation will reset all the registers to 0 on the negative edge of the reset signal.
    
always_ff @(posedge clk or negedge rst_n )begin 
    
    if(!rst_n)begin 
        for (int i = 0 ; i < 32 ; i++ )begin 
            registers[i] <= 32'b0; // reset all registers to 0 on reset, main purpose of active low reset button. 
        end
    end
            
        
    else if(reg_write_en && rd != 5'b0)begin 
            registers[rd] <= write_data; // write data to destination register rd if reg_write_en is high and rd is not x0, and our reset is    
        
    end
end
endmodule