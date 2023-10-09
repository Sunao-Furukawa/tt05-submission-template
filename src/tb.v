`timescale 1ns / 1ps

module tb;

    // Inputs
    reg clk;
    reg rst_n;
    reg [7:0] in8bit;

    // Outputs
    wire [7:0] out8bit;

    // Instantiate the Unit Under Test (UUT)
    tt_um_sunaofurukawa_cpu_8bit uut (
        .clk(clk),
        .rst_n(rst_n),
        .in8bit(in8bit),
        .out8bit(out8bit)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        rst_n = 0;
        in8bit = 0;

        // Wait for 100 ns for global reset to finish
        #100;
        
        // De-assert the reset
        rst_n = 1;
        
        // Wait for 20 ns for internal operations to stabilize
        #20;

        // ADD operation: Add 5 to regA
        in8bit = 8'b00010001;  
        #20;

        // SUB operation: Subtract 3 from regA
        in8bit = 8'b00100011;  
        #20;

        // AND operation: Perform bitwise AND with regA and 4
        in8bit = 8'b00110100;  
        #20;

        // OR operation: Perform bitwise OR with regA and 2
        in8bit = 8'b01000010;  
        #20;

        // NOT operation: Perform bitwise NOT on regA
        in8bit = 8'b01010000;  
        #20;
        
    end

endmodule