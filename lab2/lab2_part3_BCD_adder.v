
//lab2_part3_full_adder
module Lab2 (SW, LEDR,HEX1,HEX3,HEX5,HEX0);
	input [8:0] SW;
	output [9:0] LEDR;
	output [6:0] HEX1, HEX0,HEX3,HEX5; // a-g segments for HEX1

	 
	//s0 s1 on hex0 hex1, x,y on hex3 hex5 
	wire [3:0] a, b, s;   //a b are input, s is result
	wire [2:0] c;
	wire ci, co;
	wire [6:0] hex0, hex1,hex3,hex5;
	wire [4:0]Sum;
	wire [4:0] A,M,M1;
	
	assign a = SW[7:4];
	assign b = SW[3:0];
	assign ci = SW[8];


	seven_segment h3(a,hex3);
	seven_segment h5(b,hex5);
	assign HEX3 = hex3;
	assign HEX5 = hex5;
	
	
	full_adder f0 (.a(a[0]),.b(b[0]),.ci(ci),.s(s[0]),.co(c[0]));
	full_adder f1 (.a(a[1]),.b(b[1]),.ci(c[0]),.s(s[1]),.co(c[1]));
	full_adder f2 (.a(a[2]),.b(b[2]),.ci(c[1]),.s(s[2]),.co(c[2]));
	full_adder f3 (.a(a[3]),.b(b[3]),.ci(c[2]),.s(s[3]),.co(co));
	
	
	
	assign Sum[4] = co;
	assign Sum[3:0] = s[3:0];
	
	
	
	assign A = Sum-5'b01010; //does 1010 not work?


	//comparator
	comparator(Sum,boolean);
	
	
	//multiplexer
	mux_5bit_2to1(boolean,A,Sum,M);
	mux_5bit_2to1(boolean,00001,00000,M1);
	
	
	seven_segment(M,hex0);
	seven_segment(M1,hex1);
		
	assign HEX1 = hex1;
	assign HEX0 = hex0;
		
	
	

endmodule
	
module full_adder (a, b, ci, s, co);
	input a, b, ci;
	output s, co;
	
	assign s = ((a ^ b) ^ ci);
	assign co = ((a ^ b) == 1'b1) ? ci : b;

endmodule

module seven_segment(c, segment);
	input [4:0] c; //was 3:0
	output [6:0] segment;
	
	assign segment[0] = (~c[3]&~c[2]&~c[1]&c[0])|(~c[3]&c[2]&~c[1]&~c[0]);	
	//segment off, digits(1,4)
	//0001 OR 0100
	assign segment[1] = (~c[3]&c[2]&~c[1]&c[0])|(~c[3]&c[2]&c[1]&~c[0]);	
	//segment off, digits(5,6)
	//0101 OR 0110
	assign segment[2] = (~c[3]&~c[2]&c[1]&~c[0])|(c[4]&~c[3]&~c[2]&~c[1]&~c[0]);
	//segment off, digits(2)
	//0010
	assign segment[3] = (~c[3]&~c[2]&~c[1]&c[0])|(~c[3]&c[2]&~c[1]&~c[0])|(~c[3]&c[2]&c[1]&c[0])|(c[3]&~c[2]&~c[1]&c[0]);	
	//segment off, digits(1,4,7,9)
	//0001 OR 0100 OR 0111 OR 1001
	assign segment[4] = (~c[3]&~c[2]&~c[1]&c[0])|(~c[3]&~c[2]&c[1]&c[0])|(~c[3]&c[2]&~c[1]&~c[0])|(~c[3]&c[2]&~c[1]&c[0])|(~c[3]&c[2]&c[1]&c[0])|(c[3]&~c[2]&~c[1]&c[0]);	
	//segment off, digits(1,3,4,5,7,9)
	//0001 OR 0011 OR 0100 OR 0101 OR 0111 OR 1001 
	assign segment[5] = (~c[3]&~c[2]&~c[1]&c[0])|(~c[3]&~c[2]&c[1]&~c[0])|(~c[3]&~c[2]&c[1]&c[0])|(~c[3]&c[2]&c[1]&c[0]);	
	//segment off, digits(1,2,3,7)
	//0001 OR 0010 OR 0011 OR 0111 
	assign segment[6] = (~c[3]&~c[2]&~c[1]&~c[0])|(~c[3]&~c[2]&~c[1]&c[0])|(~c[3]&c[2]&c[1]&c[0]);	
	//segment off, digits(0,1,7)
	//0000 OR 0001 OR 0111

endmodule


module mux_5bit_2to1 (S,A,V,M);
	input [4:0] A,V;
	input S;
	output [4:0] M;
	 
	assign M = (S == 0) ? V : A; 

	 
	 //if nto working try m1 m0
endmodule

module comparator (cmp_in, cmp_out);
	input [4:0] cmp_in;
	output cmp_out;

	assign cmp_out = (cmp_in > 5'b1001) ? 1'b1 : 1'b0; //we can use 1'b1 to represent true, 1'b0 for false
	
endmodule

//
//
//module crktA(in, out)
//
//	input[3:0] in;
//	output reg[3:0] out;
//	always @(in)
//		begin
//			case(in)
//				4'b1010: out = 4'b0000;
//				4'b1010: out = 4'b0000;
//				4'b1010: out = 4'b0000;
//				4'b1010: out = 4'b0000;
//				defulat: out = 4'bxxxx;
//			endcase
//				
//		
//		
//		end
//endmodule

