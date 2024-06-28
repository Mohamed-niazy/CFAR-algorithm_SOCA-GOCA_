`timescale 1ns / 1ps
interface detect_if #(
    parameter POINT_LENGTH = 512,
    INPUT_WIDTH = 29,
    INDEX_WIDTH = 9,
) (
    input logic clk
);
  //*********************************//
  //       Flow control signals     //
  //********************************//
  logic reset_n;
  logic reverse;  //if 0 index is increasing, if 1 index is decreasing
  logic max_valid;
  logic input_valid;
  logic eop_in;
  /**********************************/
  //           Data signals         //
  /**********************************/
  logic [INDEX_WIDTH-1:0] index_in;
  logic [INDEX_WIDTH-1:0] index_out;
  logic [INPUT_WIDTH-1:0] power_in;
  logic [INPUT_WIDTH-1:0] max_value;


  /**********************************/
  //           Clocking             //
  /**********************************/
`ifndef SYN
  clocking cb @(posedge clk);
    default input #0 output #0;
    output index_in, power_in, reverse, input_valid, eop_in;
    input max_value, index_out, max_valid;

  endclocking

  /**********************************/
  //           Modports             //
  /**********************************/

  modport tb(clocking cb,
      output reverse, reset_n,
      input max_valid, index_out, max_value  //clocking block can be ignored and replaced with io signals directly
  );
`endif

  modport dut(
      input index_in, power_in, reverse, reset_n, clk, input_valid, eop_in,
      output index_out, max_value, max_valid
  );


endinterface
