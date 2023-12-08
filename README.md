# Fall2023-Adv-Verilog
This is a repository for all of the labs and midterms done in ECE 4305 Digital Design using Advanced Verilog from Fall 2023.

# Lab 1 - Barrel Shifter 
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


# Lab 2 - Square Wave Generator

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



# Lab 3 - Early Debouncer
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



# Lab 4 - ROM Temperature Converter
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



# Midterm 1 - FIFO using BRAM
Use 2 BRAM modules to implement a 4096x4 memory array using 1024x4 arrays that can read/write into/from a FIFO. The Seven Segment Displays must display the memory location and value of the FIFO. Use switches and buttons to implement read/write functionality.

[Midterm 1 Files](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Midterms/Midterm%201)

### Block Diagram
![image](https://github.com/Fall-2023-Classes/fa23-midterm-exam-1-ishwo0/assets/112601782/e99eab3e-4ae1-4b09-85ce-5eae441930e0)
![image](https://github.com/Fall-2023-Classes/fa23-midterm-exam-1-ishwo0/assets/112601782/5a4843dc-0c8b-48b9-a667-3e12b122f282)

### All Edited or New Files:
- [mem_block](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Midterms/Midterm%201/RTL%20Files/mem_block.sv)
- [ram_1port](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Midterms/Midterm%201/RTL%20Files/ram_1port.sv)
- [decoder_2x4](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Midterms/Midterm%201/RTL%20Files/decoder_2x4.sv)
- [mux_4x1](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Midterms/Midterm%201/RTL%20Files/mux_4x1.sv)


# Lab 5 - Asymmetric Fifo Buffer
Create a Fifo Buffer that has different bit lengths for the data going in and the data coming out.

[Lab 5 Files](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%205)

### Asymmetric Fifo Buffer

The point of this lab is to create a Fifo Buffer that has two times the number bits for the write data, *w_data*, than the read data, *r_data*. This design is an [Asymmetric Fifo Buffer](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%205/RTL%20Files/fifo.sv), and in our case, we designed the write data to be 16-bits while the read data is 8-bits.

  - [Asymmetric Fifo Buffer](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%205/RTL%20Files/fifo.sv)
    - [Fifo Control Module](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%205/RTL%20Files/fifo_ctrl.sv)
    - [2 Port RAM Register Module](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%205/RTL%20Files/ram_2port.sv)
    - [Asymmetric Fifo Buffer Test Bench Simulation file](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%205/Test%20Bench%20Simulation%20Files/fifo_TB.sv)


# Lab 6 - Chasing LEDs
Write C++ code to program the [Vanilla SoC](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%206-7%20System) with a Chasing LED function that uses switches as speeds.

[Lab 6 Files](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%206)

[Vanilla SoC HDL Files](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%206-7%20System/HDL)

[Vanilla SoC Driver Files](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%206-7%20System/Drivers)

### Main Application File

The point of this lab is to create an SoC on our FPGA board with a Chasing LED program for testing. This program is coded in C++ and loaded onto the hardware through Vitis. The Chasing LED program uses switches to set a specific speed for the bouncing LED effect on the board. Using the infinite while loop inside the main() function to call a simple jumping LED function created outside, we can create the bouncing LED effect without separate loops outside, thus allowing the user to reset the effect no matter where the lit LED currently is.

  - [main.cpp](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%206/Main%20Application%20File)


# Lab 7 - Blinking LEDs
Write HDL and a driver for a new blinking core and implement it into the [SoC from Lab 6](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%206-7%20System) in a new slot within the MMIO Core.

[Lab 7 Files](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%207)

[New HDL Files](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%207/Added%20HDL)

[New Driver Files](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%207/Added%20Drivers)

### Chu_Blinker

The point of this lab is to learn how to implement our own core in a slot within the MMIO core, as well as writing our own C++ Driver to add functionality to the core. The core we are building is a simple blinking led core.
This [Blinking LED Core](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%207/Added%20HDL/RTL%20Files/chu_blinker.sv) takes the write data from the processor and uses it as a blinking rate to be displayed on an LED of choice (in this case one of the first 4 on the board). Paired with a [C++ Driver](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%207/Added%20Drivers) for this core,
the user can set any of the first four LEDs to blink at a desired rate.

  - [chu_blinker](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%207/Added%20HDL/RTL%20Files/chu_blinker.sv)
    - [four_blinkers](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%207/Added%20HDL/RTL%20Files/four_blinkers.sv)
      - [blinker](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%207/Added%20HDL/RTL%20Files/blinker.sv)
        - [modulus counter](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%207/Added%20HDL/RTL%20Files/modulus_counter.sv)
        - [t-ff](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%207/Added%20HDL/RTL%20Files/t_ff.sv)
      - [blinker_TB](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%207/Added%20HDL/Test%20Bench%20Simulation%20Files/blinker_tb.sv)
  - [chu_blinker_TB](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%207/Added%20HDL/Test%20Bench%20Simulation%20Files/chu_blinker_TB.sv)
  - [blinker_cores.h](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%207/Added%20Drivers/blinker_cores.h)
  - [blinker_cores.cpp](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%207/Added%20Drivers/blinker_cores.cpp)


# Lab 8 - Potentiometer Controlled Chasing LEDs
Using a new [Sampler FPro SoC](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%208-11%20System), write a C++ function to implement a potentiometer, utilizing the [XADC core and driver](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%208-11%20System/Drivers/xadc_core.h), to the [Chasing LED function from Lab 6](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%206).

[Lab 8 Files](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%208)

[Sampler FPro HDL Files](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%208-11%20System/HDL)

[Sampler FPro Driver Files](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%208-11%20System/Drivers)

### Main Application File

The point of this lab is to implement the [XADC module](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%208-11%20System/Drivers/xadc_core.h) into our [Chasing LED function from Lab 6](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%206). The XADC will be reading the value from a potentiometer, which will be used as the new speed for our chasing LED function, whereas the switches were previously used for the speed. The XADC Driver functions allows us to read the raw voltage input from the ADC channel that the potentiometer is connected to. This raw voltage is then mapped to a certain range that will
be used as the speed value for the Chasing LED function.

  - [main_sampler](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%208/Main%20Application%20File/main_sampler_test.cpp)


# Lab 9 - Spectrum Display
Using the same Sampler FPro SoC introduced in Lab 8, write a function using the potentiometer value from [Lab 8](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%208) to display a color spectrum on the RGB LEDs.

[Lab 9 Files](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%209)

[Sampler FPro HDL Files](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%208-11%20System/HDL)

[Sampler FPro Driver Files](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%208-11%20System/Drivers)

### Main Application File

The point of this lab is to use the [XADC potentiometer value from Lab 8](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%208/Main%20Application%20File/main_sampler_test.cpp) to display a spectrum of colors on the RGB LEDs instead of using it to determine the speed of the Chasing LED function. The raw voltage value from the potentiometer is now mapped to a range from
0-1 which is then used as the duty cycle for the appropriate color channel of the PWM Driver and Core. A spectrum(...) function is created to split the raw adc voltage value into 6 segments, each with a different color channel (either R, G, or B) being varied from 
either 0-1 or 1-0. This will create the spectrum shown below.

![image](https://github.com/ishwo0/Fall2023-Adv-Verilog/assets/112601782/0fec90e0-439f-4708-8a28-e68c7e44806c)

  - [main_sampler](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%209/Main%20Application%20File/main_sampler_test.cpp)


# Lab 10 - Tapping Detection
Using the same [Sampler FPro SoC](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%208-11%20System) introduced in Lab 8, write a function that utilizes the [SPI core and drivers](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%208-11%20System/Drivers/spi_core.h) to detect different tapping intensities through the accelerometer on the Nexys board.

[Lab 10 Files](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%2010)

[Sampler FPro HDL Files](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%208-11%20System/HDL)

[Sampler FPro Driver Files](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%208-11%20System/Drivers)

### Main Application File
The point of this lab is to use the [Sampler FPro SoC](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%208-11%20System)'s [SPI core and its driver](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%208-11%20System/Drivers/spi_core.h) to implement the on-board accelerometer on the Nexys A7. This accelerometer will  produce three values, one for the X-axis, one for the Y-axis, and one for the Z-axis. We take these values using one of the functions in the SPI Driver and use them to calculate the magnitude of the movement as a single value. We then take this magnitude and use it in a clever way to determine each positive spike in magnitude. That spike is then visualized on the LEDs, in which a range of LEDS 0-16 will turn on depending on how small or large the spike is.

  - [main_sampler](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%2010/Main%20Application%20File/main_sampler_test.cpp)


# Midterm 2 - PMOD CMPS2 COMPASS 
Buy Digilent PMOD CMPS2 Compass and make it work.

Using the Sampler FPro SoC, implement the Digilent PMOD CMPS2 Compass by creating a program that displays a green color on the RGB LED when facing NORTH, and a red color otherwise. The CMPS2 uses the I2C protocol, thus the [I2C core and driver](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%208-11%20System/Drivers/i2c_core.h) are used in this Midterm. Read and Writes are performed according to the CMPS2 documentation. [This Arduino code was used as a guide](https://create.arduino.cc/editor/almos_vv/18b671a2-cf30-44c7-b141-f1a55a92bd7a/preview)


### HDL
- [HDL](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Midterms/Midterm%202/HDL)

### Drivers and Application
- [Drivers](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Midterms/Midterm%202/Drivers)
- [main_application](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Midterms/Midterm%202/Main%20Application%20File/main_sampler_test.cpp)


# Lab 11 - Keyboard/Mouse Controlled Chasing LED
Using the [Sampler FPro SoC](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%208-11%20System) introduced in Lab 8, utilize the [PS2 core and driver](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%208-11%20System/Drivers/ps2_core.h) to implement a USB mouse or keyboard that can control the Chasing LED function from [Lab 6](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%206) 

[Lab 11 Files](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%2011)

[Sampler FPro HDL Files](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%208-11%20System/HDL)

[Sampler FPro Driver Files](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%208-11%20System/Drivers)

### Main File
The point of this lab is to use the [Sampler FPro SoC](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%208-11%20System)'s [PS2 core and its driver](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%208-11%20System/Drivers/ps2_core.h) to implement a USB keyboard or USB mouse. This lab will implement the USB keyboard by taking the keyboard inputs and using them to control the [Chasing LED function from Lab 6](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%206/Main%20Application%20File). The PS2 driver functions will read the keyboard inputs. If the 'P' key was pressed, the Chasing LED function will pause in place (leaving the LED of its current position ON) or unpause. If the 'F1' key was pressed, the following set of 3 consecutive number inputs from the keyboard will become the new speed of the Chasing LED function. This is done through a series of input comparisons validations using multiple if() statements.

  - [main_sampler](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%2011/Main%20Application%20File/main_sampler_test.cpp)


# Lab 12 - Square pattern generator VGA
Strictly in hardware, implement a VGA output that generates squares with 4-bit RGB colors based on the first 12 switches, and sizes 16, 32, 64, and 128 based on the last four switches.

[Lab 12 Files](https://github.com/ishwo0/Fall2023-Adv-Verilog/tree/main/Labs/Lab%2012)

### VGA Sync

The point of this lab is to create hardware that uses all 16 switches on the Nexys board to control the display on a VGA monitor. The display will be squares with different sizes based
on the last four switches on the board, while the first 12 switches will control the 4-bit RGB color of the square. The background of the square will always be the complementary color of the square.

  - [VGA Sync](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%2012/RTL%20Files/vga_sync_demo.sv)
    - [Frame Counter](https://github.com/ishwo0/Fall2023-Adv-Verilog/blob/main/Labs/Lab%2012/RTL%20Files/frame_counter.sv)


