//-------------------------------------------------------------------------
//      lab7_usb.sv                                                      --
//      Christine Chen                                                   --
//      Fall 2014                                                        --
//                                                                       --
//      Fall 2014 Distribution                                           --
//                                                                       --
//      For use with ECE 385 Lab 7                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module  lab7_usb 		( input         Clk,
                                     Reset,
												 psClk,
												 psData,
												 KEY3,
												 KEY2,
							  output [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
							  output [8:0]  LEDG,
							  output [17:0] LEDR,
							  // VGA Interface 
                       output [7:0]  Red,
							                Green,
												 Blue,
							  output        VGA_clk,
							                sync,
												 blank,
												 vs,
												 hs

							  		);
    
    logic Reset_h, vssig;
    logic [9:0] drawxsig, drawysig, ballxsig, ballysig, ballsizesig;
	 logic [7:0] keycode;
	 
	 
	 keyboard key(.*, .reset(Reset_h));
    wire w,a,s,d,j,kpu,kpd,kpl,kpr,kpen;
	 assign LEDG[4:0] = {w,a,s,d,j};
	 assign LEDR[4:0] = {kpu,kpd,kpl,kpr,kpen};
	 wire [7:0] c_out, b_out, a_out;
    
	 assign LEDR[17:5] = ledr_17_5;
	 wire [17:5] ledr_17_5;
	 
	 assign {Reset_h}=~ (Reset);  // The push buttons are active low
//	 assign OTG_FSPEED = 1'bz;
//	 assign OTG_LSPEED = 1'bz;
	    
	
    vga_controller vgasync_instance(.*,
	                                 .Clk(Clk),
											   .Reset(Reset_h),
											   .pixel_clk(VGA_clk),
											   .DrawX(drawxsig),
								 			   .DrawY(drawysig) );
   
//    ball ball_instance(.keycode(keycode),
//							  .Reset(Reset_h),
//	                    .frame_clk(vs),    // Vertical Sync used as an "ad hoc" 60 Hz clock signal
//	                    .BallX(ballxsig),  // (This is why we registered it in the vga controller!)
//							  .BallY(ballysig),
//							  .BallS(ballsizesig));
//   
    color_mapper color_instance(.*,
	                             .BallX(ballxsig),
		 								  .BallY(ballysig),
		 								  .DrawX(drawxsig),
		 								  .DrawY(drawysig),
										  .Ball_size(ballsizesig),
										  .KEY3(~KEY3),
										  .KEY2(~KEY2));
	
	wire [31:0] hex_disp_wire;
										  
	 HexDriver hex_inst_7 (hex_disp_wire[31:28], HEX7);
	 HexDriver hex_inst_6 (hex_disp_wire[27:24], HEX6);

	 HexDriver hex_inst_5 (hex_disp_wire[23:20], HEX5);
	 HexDriver hex_inst_4 (hex_disp_wire[19:16], HEX4);

	 HexDriver hex_inst_3 (hex_disp_wire[15:12], HEX3);
	 HexDriver hex_inst_2 (hex_disp_wire[11:8], HEX2);
	 
	 HexDriver hex_inst_1 (hex_disp_wire[7:4], HEX1);
	 HexDriver hex_inst_0 (hex_disp_wire[3:0], HEX0);
    

	 /**************************************************************************************
	    ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
		 Hidden Question #1/2:
          What are the advantages and/or disadvantages of using a USB interface over PS/2 interface to
			 connect to the keyboard? List any two.  Give an answer in your Post-Lab.
     **************************************************************************************/
endmodule
