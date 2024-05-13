//lab2 part2 actually
module Lab2(
    input [3:0] SW,
	 output  [7:0] LEDR,
    output [6:0] HEX1, // a-g segments for HEX1
    output [6:0] HEX0  // a-g segments for HEX0
	 
);

	wire [3:0] V,A,M,M1;	 //neccesary?
	wire [6:0] hex0, hex1;
	wire boolean;
		
	assign LEDR = SW;
	assign V = SW[3:0];
	
	
	//circuit A
	assign A = V-4'b1010; //does 1010 not work?


	//comparator
	comparator(V,boolean);
	
	//multiplexer
	mux_4bit_2to1(boolean,A,V,M);
	mux_4bit_2to1(boolean,0001,0000,M1);
	
	
	//display decoder
	seven_segment(M,hex0);
	seven_segment(M1,hex1);
		
	assign HEX1 = hex1;
	assign HEX0 = hex0;
		
	
endmodule


module mux_4bit_2to1 (S,A,V,M);
	input [3:0] A,V;
	input S;
	output [3:0] M;
	 
	assign M = (S == 0) ? V : A; 

	 
	 //if nto working try m1 m0
endmodule



module comparator (cmp_in, cmp_out);
	input [3:0] cmp_in;
	output cmp_out;

	assign cmp_out = (cmp_in > 4'b1001) ? 1'b1 : 1'b0; //we can use 1'b1 to represent true, 1'b0 for false
	
endmodule




module seven_segment(c, segment);
	input [3:0] c;
	output [6:0] segment;
	
	assign segment[0] = (~c[3]&~c[2]&~c[1]&c[0])|(~c[3]&c[2]&~c[1]&~c[0]);	
	//segment off, digits(1,4)
	//0001 OR 0100
	assign segment[1] = (~c[3]&c[2]&~c[1]&c[0])|(~c[3]&c[2]&c[1]&~c[0]);	
	//segment off, digits(5,6)
	//0101 OR 0110
	assign segment[2] = (~c[3]&~c[2]&c[1]&~c[0]);	
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
