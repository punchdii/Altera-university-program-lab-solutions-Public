module Lab3(

	input [1:0] SW,
	output [2:0] LEDR);
	
	wire D,Clk,Qa,Qb,Qc;
	
	D_gated_latch h0(Clk, D, Qa);
	positive_edge_flipflop h1(Clk, D, Qb);
	negative_edge_flipflop h2(Clk, D, Qc);


endmodule








module positive_edge_flipflop(Clk,D,Q)

	input Clk,D;
	output Q;
	
	wire R_g, S_g, Qa, Qb,S,R, Qm,Qs;/* synthesis keep */ 


	
	// Instantiate D-Latch Module
	D_gated_latch dl1 (.D(D),.Clk(~Clk),.Q(Qm));
	D_gated_latch dl0 (.D(Qm),.Clk(CLK),.Q(Qs));
	
	assign Q = Qs;


endmodule




module negative_edge_flipflop(Clk,D,Q)

	input Clk,D;
	output Q;
	
	wire R_g, S_g, Qa, Qb,S,R, Qm,Qs;/* synthesis keep */ 


	
	// Instantiate D-Latch Module
	D_gated_latch dl1 (.D(D),.Clk(Clk),.Q(Qm));
	D_gated_latch dl0 (.D(Qm),.Clk(~CLK),.Q(Qs));
	
	
	assign Q = Qs;

endmodule



module D_Latch (Clk, D, Q);
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

module D_gated_latch (Clk, D, Q);
	input D, Clk;
	output reg Q;
	always @ (D, Clk)
	if (Clk)
	Q = D;
endmodule

