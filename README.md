# DISL Semester 3

Verilog HDL lab exercises and a smart parking mini project. Each lab question is kept in its own folder with its design (`.v`) and testbench (`_tb.v`); generated `.vcd` files contain simulation waveforms.

## Repository contents

| Folder | Contents |
| --- | --- |
| [Lab1](./Lab1/) | Example and questions 1-2 |
| [Lab2](./Lab2/) | Questions 1-5 |
| [Lab3](./Lab3/) | Questions 1-4 |
| [Lab4](./Lab4/) | Questions 1-4 |
| [Lab5](./Lab5/) | Questions 1-4 |
| [Lab6](./Lab6/) | Questions 1-5 |
| [Lab7](./Lab7/) | Questions 1-3 |
| [Lab8](./Lab8/) | Questions 1-3 |
| [Lab9](./Lab9/) | Questions 1-2 |
| [Mini Project](./Mini%20Project/) | Smart parking management system |

## Run a simulation

Install [Icarus Verilog](https://github.com/steveicarus/iverilog) and run commands from the repository root. For example, to compile and run Lab 1, Question 1 in PowerShell:

```powershell
iverilog -g2012 -o sim.vvp .\Lab1\q1\q1.v .\Lab1\q1\q1_tb.v
vvp .\sim.vvp
```

Replace the paths with the design and testbench for the exercise you want to run. For example, Lab 2, Question 3 uses `.\Lab2\q3\q3.v` and `.\Lab2\q3\q3_tb.v`.

The mini project can be run separately:

```powershell
iverilog -g2012 -o parking.vvp ".\Mini Project\smart_parking.v" ".\Mini Project\tb_smart_parking.v"
vvp .\parking.vvp
```

To inspect a waveform, open the corresponding `.vcd` file with a viewer such as GTKWave. The mini project interface, design notes, and test scenarios are documented in [smart_parking_notes.md](./Mini%20Project/smart_parking_notes.md).
