`timescale 1ns / 100ps
`ifndef CEIL_MACRO
`define CEIL_MACRO
`define Ceil(ParamName,
             Expression) \
 parameter ParamName``_F = Expression;\
 parameter integer ParamName``_R = ParamName``_F;\
 parameter integer ParamName = (ParamName``_R == ParamName``_F || ParamName``_R > ParamName``_F) ? ParamName``_R : (ParamName``_R + 1);
`endif
module cfar_algorithm (
    detect_if if_
);

  `Ceil(AVG_WIDTH, if_.INPUT_WIDTH - 1 + $clog2(REF_WIN))
  //////////////////////////////////////////////////
  int alpha = 21.9;
  localparam REF_WIN = 16, GUARD_WIN = 2, P_FA = 0.000001;
  logic [if_.INPUT_WIDTH-1:0] slide_win[0:REF_WIN+GUARD_WIN];
  logic [AVG_WIDTH-1:0] avg_right, avg_left;
  logic [if_.INPUT_WIDTH-1:0] max_val, threshold_cfar, x;
  reg [9:0] cnt, max_peak_index;
  bit flag, en;
  /////////////////////////////////////////////////
  assign if_.index_out = (en == 1'b1) ? max_peak_index - ((REF_WIN + GUARD_WIN) / 2) : 'b0;
  assign if_.max_value = (en == 1'b1) ? max_val : 'b0;
  assign if_.max_valid = en;
  assign x = slide_win[(REF_WIN+GUARD_WIN)/2];
  /////////////////////////////////////////////////
  /*    combinatianal block to calc threshold    */
  /////////////////////////////////////////////////


  always_comb begin
    avg_right = 0;
    avg_left  = 0;
    for (int i = 0; i < REF_WIN / 2; i++) begin
      avg_right += slide_win[REF_WIN+GUARD_WIN-i];
      avg_left += slide_win[i];
    end
    if (avg_left <= avg_right) begin
      threshold_cfar = (avg_left >> $clog2(REF_WIN / 2)) * alpha;
    end else begin
      threshold_cfar = (avg_right >> $clog2(REF_WIN / 2)) * alpha;
    end
  end

  //////////////////////////////////////////////////////////////////
  /*sequential block to calc peaks according to the cfar_threshold*/
  //////////////////////////////////////////////////////////////////
  always_ff @(posedge if_.clk or negedge if_.reset_n) begin
    if (!if_.reset_n) begin
      for (int i = 0; i <= REF_WIN + GUARD_WIN; i++) slide_win[i] <= 'b0;
      cnt <= 'b0;
      max_val <= 'b0;
      flag <= 1'b0;
      en <= 'b0;
      max_peak_index <= 0;
    end else begin
      en   <= 'b0;
      flag <= 'b0;
      if (en == 'b1) max_val <= 'b0;
      if (if_.input_valid == 'b1 && cnt != (512 + (REF_WIN + GUARD_WIN) / 2 + 1)) begin
        cnt <= cnt + 1'b1;
        slide_win[1:REF_WIN+GUARD_WIN] <= slide_win[0:REF_WIN+GUARD_WIN-1];
        slide_win[0] <= if_.power_in;
        if (cnt > REF_WIN + GUARD_WIN / 2 + 1) begin
          if (slide_win[(REF_WIN+GUARD_WIN)/2] >= threshold_cfar) begin
            if (max_val < slide_win[(REF_WIN+GUARD_WIN)/2])
              max_val <= slide_win[(REF_WIN+GUARD_WIN)/2];
            flag <= 1;
            max_peak_index <= cnt;
          end else if (flag == 'b1) begin
            en   <= 'b1;
            flag <= 0;
          end
        end
      end
    end
  end

endmodule
