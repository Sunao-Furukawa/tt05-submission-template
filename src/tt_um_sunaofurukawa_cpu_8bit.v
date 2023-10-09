module tt_um_sunaofurukawa_cpu_8bit (
    input wire clk,
    input wire rst_n,
    input wire [7:0] in8bit,
    output wire [7:0] out8bit
);

    // Define the instruction set
    localparam ADD = 4'b0001;
    localparam SUB = 4'b0010;
    localparam AND = 4'b0011;
    localparam OR = 4'b0100;
    localparam NOT = 4'b0101;

    // Define the registers
    reg [7:0] regA;
    
    // Define the instruction register
    reg [3:0] instruction;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            regA <= 8'b0;
        end else begin
            instruction <= in8bit[3:0];
            case (instruction)
                ADD: regA <= regA + in8bit[7:4];
                SUB: regA <= regA - in8bit[7:4];
                AND: regA <= regA & in8bit[7:4];
                OR: regA <= regA | in8bit[7:4];
                NOT: regA <= ~regA;
            endcase
        end
    end
    assign out8bit = regA;

endmodule