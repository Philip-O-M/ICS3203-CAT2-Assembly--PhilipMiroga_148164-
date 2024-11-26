# ICS3203-CAT2-Assembly--PhilipMiroga_148164-

## Questions

### Question 1- Control Flow and Conditional Logic
The assembly program takes in input from the user and classifies it as positive, negative or zero. The following are the commands used to run the code:

    cd ICS3203-CAT2-Assembly--PhilipMiroga_148164-/CAT2
    nasm -f elf64 question1.asm -o question1.o
    ld question1.o -o question1
    ./question1

The result will be a prompt asking for a number.
Enter any number and the output will be positive, negative or zero based on the number you entered.

### Question 2- Array Manipulation with Looping and Reversal
The assembly program takes in 5 values from the user and returns a reversed array of the same values. The code is run as follows:

    cd ICS3203-CAT2-Assembly--PhilipMiroga_148164-/CAT2
    nasm -f elf64 question2.asm -o question2.o
    ld question2.o -o question2
    ./question2

The result will be a reversed array of the 5 values entered.

### Question 3- Modular Program with Subroutines for Factorial Calculation
The assembly program is used to calculate the factorial of the values between 0 and 12. The code is run as follows:

    cd ICS3203-CAT2-Assembly--PhilipMiroga_148164-/CAT2
    nasm -f elf64 question3.asm -o question3.o
    ld question3.o -o question3
    ./question3

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




