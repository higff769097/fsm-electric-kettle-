module ElectricKettle_tb;

  reg clk;
  reg rst;
  reg start_button;
  reg [7:0] temperature_sensor; // 8-bit wide for a range of 0-255
  reg water_level_sensor;
  wire heater;
  wire indicator;
  wire shutdown;

  // Instantiate the ElectricKettle module
  ElectricKettle electric_kettle (
    .clk(clk),
    .rst(rst),
    .start_button(start_button),
    .temperature_sensor(temperature_sensor),
    .water_level_sensor(water_level_sensor),
    .heater(heater),
    .indicator(indicator),
    .shutdown(shutdown)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  initial begin
    // Initialize signals
    clk = 0;
    rst = 0;
    start_button = 0;
    temperature_sensor = 8'h00; // Initialize with 8-bit 0
    water_level_sensor = 1; // Start with water level 1

    // Reset the kettle
    rst = 1;
    #10 rst = 0;

    // Randomized test cases
    repeat (10) begin
      // Randomize inputs
      start_button = $urandom_range(0, 1);
      water_level_sensor = $urandom_range(0, 1);
      #10 start_button = 0;
      temperature_sensor = $urandom_range(0, 200);
      #10 temperature_sensor = $urandom_range(0, 200);

      // Check if the kettle goes to IDLE state when water level is 0
      if (water_level_sensor == 0 && shutdown != 0) $display("Test failed: Kettle didn't shut down when water level is 0.");

      // Check if the kettle goes to READY state when water level is 1 and start_button is pressed
      if (water_level_sensor == 1 && start_button == 1 && shutdown == 0 && indicator == 1) $display("Test failed: Kettle didn't indicate ready when water level is 1 and start button is pressed.");
    end

    // Finish simulation
    $finish;
  end
endmodule
