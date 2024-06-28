`timescale 1ns / 100ps
module cfar_tb (
    detect_if if_
);
  int i = 0;
  logic [if_.INPUT_WIDTH-1:0] data_in[2**10];
  task reset();
    if_.reset_n <= 'b0;
    @(if_.cb);
    @(if_.cb);
    if_.reset_n <= 'b1;
    @(if_.cb);
    @(if_.cb);
  endtask
  task initialization();
    $dumpvars;
    $dumpfile("data.vcd");
    if_.cb.index_in    <= 'b0;
    if_.cb.power_in    <= 'b0;
    if_.cb.reverse     <= 'b0;
    if_.cb.input_valid <= 'b0;
    if_.cb.eop_in      <= 'b0;
    if_.reset_n        <= 'b1;
  endtask
  task read_data();
    integer file;
    file = $fopen("C:/Users/moham/Desktop/matlab_trial/cfar_tb.txt",
                  "r");  // Open the file for reading
    if (file != 0) begin
      for (int i = 0; i < 1024; i++) begin
        $fscanf(file, "%d", data_in[i]);  // Read a line from the file
      end
      $fclose(file);  // Close the file
    end else begin
      $display("Error opening file.");
    end
  endtask
  task capture_peaks();
    int f_handle;
    f_handle = $fopen("C:/Users/moham/Desktop/matlab_trial/new/cfar_for_matlab.txt", "w");
    forever begin
      @(posedge if_.cb.max_valid)
        if (f_handle != 0) begin
          $fwrite(f_handle, "%d\n", if_.cb.index_out);
        end else begin
          $display("Error opening file for writing.");
        end
    end
  endtask
  task entering_data();
    if_.cb.input_valid <= 'b1;
    if_.cb.power_in <= data_in[0];
    @(if_.cb);
    for (int i = 1; i < 2 ** 10; i++) begin
      if_.cb.power_in <= data_in[i];
      @(if_.cb);
    end
    repeat (15) @(if_.cb);
    $stop;
  endtask
  initial begin
    read_data();
    initialization();
    reset();
    fork
      begin
        entering_data();
      end
      begin
        capture_peaks();
      end
    join
  end
endmodule
