//-------------------------------------------------------------------------
//      PS2 Keyboard interface                                           --
//      Sai Ma                                                           --
//      11-13-2014                                                       --
//                                                                       --
//      For use with ECE 385 Final Project                     --
//      ECE Department @ UIUC                                            --
//-------------------------------------------------------------------------
module keyboard(input logic Clk, psClk, psData, reset,
					 
					 output logic w,a,s,d,j,kpu,kpd,kpl,kpr,kpen,
					 output [7:0] c_out, b_out, a_out);
					
					
	logic Q1, Q2, en, enable, shiftoutA, shiftoutB, shiftoutC, shiftoutD, Press;
	logic [4:0] Count; 
	logic [10:0] DO_A, DO_B, DO_C;
	logic [7:0] Data;
	logic [9:0] counter;
	assign c_out=DO_C[8:1];
	assign b_out=DO_B[8:1];
	assign a_out=DO_A[8:1];
	
	logic [7:0] keyCode;
	
	//Counter to sync ps2 clock and system clock
	always@(posedge Clk or posedge reset)
	begin
		if(reset)
		begin
			counter = 10'b0000000000;
			enable = 1'b1;
		end
		else if (counter == 10'b0111111111)
		begin
			counter = 10'b0000000000;
			enable = 1'b1;
		end
		else 
		begin
			counter += 1'b1;
			enable = 1'b0;
		end
	end
	
	//edge detector of PS2 clock
	always@(posedge Clk)
	begin
		if(enable==1)
		begin
			if((reset)|| (Count==5'b01011))    
				Count <= 5'b00000;
		else if(Q1==0 && Q2==1)
			begin  			
				Count += 1'b1;
				en = 1'b1;
			end
		end
	end

	logic [3:0] bit11;
	
	always@(posedge psClk or posedge reset)
	begin
		if(reset)
			bit11=0;
		else if (bit11==4'b1010)
			bit11=0;
		else
			bit11 = bit11+1;
	end
	
	always@(posedge Clk)
	begin
		if (reset)
		begin
			w=0;
			a=0;
			s=0;
			d=0;
			j=0;
			kpu=0;
			kpd=0;
			kpl=0;
			kpr=0;
			kpen=0;
		end
//		if( b11count == 5'b01011)
		if(bit11==0)
		begin
			case(DO_C[8:1])
			8'h1D : if(DO_B[8:1] == 8'hF0) w= 0; else w=1;
			8'h1B : if(DO_B[8:1] == 8'hF0) s= 0; else s=1;
			8'h1C : if(DO_B[8:1] == 8'hF0) a= 0; else a=1;
			8'h23 : if(DO_B[8:1] == 8'hF0) d= 0; else d=1;
			8'h3B : if(DO_B[8:1] == 8'hF0) j= 0; else j=1;
			
			8'h75 : if(DO_B[8:1] == 8'hF0) kpu= 0; else kpu=1;
			8'h6B : if(DO_B[8:1] == 8'hF0) kpl= 0; else kpl=1;
			8'h72 : if(DO_B[8:1] == 8'hF0) kpd= 0; else kpd=1;
			8'h74 : if(DO_B[8:1] == 8'hF0) kpr= 0; else kpr=1;
			8'h5A : if(DO_B[8:1] == 8'hF0) kpen= 0; else kpen=1;
			
			endcase
		
		end
	end
	
	Dreg Dreg_instance1 ( .*,
								 .Load(enable),
								 .Reset(reset), 
								 .D(psClk),
								 .Q(Q1) );
   Dreg Dreg_instance2 ( .*,
								 .Load(enable),
								 .Reset(reset), 
								 .D(Q1),
								 .Q(Q2) );

	
	reg_11 reg_C(
					.Clk(psClk),
					.Reset(reset), 
					.Shift_In(psData), 
					.Load(1'b0), 
					.Shift_En(en),
					.D(11'd0),
					.Shift_Out(shiftoutC),
					.Data_Out(DO_C)
					);
						
	reg_11 reg_B(
					.Clk(psClk),
					.Reset(reset), 
					.Shift_In(shiftoutC), 
					.Load(1'b0), 
					.Shift_En(en),
					.D(11'd0),
					.Shift_Out(shiftoutB),
					.Data_Out(DO_B)
					);
	
	reg_11 reg_A(
					.Clk(psClk),
					.Reset(reset), 
					.Shift_In(shiftoutB), 
					.Load(1'b0), 
					.Shift_En(en),
					.D(11'd0),
					.Shift_Out(shiftoutA),
					.Data_Out(DO_A)
					);
		
	assign keyCode=Data;
	assign press=Press;
	
endmodule 