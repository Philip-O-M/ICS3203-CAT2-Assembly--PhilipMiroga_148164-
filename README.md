# ICS3203-CAT2-Assembly--PhilipMiroga_148164-

## Requirements

The code is is being run on a linux system. Ensure you have the following:

### NASM 

It is an assembler and disassembler for the Intel x86 architecture. It can be used to write/run 16, 32 or 64 bit programs. Install it as follows:
       
        sudo apt update
        sudo apt install nasm

### GDB

It is a portable debugger that runs on many Unix based systems. It is installed as follows:

        sudo apt install gdb

The programs will mainly be **64-bit** programs.

Clone the repository to be able to run the programs.
## Questions

Each question has some comments in their respective files explaining the code.

### Question 1- Control Flow and Conditional Logic
The assembly program takes in input from the user and classifies it as positive, negative or zero. The following are the commands used to run the code:

    cd ICS3203-CAT2-Assembly--PhilipMiroga_148164-/CAT2
    nasm -f elf64 question1.asm -o question1.o
    ld question1.o -o question1
    ./question1

The result will be a prompt asking for a number.

Enter any number and the output will be 'positive', 'negative' or 'zero' based on the number you entered.

The code uses different types of jumps; conditional and unconditional jumps.

Conditional jumps like **jl** need to satisfy the criteria after comparing values. Unconditional jumps like **jmp** always get executed.

### Question 2- Array Manipulation with Looping and Reversal
The assembly program takes in 5 values from the user and returns a reversed array of the same values. The code is run as follows:

    cd ICS3203-CAT2-Assembly--PhilipMiroga_148164-/CAT2
    nasm -f elf64 question2.asm -o question2.o
    ld question2.o -o question2
    ./question2

The result will be a reversed array of the 5 values entered.

The code does not use any additional memory to store the reversed array. This leads to the code not being scalable or flexible and having to adjust for larger data sets.

It also uses a loop for the process, where the pointers are used at both end sides and switch values until they reach the middle, where the loop stops when the pointers pass each other or meet at the middle.

### Question 3- Modular Program with Subroutines for Factorial Calculation
The assembly program is used to calculate the factorial of the values between 0 and 12. The code is run as follows:

    cd ICS3203-CAT2-Assembly--PhilipMiroga_148164-/CAT2
    nasm -f elf64 question3.asm -o question3.o
    ld question3.o -o question3
    ./question3

The code uses a subroutine factorial code block which performs the calculations. This subroutine is called in the main section of the code.

This makes the code much more readable and easy to debug. 

### Question 4- Data Monitoring and Control Using Port-Based Simulation
The program is simulating a sensor used for data monitoring. The code is run as follows:

    cd ICS3203-CAT2-Assembly--PhilipMiroga_148164-/CAT2
    nasm -f elf64 question4.asm -o question4.o
    ld question4.o -o question4
    ./question4

The input acts as the sensor value. 
If the value is below or equal to 50, the motor turns off.

If the value is above 50 but below 100, the motor turns on.

If the value is above 100, there is an alert.

This can be used in water monitoring systems to prevent flooding.




