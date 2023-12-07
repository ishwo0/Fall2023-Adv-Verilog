# Fall2023-Adv-Verilog
This is a repository for all of the labs and midterms done in ECE 4305 Digital Design using Advanced Verilog from Fall 2023.

# Lab1_Barrel_Shifter 
[Lab1 Files](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%201)
### Right_Shifter
![param_right_shifter](https://github.com/ishwo0/block_diagrams/assets/112601782/be8e568a-460e-43ac-81a8-301f95402b26)

Parameterized Right Barrel Shifter that takes a parameter *N* to specify the *N* number of bits used for shifting and *2<sup>N</sup>* bits for the input width.
- [Parameterized Right Barrel Shifter Code File](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%201/RTL%20Files/param_right_shifter.sv)
  - [Testbench Simulation file for Right Barrel Shifter](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%201/Test%20Bench%20Simulation%20Files/param_right_shifter_TB.sv)
### Left_Shifter
![param_left_shifter](https://github.com/ishwo0/block_diagrams/assets/112601782/37aa9778-0dcd-4811-a128-a09b475caaea)

Parameterized Left Barrel Shifter that takes a parameter *N* to specify the *N* number of bits used for shifting and *2<sup>N</sup>* bits for the input width.
- [Parameterized Left Barrel Shifter Code File](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%201/RTL%20Files/param_left_shifter.sv)
  - [Testbench Simulation file for Left Barrel Shifter](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%201/Test%20Bench%20Simulation%20Files/param_left_shifter_TB.sv)
### Multip_Shifter
![multi_barrel_shifter_mux](https://github.com/ishwo0/block_diagrams/assets/112601782/3ff7849c-8fa3-4975-9ff9-38dac66d020b)
![multi_barrel_shifter_reverser](https://github.com/ishwo0/block_diagrams/assets/112601782/41a66209-534c-4c37-8ccb-e2db9d5cef13)

Parameterized Left or Right Barrel Shifter with the same parameters *N*, but includes a 1-bit control signal to select Left Shifting or Right Shifting. Implemented two ways - 2x1 Mux to select left/right shifting and reverser circuit + right shifter only.
- [Using Right and Left Shifter with MUX](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%201/RTL%20Files/multi_barrel_shifter_mux.sv)
  - [Testbench Simulation file for Left/Right Shifter using 2x1 MUX](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%201/Test%20Bench%20Simulation%20Files/multi_barrel_shifter_mux_TB.sv)
  - [2x1 MUX file](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%201/RTL%20Files/mux_2x1.sv)
- [Using Right Shifter only with Reverser Circuit](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%201/RTL%20Files/multi_barrel_shifter_reverser.sv)
  - [Testbench Simulation file for Left/Right Shifter using Reverser Circuit](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%201/Test%20Bench%20Simulation%20Files/multi_barrel_shifter_reverser_TB.sv)
  - [Reverser Circuit file](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%201/RTL%20Files/reverser.sv) and [Testbench](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%201/Test%20Bench%20Simulation%20Files/reverser_TB.sv)


# Lab2_Square_Wave_Generator

[Lab 2 Files](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%202)

### TOP MODULE
![image](https://github.com/Fall-2023-Classes/lab-2-square-wave-generator/assets/47878471/79b2eb9c-759e-43ed-8e19-badd923aa0d9)

Design for a square wave generator with variable *ON* and *OFF* durations depending on 4-bit inputs *m* and *n* respectively. Durations are in intervals of 100ns for both *ON* and *OFF*. The top module includes a [2x1 multiplexer](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%202/RTL%20Files/mux_2x1.sv) to select between inputs *m* and *n* inputs using the output *signal*. The output of the MUX is then multiplied by **'d10** before being fed into the [modulus counter](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%202/RTL%20Files/modulus_counter.sv) as an input. The Modulus Counter then counts up to the input value and outputs a **Max_Tick** pulse signal to the input of the [T-Flip Flop](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%202/RTL%20Files/t_ff.sv). The resulting output of the T-Flip Flop is our generated square wave with custom durations for *ON* and *OFF* times.
  - [TOP Module File](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%202/RTL%20Files/top.sv)
    - [TOP Module Test Bench Simulation File](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%202/Test%20Bench%20Simulation%20Files/top_TB.sv)
  - [2x1 MUX file](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%202/RTL%20Files/mux_2x1.sv)
  - [Modulus 8-bit Counter File](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%202/RTL%20Files/modulus_counter.sv)
  - [T-Flip Flop](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%202/RTL%20Files/t_ff.sv)

    
### 2x1 MUX Module
Basic parameterized 2 to 1 multiplexer (in this case: two 4-bit inputs, one 4-bit output).
  - [2x1 MUX file](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%202/RTL%20Files/mux_2x1.sv)

### Modulus Counter Module
Modulus counter that increments by 1 every positive edge of the clock with a max count of any 8-bit input.
  - [Modulus 8-bit Counter](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%202/RTL%20Files/modulus_counter.sv)
    
### T-Flip Flop Module
Basic T-Flip Flop to toggle the square wave signal based on our counter output (Max_Tick).
  - [T-Flip Flop](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%202/RTL%20Files/t_ff.sv)



# Lab_3_Early_Debouncer
Since mechanical inputs are not perfect, bouncing of the input signal can occur. This unstable input can create issues if not accounted for, thus, a debouncer can be implemented to deal with bouncing inputs. In this lab, we develop an early debouncer circuit to ensure the stability of our inputs for at least 20ms.

[Lab 3 Files](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%203)

### Early Debouncer
![Early Detection Debouncer State Diagram](https://github.com/Fall-2023-Classes/lab-2-square-wave-generator/assets/112601782/96e25a3b-244e-462a-a34b-0094f033d6bc)
![Early Detection Debouncer ASM Chart](https://github.com/Fall-2023-Classes/lab-2-square-wave-generator/assets/112601782/89f85d5f-a5cb-4d2f-91ff-f788fd509b99)

Our [Early Debouncer](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%203/RTL%20Files/early_debouncer.sv) Circuit is a moore finite state machine with 8 total states. The inputs to be read in our FSM are the *sw* and the *m_tick* which can be seen in both the State Diagram/ASM Chart and the early_debouncer module. In an early debouncer, the very first edge of the input that is detected is held for a minimum of 20ms before checking the input again. This ensures that our input signal is stable for at least 20ms, preventing potential errors that come from an unstable, bouncing input. To obtain a stable signal for at least 20ms, we use three basic [modulus counters](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%203/RTL%20Files/mod_counter.sv) that generates a *max_tick* (*m_tick*) at exactly 10ms each. Since a counter/timer uses a clock, it is always running and always ticking 24/7, meaning our *sw* input can occur at any time between the 0ms-10ms tick rate. Therefore, three modulus counters are used to ensure a stable signal for a minimum of 20ms and a maximum of 30ms.
  - [early_debouncer module file](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%203/RTL%20Files/early_debouncer.sv)
    - [early_debouncer Test Bench Simulation File](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%203/Test%20Bench%20Simulation%20Files/early_debouncer_TB.sv)
  - [modulus_counter file](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%203/RTL%20Files/mod_counter.sv)

    
### Test Circuit
![image](https://github.com/Fall-2023-Classes/lab_3_early_debouncer/assets/112601782/e2d461f6-a24d-457c-bb46-be4bad8568b8)

To test our [early debouncer](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%203/RTL%20Files/early_debouncer.sv), we can implement the test circuit shown above that will count the number of button presses and display it on two sets of [seven segment displays](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%203/RTL%20Files/seven_seg.sv). To visualize the bouncing input and the debounced input, we count two different button inputs - one of them will be debounced and the other will be the raw input signal with no debouncer. As you would expect, the debounced counter will accurately count the amount of button presses, while the non-debounced counter may count multiple times for a single press.

- [Top Module](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%203/RTL%20Files/top.sv)
- [Early Debouncer](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%203/RTL%20Files/early_debouncer.sv)
- [Rising Edge Detector](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%203/RTL%20Files/rising_edge_detect_mealy.sv)
- [Binary Counter (BCD)](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%203/RTL%20Files/binary_counter_bcd.sv)
- [Display module](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%203/RTL%20Files/display.sv)
  - [Seven Segment Decoder](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%203/RTL%20Files/seven_seg.sv)
  - [Seven Segment Digit Controller](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%203/RTL%20Files/seven_seg_control.sv)



# Lab4_ROM_temperature_convrt
Using two 0.5 Block RAMs to store two ROM memories for Celsius and Fahrenheit conversion values. Range from 0 to 100C, 32 to 212F.

[Lab 4 Files](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%204)

### Temperature Converter
![Temperature Converter Block Diagram](https://github.com/Fall-2023-Classes/Lab4_ROM_temperature_convrt/assets/112601782/5bb0a630-e41f-49a8-8996-4fa9c07541b4)

The point of this lab is to minimize the amount of resources used on our FPGA board. An example of this is to force a [ROM module](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%204/Design/ROM.sv) to use the BRAM on the FPGA board instead of using the LUTs. We created a simple [temperature conversion](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%204/Design/temp_conversion.sv) tool that uses ROM to store the values for the conversions, either from Celsius to Fahrenheit or vice versa. In this case, we instantiated two of these [ROM modules](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%204/Design/ROM.sv), each using 0.5 BRAM on the board. By having both conversion values go through a [2x1 multiplexer](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%204/Design/mux_2x1.sv), we can easily switch between converting from Celsius values or from Fahrenheit values. This converted temperature value in binary will go through a [binary to BCD converter](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%204/Design/bin2bcd.v) before going through the [seven-segment controller](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%204/Design/seven_seg_control.sv) and finally outputting on the board.

  - [Temperature Converter TOP file](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%204/Design/temp_conversion.sv)
    - [Temperature Converter TOP Test Bench Simulation File](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%204/Simulation/temp_conversion_TB.sv)
  - [ROM](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%204/Design/ROM.sv)
  - [2x1 MUX](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%204/Design/mux_2x1.sv)
  - [bin2bcd](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%204/Design/bin2bcd.v)
  - [seven seg control](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%204/Design/seven_seg_control.sv)
    - [modulus counter](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%204/Design/mod_counter.sv)
    - [seven_seg_control Test Bench Sim](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%204/Simulation/seven_seg_control_TB.sv)
  - [sevSegDec](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%204/Design/sevSegDec.sv)

    
### ROM

This lab uses a simple Read Only Memory module that is modified in a specific way to force Vivado to use the BRAM on the FPGA board instead of the LUTs. We use two of these modules to store the conversion values for Celsius and Fahrenheit temperatures. The Lookup Tables for these values ([truth_table_celsius.mem](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%204/Design/truth_table_celsius.mem) and [truth_table_fahrenheit.mem](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%204/Design/truth_table_fahrenheit.mem) are manually created using Excel.

- [ROM Module](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%204/Design/ROM.sv)
  - [LUT for Celsius values](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%204/Design/truth_table_celsius.mem)
  - [LUT for Fahrenheit values](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%204/Design/truth_table_fahrenheit.mem)




# Midterm 1

# Lab 5

# Lab 6

# Lab 7

# Lab 8

# Lab 9

# Lab 10

# Midterm 2

# Lab 11

# Lab 12
