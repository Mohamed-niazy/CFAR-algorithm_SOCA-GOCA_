`timescale 1ns / 1ps
module top ();
  /***********************/
  /*declere clock signal*/
  /***********************/
  bit clk;


  /******************************************/
  /*generate clock signal  with period 10ns */
  /******************************************/

  always #5 clk = ~clk;
  /******************************************/
  /*  instantiate mudule and the interface  */
  /******************************************/

  detect_if inst_interface_detect_if (clk);
  cfar_algorithm inst_cfar_algorithm (inst_interface_detect_if.dut);
  cfar_tb inst_cfar_tb (inst_interface_detect_if.tb);
endmodule
