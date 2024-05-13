//module firstlab (
//
//	input [1:0] SW,
//	output [6:0] HEX0);


	
	
	
	
module firstlab (SW, LEDR, HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
	input [9:0] SW; // slide switches
	output [9:0] LEDR; // red lights
	output [6:0] HEX0;
	output [6:0] HEX1;
	output [6:0] HEX2;
	output [6:0] HEX3;
	output [6:0] HEX4;
	output [6:0] HEX5;
	

	
	
	assign LEDR = SW;
	
	wire [1:0] M0;
	wire [1:0] M1;
	wire [1:0] M2;
	wire [1:0] M3;
	wire [1:0] M4;
	wire [1:0] M5;
	

	
	
	
	
	mux_3bit_6to1 U0 (SW[9:7], 000, 001, 010, 011,100,101, M0);
	mux_3bit_6to1 U1 (SW[9:7], 101,000, 001, 010, 011,100,M1);
	mux_3bit_6to1 U2 (SW[9:7], 100,101, 000, 001, 010, 011,M2);
	mux_3bit_6to1 U3 (SW[9:7], 011,100,101, 000, 001, 010,M3);
	mux_3bit_6to1 U4 (SW[9:7], 010,011,100,101,000,001, M4);
	mux_3bit_6to1 U5 (SW[9:7], 001,010,011,100,101,000, M5);
	
	
	
	char_7seg H0 (M0, HEX0);
	char_7seg H1 (M1, HEX1);
	char_7seg H2 (M2, HEX2);
	char_7seg H3 (M3, HEX3);
	char_7seg H4 (M4, HEX4);
	char_7seg H5 (M5, HEX5);

endmodule
 //implements a 2-bit wide 4-to-1 multiplexer

module mux_3bit_6to1 (S, U, V, W, X,Y,Z,M);
	input [2:0] S, U, V, W, X,Y,Z;
	output [2:0] M;
	 
	assign M = (S[2] == 0) ? 
                ((S[1] == 0) ? 
                    ((S[0] == 0) ? U : V) : 
                    ((S[0] == 0) ? W : X)) : 
                ((S[1] == 0) ? 
                    ((S[0] == 0) ? Y : Z) : 
                    // The 6th input is missing here, as a 3-bit selector has 8 possibilities
                    // You can add another input or handle the unused cases as you see fit
                    3'b000);
	 
	 
	 //if nto working try m1 m0
	
endmodule

// implements a 7-segment decoder for d, E, 1 and 0
module char_7seg (C, Display);
	input [2:0] C; // input code
	output [6:0] Display; // output 7-seg code

	assign Display[0] = ~C[2] & ~C[1] & ~C[0] | ~C[2] & C[1] & ~C[0]| C[2] & ~C[1] & C[0]| C[2] & ~C[1] & ~C[0];
	assign Display[1] = ~C[2] & ~C[1] & C[0]| C[2] & ~C[1] & C[0]| C[2] & ~C[1] & ~C[0];
	assign Display[2] = ~C[2] & ~C[1] & C[0]| C[2] & ~C[1] & C[0]| C[2] & ~C[1] & ~C[0];
	assign Display[3] = ~C[2] & C[1] & ~C[0]| C[2] & ~C[1] & C[0]| C[2] & ~C[1] & ~C[0];
	assign Display[4] = ~C[2] & C[1] & ~C[0]| C[2] & ~C[1] & C[0]| C[2] & ~C[1] & ~C[0];
	assign Display[5] = ~C[2] & ~C[1] & ~C[0] | ~C[2] & C[1] & ~C[0]| C[2] & ~C[1] & C[0]| C[2] & ~C[1] & ~C[0];
	assign Display[6] = ~C[2] & C[1] & ~C[0] | ~C[2] & C[1] & C[0]| C[2] & ~C[1] & C[0]| C[2] & ~C[1] & ~C[0];
	

endmodule

	
	