## Clock signal
set_property PACKAGE_PIN W5 [get_ports Clk]
	set_property IOSTANDARD LVCMOS33 [get_ports Clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports Clk]

## LEDs
set_property PACKAGE_PIN U16 [get_ports {Reg_7[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Reg_7[0]}]
set_property PACKAGE_PIN E19 [get_ports {Reg_7[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Reg_7[1]}]
set_property PACKAGE_PIN U19 [get_ports {Reg_7[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Reg_7[2]}]
set_property PACKAGE_PIN V19 [get_ports {Reg_7[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Reg_7[3]}]
set_property PACKAGE_PIN P1 [get_ports {Overflow_led}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Overflow_led}]
set_property PACKAGE_PIN L1 [get_ports {Zero_led}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Zero_led}]


##7 segment display
set_property PACKAGE_PIN W7 [get_ports {Seven_seg_out[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Seven_seg_out[0]}]
set_property PACKAGE_PIN W6 [get_ports {Seven_seg_out[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Seven_seg_out[1]}]
set_property PACKAGE_PIN U8 [get_ports {Seven_seg_out[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Seven_seg_out[2]}]
set_property PACKAGE_PIN V8 [get_ports {Seven_seg_out[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {Seven_seg_out[3]}]
set_property PACKAGE_PIN U5 [get_ports {Seven_seg_out[4]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Seven_seg_out[4]}]
set_property PACKAGE_PIN V5 [get_ports {Seven_seg_out[5]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Seven_seg_out[5]}]
set_property PACKAGE_PIN U7 [get_ports {Seven_seg_out[6]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Seven_seg_out[6]}]


##Buttons
set_property PACKAGE_PIN U18 [get_ports Res]
	set_property IOSTANDARD LVCMOS33 [get_ports Res]
