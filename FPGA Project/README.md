This is the repository for my FPGA project of Digital Systems Design CPE 487 for the Fall 2021 semester.
The objective of this project is to translate Verilog code from a Music Box project in a [previous semester](https://github.com/jcristobal2391/cpe487F2020/tree/master/FPGA%20Project) into VHDL code. 
The code is based off a project posted on [fpga4fun.com](https://www.fpga4fun.com/MusicBox.html) that uses a Pluto FPGA board, a speaker, and a 1KΩ resistor. I will attempt to implement the DAC Pmod as seen in the DAC Siren lab of the CPE487 course. 

Currently, the code is simply a translation from Verilog to VHDL code. The DAC Pmod speaker will be implemented at a later time due to constraints from the previous code.
The previous code used a direct output to a speaker, which isn't available for the Nexys A7 board.
