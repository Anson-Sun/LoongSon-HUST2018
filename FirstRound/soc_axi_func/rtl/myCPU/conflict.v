/*
**	作者：张鑫
**	功能：load-use冲突检测，生成气泡信号
**	原创
*/
module conflict(
	r1_r_id,
	r2_r_id,
	r1_id,
	r2_id,
	rw_ex,
	rw_mem,
	load_ex,
	load_mem,

	conflict_stall
);
	
	input r1_r_id;
	input r2_r_id;
	input [4:0]r1_id;
	input [4:0]r2_id;
	input [4:0]rw_ex;
	input [4:0]rw_mem;
	input load_ex;
	input load_mem;
	output conflict_stall;

	wire and1;
	wire and2;
	wire and3;
	wire and4;

	assign and1 = r1_r_id && (r1_id==rw_ex);
	assign and2 = r2_r_id && (r2_id==rw_ex);
	assign and3 = r1_r_id && (r1_id==rw_mem);
	assign and4 = r2_r_id && (r2_id==rw_mem);

	assign conflict_stall = ( load_ex && (and1 || and2) && (rw_ex!=0) )
						||( load_mem && (and3 ||and4) && (rw_mem!=0) );
endmodule


module special_pop (
	load_store,
	alu_r1_ex,
	not_nop_mem,

	special_pop
	
);
	input [2:0]load_store;
	input [31:0]alu_r1_ex;
	input not_nop_mem;
	output special_pop;
	
	assign special_pop = (&load_store) && ((alu_r1_ex==32'hfffffff8)||(alu_r1_ex==32'hfffffffc)) && not_nop_mem;
endmodule