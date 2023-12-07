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



# Lab 3

# Lab 4

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
