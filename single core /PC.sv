// cutting the bs aside , we have the pc , it stores the address of next instruction to be executed, it is a 32 bit register, and it is updated every clock cycle based on the instruction being executed.
module PC(
    input logic clk, rst ,PC_En,// clk to strike on posedge , rst_n for negedge of reset block and pc_en for enabling the pc to update it's value based on current isntruction being executed
    input logic [31:0] PC_In, // input to the pc from the adder block which adds 4 to the current pc value to get the next instruction address.
    output logic [31:0] PC_Out // output of the pc to the instruction memory block to fetch the instruction at that address.
);


always @(posedge clk or negedge rst) begin 
    if(!rst)begin 
        PC_Out <= 32'b0; // reset the pc to 0

    end
    else if(PC_En)begin 
        PC_Out <= PC_In;// the add 4 thing is in the top wrapped module connecting everything together, so we just take the input from that and update the pc value to that.

    end
end 
endmodule