// first alu, no flags cause am not a retard to have so many carries during a single core duh
module ALU (
    input  logic [31:0] A, B,      // Main 32-bit inputs for ALU
    input  logic        ALU_En,    // ALU enable signal
    input  logic [1:0]  op_sel,    // 2-bit select signal (00=AND, 01=OR, 10=ADD, 11=SUB)
    output logic [31:0] Alu_Out ,
      // Final output of ALU
    output logic       Zero_Flag  // Flag indicating if the output is zero, later used for branching
);

    // Internal variables for operations
    logic [31:0] and_op;
    logic [31:0] or_op;
    logic [31:0] add_op;
    logic [31:0] sub_op;

    // always comb with (*) type thingm changes when en or such changes , since alu is a basic combinational logic block, we thought of dumping the idea of adding more flags as it will stalll the single cycle processor and we will have to add more logic to handle the flags, which is not the case in this simple ALU design. The Zero_Flag is set based on the output of the ALU operation.
    assign Zero_Flag = (Alu_Out == 32'b0) ? 1'b1 : 1'b0;
    always_comb begin
        // 1. Calculate operations (2's complement subtraction included)
        and_op = A & B;
        or_op  = A | B;
        add_op = A + B;
        sub_op = A + (~B + 32'b1); // Two's complement subtraction (A + NOT(B) + 1)

        // 2. Check if the ALU is enabled
        if (ALU_En) begin
            case (op_sel)
                2'b00:   Alu_Out = and_op; // AND
                2'b01:   Alu_Out = or_op;  // OR
                2'b10:   Alu_Out = add_op; // ADD
                2'b11:   Alu_Out = sub_op; // SUB
                default: Alu_Out = 32'b0;  // Default safety case
            endcase
        end else begin
            Alu_Out = 32'b0; // If ALU is disabled, output 0
        end
    end

endmodule