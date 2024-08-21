module ElectricKettle(



    input wire clk, // Clock signal



    input wire rst, // Reset signal



    input wire start_button, // Start button



    input wire [7:0] temperature_sensor, // Temperature sensor input



    input wire water_level_sensor, // Water level sensor input



    output wire heater, // Heater control signal



    output wire indicator, // Indicator LED



    output wire shutdown // Safety shutdown signal



);







reg [3:0] state;



parameter IDLE = 4'b0000;



parameter HEATING = 4'b0001;



parameter READY = 4'b0010;



parameter OVERHEAT = 4'b0011;



parameter LOW_WATER = 4'b0100;



parameter ma_temperature = 8'd110; // Set your safe temperature limit here



//parameter low_water_limit = 8'd25; // Set the low water level condition






always @(posedge clk or posedge rst) begin



    if (rst) begin



        state <= IDLE;



    end else begin



        case(state)



            IDLE: begin





                if (!start_button && water_level_sensor==1 && temperature_sensor<=ma_temperature) begin



                    state <= READY;



                end

else state <= IDLE;



            end



            READY: begin



                if (start_button) begin



                    state <= HEATING;

                 

                end

else state <= IDLE;

            end



            HEATING: begin



                if (temperature_sensor >= ma_temperature) begin



                    state <= OVERHEAT;



                end else if (water_level_sensor==0) begin



                    state <= LOW_WATER;



                end

                else if (temperature_sensor >= ma_temperature && water_level_sensor==0)begin

               

                state <= IDLE;

                end



            end



            OVERHEAT: begin

           

           

            state<=IDLE;

           

            end



            LOW_WATER: begin



            state <= IDLE;

            end




        endcase

    end
end
assign heater = (state == HEATING) ? 1'b1 : 1'b0;
assign indicator = (state == READY) ? 1'b1 : 1'b0;
assign shutdown = (state == OVERHEAT || state == LOW_WATER) ? 1'b1 : 1'b0;
endmodule
