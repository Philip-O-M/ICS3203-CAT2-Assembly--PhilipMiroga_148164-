section .data
    prompt db "Enter a number: ", 0xA, 0      ; Prompt message for user input
    prompt_len equ $ - prompt
    positive_message db "Positive", 0xA, 0      ; Message for positive number
    negative_message db "Negative", 0xA, 0      ; Message for negative number 
    zero_message db "Zero/neutral", 0xA, 0      ; Message for zero

section .bss
    num resb 10                          ; Reserve space for user input(string)

section .text
    global _start

_start:
    ; Print the prompt
    mov eax, 4        ; syscall number for sys_write
    mov ebx, 1        ; file descriptor for stdout
    mov ecx, prompt   ; pointer to prompt message
    mov edx, prompt_len       ; length of the prompt string
    int 0x80          ; invoke system call

    ; Read user input
    mov eax, 3        ; syscall number for sys_read
    mov ebx, 0        ; file descriptor for stdin
    mov ecx, num      ; pointer to buffer where input will be stored
    mov edx, 10       ; number of bytes to read
    int 0x80          ; invoke system call

    ; Check if the number is zero
    ;ASCII value of 0 is 48
    mov al, [num]     ; load the input number into al
    cmp al, 48        ; compare with ASCII value of '0'
    je zero_case      ; jump if input is '0' (zero case)
    ;We first need to compare the al value with 0, then perform the conditional jumps.
    ;The jump je(Jump Equal) is used because we are testing if the number is zero. 
    ;If it is, we jump to the zero_case, we dont need to run other jump conditions if the number is 0.

    ; Check if the number is positive or negative
    cmp al, 48        ; compare input with '0'
    jl negative_case  ; jump to negative_case if less than '0'

    ;The jl(Jump Less) is used since we are only accepting numbers less than 0. 
    ;If the input is less than zero, jl would take us to the negative case.

    ;jg would be used to test for positive numbers, but since the positive_case appears first, we do not need to include it.
positive_case:
    ; Display "POSITIVE"
    mov eax, 4        ; syscall number for sys_write
    mov ebx, 1        ; file descriptor for stdout
    mov ecx, positive_message ; pointer to "POSITIVE" message
    mov edx, 8        ; length of the message
    int 0x80          ; invoke system call
    jmp end_program   ; unconditional jump to end_program
    ;We use an unconditional jump since we do not need to run the negative and zero case code. 
    ;We therefore skip them and jump straight to the end program block.
negative_case:
    ; Display "NEGATIVE"
    mov eax, 4        ; syscall number for sys_write
    mov ebx, 1        ; file descriptor for stdout
    mov ecx, negative_message ; pointer to "NEGATIVE" message
    mov edx, 8        ; length of the message
    int 0x80          ; invoke system call
    jmp end_program   ; unconditional jump to end_program
    ;This unconditional jump is similar to the one above, we do not need to run the zero_case block, hence we jump it.
zero_case:
    ; Display "ZERO"
    mov eax, 4        ; syscall number for sys_write
    mov ebx, 1        ; file descriptor for stdout
    mov ecx, zero_message  ; pointer to "ZERO" message
    mov edx, 4        ; length of the message
    int 0x80          ; invoke system call

end_program:
    ; Exit syscall
    mov eax, 1        ; syscall number for sys_exit
    xor ebx, ebx      ; exit status/code 0
    int 0x80          ; Call kernel syscall in 64 bit
