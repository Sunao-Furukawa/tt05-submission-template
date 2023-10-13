module tt_um_sunaofurukawa_cpu_8bit (
    input wire clk,
    input wire rst_n,
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
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
        end else if (ena == 1'b1) begin
            instruction <= ui_in[3:0];
            case (instruction)
                ADD: regA <= regA + ui_in[7:4];
                SUB: regA <= regA - ui_in[7:4];
                AND: regA <= regA & ui_in[7:4];
                OR: regA <= regA | ui_in[7:4];
                NOT: regA <= ~regA;
            endcase
        end
    end
    // Disable all bidir outputs: make them inputs only:
    assign uio_oe = 8'b00000000;
    // The following will never be used, but satisfies the synthesis of output drivers anyway:
    assign uio_out = 8'd0;
    assign uo_out = regA;

endmodule