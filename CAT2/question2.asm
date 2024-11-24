section .data
    prompt db "Enter a number: ", 0  ; Message prompt to ask user for input
    out_msg db "The reversed array is: ", 0  ; Output message for reversed array
    nl db 0xA, 0  ; Newline character (not used but can be added for formatting)

section .bss
    array resd 5  ; Reserve space for 5 integers (array[0] to array[4])

section .text
    global _start

_start:
    ; Ask user for input for the first number
    mov eax, 4        ; Syscall number for sys_write
    mov ebx, 1        
    mov ecx, prompt   ; Pointer to the prompt message
    mov edx, 15       ; Length of the prompt message
    int 0x80          ; Make the syscall to display the prompt

    ; Read the first integer
    mov eax, 3        ; Syscall number for sys_read
    mov ebx, 0        
    mov ecx, array    ; Address of the array where input will be stored
    mov edx, 4        ; Number of bytes to read 
    int 0x80          ; Make the syscall to read input from the user

    ; Ask user for input for the second number
    mov eax, 4        ; Syscall number for sys_write
    mov ebx, 1        
    mov ecx, prompt   ; Pointer to the prompt message
    mov edx, 15       ; Length of the prompt message
    int 0x80          ; Make the syscall to display the prompt

    ; Read the second integer
    mov eax, 3        ; Syscall number for sys_read
    mov ebx, 0       
    mov ecx, array+4  ; Address of the second integer in the array
    mov edx, 4        ; Number of bytes to read 
    int 0x80          ; Make the syscall to read input from the user

    ; Ask user for input for the third number
    mov eax, 4        ; Syscall number for sys_write
    mov ebx, 1        
    mov ecx, prompt   ; Pointer to the prompt message
    mov edx, 15       ; Length of the prompt message
    int 0x80          ; Make the syscall to display the prompt

    ; Read the third integer
    mov eax, 3        ; Syscall number for sys_read
    mov ebx, 0       
    mov ecx, array+8  ; Address of the third integer in the array
    mov edx, 4        ; Number of bytes to read 
    int 0x80          ; Make the syscall to read input from the user

    ; Ask user for input for the fourth number
    mov eax, 4        ; Syscall number for sys_write
    mov ebx, 1        
    mov ecx, prompt   ; Pointer to the prompt message
    mov edx, 15       ; Length of the prompt message
    int 0x80          ; Make the syscall to display the prompt

    ; Read the fourth integer
    mov eax, 3        ; Syscall number for sys_read
    mov ebx, 0        
    mov ecx, array+12 ; Address of the fourth integer in the array
    mov edx, 4        ; Number of bytes to read 
    int 0x80          ; Make the syscall to read input from the user

    ; Ask user for input for the fifth number
    mov eax, 4        ; Syscall number for sys_write
    mov ebx, 1        
    mov ecx, prompt   ; Pointer to the prompt message
    mov edx, 15       ; Length of the prompt message
    int 0x80          ; Make the syscall to display the prompt

    ; Read the fifth integer
    mov eax, 3        ; Syscall number for sys_read
    mov ebx, 0        
    mov ecx, array+16 ; Address of the fifth integer in the array
    mov edx, 4        ; Number of bytes to read 
    int 0x80          ; Make the syscall to read input from the user

    ; We have 5 elements at array[0], array[1], array[2], array[3], array[4]
    ; Initialize pointers for the start and end of the array
    mov esi, array    ; esi = pointer to the first element (array[0])
    mov edi, array+16 ; edi = pointer to the last element (array[4])

reverse_loop:
    ;Step1: Load the values into registers
    mov eax, [esi]    ; eax = array[0]
    mov ebx, [edi]    ; ebx = array[4]

    ;Step2: Swap the values
    mov [esi], ebx    ; Store the last element in the first position
    mov [edi], eax    ; Store the first element in the last position

    ;Step3: Move the pointers closer to the center
    add esi, 4        ; Move esi to the next element (array[1])
    sub edi, 4        ; Move edi to the previous element (array[3])

    ;Step4: Check if pointers are at or passed each other
    cmp esi, edi      ; Compare the pointers
    jge reverse_done  ; If so, end the loop

    ;Step5: Load the second and fourth values
    mov eax, [esi]    ; eax = array[1]
    mov ebx, [edi]    ; ebx = array[3]

    ;Step6: Swap the second and fourth values
    mov [esi], ebx    ; Store the fourth element in the second position
    mov [edi], eax    ; Store the second element in the fourth position

    ;Step7: Move the pointers closer to the center
    add esi, 4        ; Move esi to array[2] (middle element)
    sub edi, 4        ; Move edi to array[2] (middle element)

reverse_done:
    ; Output the reversed array
    mov eax, 4        ; Syscall number for sys_write
    mov ebx, 1        
    mov ecx, out_msg  ; Pointer to the output message
    mov edx, 24       ; Length of the output message
    int 0x80          ; Make the syscall to print the message

    ; Print the first element (array[0])
    mov eax, 4        ; Syscall number for sys_write
    mov ebx, 1        
    mov ecx, array    ; Pointer to the first element in the array
    mov edx, 4        ; Number of bytes to print (4 bytes for an integer)
    int 0x80          ; Make the syscall to print array[0]

    ; Print the second element (array[1])
    mov eax, 4        ; Syscall number for sys_write
    mov ebx, 1        
    mov ecx, array+4  ; Pointer to the second element in the array
    mov edx, 4        ; Number of bytes to print (4 bytes for an integer)
    int 0x80          ; Make the syscall to print array[1]

    ; Print the third element (array[2])
    mov eax, 4        ; Syscall number for sys_write
    mov ebx, 1        
    mov ecx, array+8  ; Pointer to the third element in the array
    mov edx, 4        ; Number of bytes to print (4 bytes for an integer)
    int 0x80          ; Make the syscall to print array[2]

    ; Print the fourth element (array[3])
    mov eax, 4        ; Syscall number for sys_write
    mov ebx, 1        
    mov ecx, array+12 ; Pointer to the fourth element in the array
    mov edx, 4        ; Number of bytes to print (4 bytes for an integer)
    int 0x80          ; Make the syscall to print array[3]

    ; Print the fifth element (array[4])
    mov eax, 4        ; Syscall number for sys_write
    mov ebx, 1        
    mov ecx, array+16 ; Pointer to the fifth element in the array
    mov edx, 4        ; Number of bytes to print (4 bytes for an integer)
    int 0x80          ; Make the syscall to print array[4]

    ; Exit the program
    mov eax, 1        ; Syscall number for sys_exit
    xor ebx, ebx      ; Exit status 0
    int 0x80          ; Make the syscall to exit

    ;CHALLENGES WITH HANDLING MEMORY DIRECTLY
    ;The code manually handles memory locations since the adresses are hard-coded for each array element. It may work for small static data, but it is not flexible or scalable
    ;The program manually moves the pointers to the middle, a mistake could lead to accessing invalid memeory, causing bugs.
    ;While working with arrays, it requires managing individual bytes which is a bit cumbersome, and much harder when the data is larger or more complex.