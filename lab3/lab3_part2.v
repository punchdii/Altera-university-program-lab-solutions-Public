module Lab3(

	input [1:0] SW,
	output [2:0] LEDR);
	
	assign LEDR[2] = SW[1];	//clock
	assign LEDR[1] = SW[0];	//D input
	
	// Instantiate D-Latch Module
	D_gated_latch dl0 (.D(SW[0]),.Clk(SW[1]),.Q(LEDR[0]));
	


endmodule






module D_gated_latch (Clk, D, Q);
	input Clk,D;
	output Q;
	wire R_g, S_g, Qa, Qb,S,R; /* synthesis keep */ 
	
	//synthesis keep means the elements are to be kept intact 
	//throughout the synthesis process, not removed
	//during optimization
	
	
	assign S = D;
	assign R = ~D;
	
	nand(R_g,R,Clk);
	nand(S_g,S,Clk);
	nand(Qa,R_g,Qb);
	nand(Qb,S_g,Qa);
	
	assign Q = Qa;


endmodule
