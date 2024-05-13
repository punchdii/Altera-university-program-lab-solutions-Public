//module firstlab (
//
//	input [1:0] SW,
//	output [6:0] HEX0);


	
	
	
	
module firstlab (SW, LEDR, HEX0,HEX1,HEX2,HEX3);
	input [9:0] SW; // slide switches
	output [9:0] LEDR; // red lights
	output [6:0] HEX0;
	output [6:0] HEX1;
	output [6:0] HEX2;
	output [6:0] HEX3;
	

	
	
	assign LEDR = SW;
	
	wire [1:0] M0;
	wire [1:0] M1;
	wire [1:0] M2;
	wire [1:0] M3;
	
	mux_2bit_4to1 U0 (SW[9:8], SW[7:6], SW[5:4], SW[3:2], SW[1:0], M0);
	mux_2bit_4to1 U1 (SW[9:8], SW[1:0],SW[7:6], SW[5:4], SW[3:2], M1);
	mux_2bit_4to1 U2 (SW[9:8],  SW[3:2], SW[1:0], SW[7:6], SW[5:4], M2);
	mux_2bit_4to1 U3 (SW[9:8], SW[5:4], SW[3:2], SW[1:0],SW[7:6],M3);
	
	char_7seg H0 (M0, HEX0);
	char_7seg H1 (M1, HEX1);
	char_7seg H2 (M2, HEX2);
	char_7seg H3 (M3, HEX3);

endmodule
// implements a 2-bit wide 4-to-1 multiplexer

module mux_2bit_4to1 (S, U, V, W, X, M);
	input [1:0] S, U, V, W, X;
	output [1:0] M;
//	
//    assign S[0] = SW[9];
//	 assign S[1] = SW[8];
//    assign U = SW[7:6];
//    assign V = SW[5:4];
//	 assign W = SW[3:2];
//    assign X = SW[1:0];
	 
	 assign M = (S[1] == 0) ? ((S[0] == 0) ? U : V): ((S[0] == 0) ? W : X);
	 //if nto working try m1 m0
	
endmodule

// implements a 7-segment decoder for d, E, 1 and 0
module char_7seg (C, Display);
	input [1:0] C; // input code
	output [6:0] Display; // output 7-seg code
	
	assign Display[0] = ~C[1] & ~C[0] | C[1] & ~C[0];
	assign Display[1] = ~C[1] & C[0];
	assign Display[2] = ~C[1] & C[0];
	assign Display[3] = C[1] & ~C[0]; 
	assign Display[4] = C[1] & ~C[0]; 
	assign Display[5] = ~C[1] & ~C[0] | C[1] & ~C[0];
	assign Display[6] = C[1] & ~C[0] | C[1] & C[0];


endmodule

	
	
	
	
	
	
	
	

//	assign C[0] = SW[0];
//	assign C[1] = SW[1];
//
//
//
//// is ~C[1] just 0? if C[1] is 0, is ~C[1] 1? 
//
//		// Assign statements for each segment based on the input C[1]C[0]
//	assign HEX0[0] = ~C[1] & ~C[0] | C[1] & ~C[0];
//	assign HEX0[1] = ~C[1] & C[0];
//	assign HEX0[2] = ~C[1] & C[0];
//	assign HEX0[3] = C[1] & ~C[0]; 
//	assign HEX0[4] = C[1] & ~C[0]; 
//	assign HEX0[5] = ~C[1] & ~C[0] | C[1] & ~C[0];
//	assign HEX0[6] = C[1] & ~C[0] | C[1] & C[0];




//    input [9:0] SW; // Slide switches
//    output [9:0] LEDR; // Red LEDs
//
//    wire s1; // Select signal
//	 wire s2; // Select signal
//	 
//    wire [1:0] u; // Input X
//    wire [1:0] v; // Input Y
//    wire [1:0] w; // 
//	 wire [1:0] x; // 
//	 wire [1:0] m; //Output M
//	 
//
//    // Assign signals
//    assign s1 = SW[9];
//	 assign s2 = SW[8];
//	 
//    assign u = SW[7:6];
//    assign v = SW[5:4];
//	 assign w = SW[3:2];
//    assign x = SW[1:0];
//
//    // Multiplexer logic using bitwise operations
//    assign m = (s2 == 0) ? ((s1 == 0) ? u : v): ((s1 == 0) ? w : x) ;
//
//    // Output assignments
//    assign LEDR[9] = s1;
//	 assign LEDR[8] = s2;
//	 
//    assign LEDR[1:0] = m;


//endmodule
