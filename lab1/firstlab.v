module firstlab (SW, LEDR);
    input [9:0] SW; // Slide switches
    output [9:0] LEDR; // Red LEDs

    wire s; // Select signal
    wire [3:0] x; // Input X
    wire [3:0] y; // Input Y
    wire [3:0] m; // Output M

    // Assign signals
    assign s = SW[9];
    assign x = SW[3:0];
    assign y = SW[7:4];

    // Multiplexer logic using bitwise operations
    assign m = (s == 0) ? x : y;

    // Output assignments
    assign LEDR[9] = s;
    assign LEDR[3:0] = m;

    // Set unused LEDs to 0
    assign LEDR[8:4] = 5'b00000;
endmodule
