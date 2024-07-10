load_package flow
project_new -overwrite dummy_top_FIL_fil
set_global_assignment -name FAMILY  {Cyclone V}
set_global_assignment -name DEVICE  {5CSEMA5F31C6}
set_global_assignment -name CYCLONEII_OPTIMIZATION_TECHNIQUE SPEED
set_global_assignment -name VERILOG_FILE C:/Users/moham/Downloads/cfar/RTL_SV/dummy_top_FIL.sv
source C:/Users/moham/Downloads/cfar/RTL_SV/for_fpga_in_the_loop.qsf
set_global_assignment -name USE_TIMEQUEST_TIMING_ANALYZER ON
set_global_assignment -name VHDL_FILE C:/Users/moham/Downloads/cfar/FIL/filsrc/MWClkMgr.vhd
set_global_assignment -name VHDL_FILE C:/Users/moham/Downloads/cfar/FIL/filsrc/MWAJTAG.vhd
set_global_assignment -name VHDL_FILE C:/Users/moham/Downloads/cfar/FIL/filsrc/MWDPRAM.vhd
set_global_assignment -name VHDL_FILE C:/Users/moham/Downloads/cfar/FIL/filsrc/FILUDPCRC.vhd
set_global_assignment -name VHDL_FILE C:/Users/moham/Downloads/cfar/FIL/filsrc/FILPktMUX.vhd
set_global_assignment -name VHDL_FILE C:/Users/moham/Downloads/cfar/FIL/filsrc/FILCmdProc.vhd
set_global_assignment -name VHDL_FILE C:/Users/moham/Downloads/cfar/FIL/filsrc/MWAsyncFIFO.vhd
set_global_assignment -name VHDL_FILE C:/Users/moham/Downloads/cfar/FIL/filsrc/FILDataProc.vhd
set_global_assignment -name VHDL_FILE C:/Users/moham/Downloads/cfar/FIL/filsrc/MWPKTBuffer.vhd
set_global_assignment -name VHDL_FILE C:/Users/moham/Downloads/cfar/FIL/filsrc/MWUDPPKTBuilder.vhd
set_global_assignment -name VHDL_FILE C:/Users/moham/Downloads/cfar/FIL/filsrc/FILPktProc.vhd
set_global_assignment -name VHDL_FILE C:/Users/moham/Downloads/cfar/FIL/filsrc/FILCommLayer.vhd
set_global_assignment -name VHDL_FILE C:/Users/moham/Downloads/cfar/FIL/filsrc/mwfil_dpscram.vhd
set_global_assignment -name VHDL_FILE C:/Users/moham/Downloads/cfar/FIL/filsrc/mwfil_udfifo.vhd
set_global_assignment -name VHDL_FILE C:/Users/moham/Downloads/cfar/FIL/filsrc/mwfil_bus2dut.vhd
set_global_assignment -name VHDL_FILE C:/Users/moham/Downloads/cfar/FIL/filsrc/mwfil_chifcore.vhd
set_global_assignment -name VHDL_FILE C:/Users/moham/Downloads/cfar/FIL/filsrc/mwfil_controller.vhd
set_global_assignment -name VHDL_FILE C:/Users/moham/Downloads/cfar/FIL/filsrc/mwfil_dut2bus.vhd
set_global_assignment -name VERILOG_FILE C:/Users/moham/Downloads/cfar/FIL/filsrc/dummy_top_FIL_wrapper.v
set_global_assignment -name VHDL_FILE C:/Users/moham/Downloads/cfar/FIL/filsrc/mwfil_chiftop.vhd
set_global_assignment -name VHDL_FILE C:/Users/moham/Downloads/cfar/FIL/filsrc/FILCore.vhd
set_global_assignment -name VHDL_FILE C:/Users/moham/Downloads/cfar/FIL/filsrc/dummy_top_FIL_fil.vhd
source C:/Users/moham/Downloads/cfar/FIL/filsrc/dummy_top_FIL_fil.qsf
set_global_assignment -name SDC_FILE C:/Users/moham/Downloads/cfar/FIL/filsrc/dummy_top_FIL_fil.sdc
set_global_assignment -name USE_TIMEQUEST_TIMING_ANALYZER ON
set_global_assignment -name TOP_LEVEL_ENTITY dummy_top_FIL_fil
execute_flow -analysis_and_elaboration
project_close
