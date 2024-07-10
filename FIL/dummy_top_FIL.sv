`timescale 1ns / 1ps
module dummy_top_FIL #(
    parameter POINT_LENGTH = 512,
    INPUT_WIDTH = 29,
    INDEX_WIDTH = 9
) (

    input [28:0] power_in,
    input reset_n,
    clk,
    input_valid,
    output [8:0] index_out,
    output [28:0] max_value,
    output max_valid

);

  detect_if inst_interface_detect_if (.clk(clk));
  assign inst_interface_detect_if.power_in = power_in;
  assign inst_interface_detect_if.reset_n = reset_n;
  assign inst_interface_detect_if.input_valid = input_valid;
  assign index_out = inst_interface_detect_if.index_out;
  assign max_value = inst_interface_detect_if.max_value;
  assign max_valid = inst_interface_detect_if.max_valid;

  /******************************************/
  /*  instantiate mudule and the interface  */
  /******************************************/
  cfar_algorithm inst_cfar_algorithm (inst_interface_detect_if.dut);
endmodule
