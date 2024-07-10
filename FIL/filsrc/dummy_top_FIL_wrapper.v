
/*-- ----------------------------------------------
-- File Name: dummy_top_FIL_wrapper.v
-- Created:   10-Jul-2024 11:33:06
-- Copyright  2024 MathWorks, Inc.
-- ----------------------------------------------*/

module dummy_top_FIL_wrapper (
      clk,
      enb,
      reset,
      din,
      dout
);


      input     clk;
      input     enb;
      input     reset;
      input    [39 : 0] din;
      output   [55 : 0] dout;

  wire dut_reset; // boolean
  wire dutclk; // boolean
  wire[28 : 0] power_in; // std29
  wire[28 : 0] power_in_tmp; // std29
  wire input_valid; // boolean
  wire input_valid_tmp; // boolean
  wire[8 : 0] index_out; // std9
  wire[8 : 0] index_out_tmp; // std9
  wire[6 : 0] zero0; // std7
  wire[28 : 0] max_value; // std29
  wire[28 : 0] max_value_tmp; // std29
  wire[2 : 0] zero1; // std3
  wire max_valid; // boolean
  wire max_valid_tmp; // boolean
  wire[6 : 0] zero2; // std7
  wire[55 : 0] tmpconcat; // std56
dummy_top_FIL u_dummy_top_FIL (
        .input_valid          (input_valid),
        .clk                  (dutclk),
        .max_value            (max_value),
        .power_in             (power_in),
        .index_out            (index_out),
        .max_valid            (max_valid),
        .reset_n              (dut_reset)
);

assign dut_reset =  ~ reset;
assign dutclk =  ~ enb;
assign power_in = power_in_tmp;
assign power_in_tmp = din[28 : 0];
assign input_valid = input_valid_tmp;

assign input_valid_tmp = din[32];
assign index_out_tmp = index_out;
assign index_out_tmp = index_out;
assign zero0 = 7'b0000000;
assign max_value_tmp = max_value;
assign max_value_tmp = max_value;
assign zero1 = 3'b000;
assign max_valid_tmp = max_valid;

assign max_valid_tmp = max_valid;

assign zero2 = 7'b0000000;
assign dout = {zero2,max_valid_tmp,zero1,max_value_tmp,zero0,index_out_tmp};

endmodule
