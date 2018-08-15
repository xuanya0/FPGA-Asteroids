//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input        [9:0] BallX, BallY, DrawX, DrawY, Ball_size,
							input Reset_h, Clk,w,a,s,d,j,kpu,kpd,kpl,kpr,kpen,vs,hs,//50Mhz
                       output logic [7:0]  Red, Green, Blue,
							  output wire [31:0] hex_disp_wire,
							  input logic  KEY3,KEY2,
							  output wire [17:5] ledr_17_5
					 );
    
    logic ship_on, rock_on;




wire [4:0] col,row;
logic [4:0] angle;
wire [7:0] ship_r, ship_g, ship_b;
wire T_out;
wire [9:0] ship_x, ship_y;
wire [13:0] x_val,y_val;
wire [2:0] speed;
assign hex_disp_wire = {1'b0,speed,2'b00,ship_y,j_counter,2'b00,ship_x};
	


ang_status ang0(.*);

//--------------commment out this module to speed up compilation for debugging
spaceship ss_graph(.*, .col(DrawX-ship_x+16),
					.row(DrawY-ship_y+16),
					.R_out(ship_r),
					.G_out(ship_g),
					.B_out(ship_b)
					); //this is alpha channel 0=no pixel
//-------------comment    end

rock_spawn_delay ship_status_reset_delay(.*, .reset(reset_ship), .withhold_rock(withhold_ship));
wire withhold_ship;

ship_status ss0(.*, .Reset_h(Reset_h || withhold_ship));


    int DistX, DistY, Size;
	 assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
    assign Size = Ball_size;
	  


    always_comb
    begin:ship_on_proc
        if  (T_out==1 &&(DrawX >= ship_x - 16) &&
				(DrawX <= ship_x + 16) &&
				(DrawY >= ship_y - 16) &&
				(DrawY <= ship_y + 16)) 
            
				ship_on = 1'b1;
        else 
            ship_on = 1'b0;
     end 
	  
	 
//rock-----------------------
wire [9:0]	  rock_x, rock_y;
wire [7:0]   rock_r, rock_g, rock_b;
wire 		  rock_t;

wire [9:0]	  rock_x_1, rock_y_1;
wire [9:0]	  rock_x_2, rock_y_2;
wire [9:0]	  rock_x_3, rock_y_3;

hertz_240 hz_0(.*, .reset(Reset_h));
wire hz_240;

hertz_480 hz_1(.*, .reset(Reset_h));
wire hz_480;

Random  rand0(.Clk(hs), .Reset_h(Reset_h) ,.rng(rand_seq));

wire [9:0] rand_seq;  //random sequence

wire [3:0] reset_rocks;
wire reset_ship;
wire hit;

wire [9:0]	  shot_x, shot_y;
wire [9:0]	  shot_x_1, shot_y_1;
wire [9:0]	  shot_x_2, shot_y_2;
wire [9:0]	  shot_x_3, shot_y_3;

game_control gc0(.*);

wire [3:0] withhold_rocks;

rock_spawn_delay rsd0(.*, .reset(reset_rocks[0]), .withhold_rock(withhold_rocks[0]));
rock_spawn_delay rsd1(.*, .reset(reset_rocks[1]), .withhold_rock(withhold_rocks[1]));
rock_spawn_delay rsd2(.*, .reset(reset_rocks[2]), .withhold_rock(withhold_rocks[2]));
rock_spawn_delay rsd3(.*, .reset(reset_rocks[3]), .withhold_rock(withhold_rocks[3]));

						  
						  

rock_status rock_stat0(.in_x(0), .in_y({1'b0,rand_seq[8:0]}),
						     .in_ang(rand_seq[9:5]),
						     .reset(KEY2 || withhold_rocks[0]),.hz_240(hz_240),//hs=31250hz
						     .out_x(rock_x), .out_y(rock_y));	
							  
rock_status rock_stat1(.in_x(0), .in_y({1'b0,rand_seq[8:0]}),
						     .in_ang(rand_seq[8:4]),
						     .reset(KEY2 || withhold_rocks[1]),.hz_240(hz_240),//hs=31250hz
						     .out_x(rock_x_1), .out_y(rock_y_1));	
							  
rock_status rock_stat2(.in_y(0), .in_x({1'b0,rand_seq[8:0]}),
						     .in_ang(rand_seq[7:3]),
						     .reset(KEY2 || withhold_rocks[2]),.hz_240(hz_240),//hs=31250hz
						     .out_x(rock_x_2), .out_y(rock_y_2));	
							  
rock_status rock_stat3(.in_y(0), .in_x({1'b0,rand_seq[8:0]}),
						     .in_ang(rand_seq[6:2]),
						     .reset(KEY2 || withhold_rocks[3]),.hz_240(hz_240),//hs=31250hz
						     .out_x(rock_x_3), .out_y(rock_y_3));		
							  
//----------------shot status	  
shot_status shot_stat0(.in_x(ship_x), .in_y(ship_y),
						     .in_ang(angle),
						     .reset(withhold_shots[0]),.hz_480(hz_480),//hs=31250hz
						     .out_x(shot_x), .out_y(shot_y));	
							  
shot_status shot_stat1(.in_x(ship_x), .in_y(ship_y),
						     .in_ang(angle),
						     .reset(withhold_shots[1]),.hz_480(hz_480),//hs=31250hz
						     .out_x(shot_x_1), .out_y(shot_y_1));	
							  
shot_status shot_stat2(.in_x(ship_x), .in_y(ship_y),
						     .in_ang(angle),
						     .reset(withhold_shots[2]),.hz_480(hz_480),//hs=31250hz
						     .out_x(shot_x_2), .out_y(shot_y_2));	
							  
shot_status shot_stat3(.in_x(ship_x), .in_y(ship_y),
						     .in_ang(angle),
						     .reset(withhold_shots[3]),.hz_480(hz_480),//hs=31250hz
						     .out_x(shot_x_3), .out_y(shot_y_3));		
										  
wire [3:0] reset_shots, withhold_shots, j_counter;
assign ledr_17_5[17:10] = {~withhold_rocks,~withhold_shots}; //led_on = rocks or shots exist
assign ledr_17_5[9] = ~withhold_ship;
assign ledr_17_5[8] = hit;


shot_trigger st0(.*, .reset(Reset_h));
								  

							  
							  
logic rock_exist;
logic [9:0] rock_mux_x,rock_mux_y;
					
always_comb
    begin:rock_on_proc
        if ((DrawX >= rock_x - 32) &&
				(DrawX <= rock_x + 32) &&
				(DrawY >= rock_y - 32) &&
				(DrawY <= rock_y + 32))
				begin rock_mux_x <= rock_x; rock_mux_y <= rock_y; rock_exist <=1; end
				
	else if ((DrawX >= rock_x_1 - 32) &&
				(DrawX <= rock_x_1 + 32) &&
				(DrawY >= rock_y_1 - 32) &&
				(DrawY <= rock_y_1 + 32))
				begin rock_mux_x <= rock_x_1; rock_mux_y <= rock_y_1; rock_exist <=1; end

	else if ((DrawX >= rock_x_2 - 32) &&
				(DrawX <= rock_x_2 + 32) &&
				(DrawY >= rock_y_2 - 32) &&
				(DrawY <= rock_y_2 + 32))
				begin rock_mux_x <= rock_x_2; rock_mux_y <= rock_y_2; rock_exist <=1; end
				
							
	else if ((DrawX >= rock_x_3 - 32) &&
				(DrawX <= rock_x_3 + 32) &&
				(DrawY >= rock_y_3 - 32) &&
				(DrawY <= rock_y_3 + 32)) 
				begin rock_mux_x <= rock_x_3; rock_mux_y <= rock_y_3; rock_exist <=1; end
	
	else    	begin rock_mux_x <= 0; rock_mux_y <= 0; rock_exist <=0; end
	end
	
rock rock0(.row(DrawY-rock_mux_y+32) , .col(DrawX-rock_mux_x+32) , 
					.R_out(rock_r), .G_out(rock_g) , 
					.B_out(rock_b) , .T_out(rock_t)); //this is alpha channel 0=no pixel

//rock-----------------------	  paint

logic shot_exist;

always_comb
    begin:shot_on_proc
        if ((DrawX >= shot_x - 2) &&
				(DrawX <= shot_x + 2) &&
				(DrawY >= shot_y - 2) &&
				(DrawY <= shot_y + 2))
				begin shot_exist <=1; end
				
	else if ((DrawX >= shot_x_1 - 2) &&
				(DrawX <= shot_x_1 + 2) &&
				(DrawY >= shot_y_1 - 2) &&
				(DrawY <= shot_y_1 + 2))
				begin shot_exist <=1; end

	else if ((DrawX >= shot_x_2 - 2) &&
				(DrawX <= shot_x_2 + 2) &&
				(DrawY >= shot_y_2 - 2) &&
				(DrawY <= shot_y_2 + 2))
				begin shot_exist <=1; end
				
							
	else if ((DrawX >= shot_x_3 - 2) &&
				(DrawX <= shot_x_3 + 2) &&
				(DrawY >= shot_y_3 - 2) &&
				(DrawY <= shot_y_3 + 2)) 
				begin shot_exist <=1; end
	
	else    	begin shot_exist <=0; end
	end
	
// shot--------paint
	  

always_comb
    begin:RGB_Display
        if (ship_on == 1) //ship
        begin 
            Red = ship_r;
            Green = ship_g;
            Blue = ship_b;
        end       
        else if ((rock_t==1)&&(rock_exist==1))// rock
		  begin 
            Red = rock_r;
            Green = rock_g;
            Blue = rock_b;
        end  
		  else if (shot_exist==1)// this is shot
		  begin 
            Red = 8'hFF;
            Green = 8'hFF;
            Blue = 8'hFF;
        end  		  
        else // this is background
        begin 
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h7f - DrawX[9:3];
        end      
    end 

endmodule
