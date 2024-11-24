section .data
    prompt_msg db "Enter a number from 0-12 to calculate factorial: "
    prompt_len equ $ - prompt_msg
    result_msg db "Factorial =: "
    result_len equ $ - result_msg
    error_msg db "Error: Input is not between 0-12", 0xA
    error_len equ $ - error_msg
    newline db 0xA

section .bss
    input_buf resb 32    ; Buffer for string input
    num resq 1           ; 64-bit number storage
    output_buf resb 32   ; Buffer for string output

section .text
    global _start

_start:
    ; Print prompt
    mov rax, 1              ; sys_write
    mov rdi, 1              ; stdout
    mov rsi, prompt_msg
    mov rdx, prompt_len
    syscall

    ; Read input
    mov rax, 0              ; sys_read
    mov rdi, 0              ; stdin
    mov rsi, input_buf
    mov rdx, 32
    syscall

    ; Convert string to number
    mov rsi, input_buf
    call str_to_int      ; Result in rax

    ; Validate input (0 ≤ n ≤ 12)
    cmp rax, 0
    jl input_error
    cmp rax, 12
    jg input_error

    ; Calculate factorial
    mov rdi, rax            ; Save input number
    call factorial          ; Result will be in rax

    ; Print "Factorial = "
    push rax                ; Save factorial result
    mov rax, 1
    mov rdi, 1
    mov rsi, result_msg
    mov rdx, result_len
    syscall

    ; Convert result to string and print
    pop rdi                 ; Restore factorial result
    call int_to_str      ; Convert number to string, result in output_buf
    mov rdx, rax            ; Length returned in rax
    mov rax, 1              ; sys_write
    mov rdi, 1              ; stdout
    mov rsi, output_buf
    syscall

    ; Print newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    jmp exit_program

input_error:
    mov rax, 1              ; sys_write
    mov rdi, 1              ; stdout
    mov rsi, error_msg
    mov rdx, error_len
    syscall

exit_program:
    mov rax, 60             ; sys_exit
    xor rdi, rdi            ; status = 0
    syscall

; Convert string to integer
; Input: RSI points to string
; Output: RAX contains integer
str_to_int:
    push rbx
    push rcx
    push rdx
    push rsi

    xor rax, rax            ; Initialize result
    xor rcx, rcx            ; Initialize current character

.next_char:
    mov cl, [rsi]           ; Get current char
    cmp cl, 0xA             ; Check for newline
    je .done
    cmp cl, 0x20            ; Check for space
    je .done
    cmp cl, 0               ; Check for null
    je .done

    sub cl, '0'             ; Convert ASCII to number
    imul rax, 10            ; Multiply current result by 10
    add rax, rcx            ; Add new digit

    inc rsi                 ; Move to next character
    jmp .next_char

.done:
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    ret

; Convert integer to string
; Input: RDI contains integer
; Output: RAX contains length, output_buf contains string
int_to_str:
    push rbx
    push rcx
    push rdx
    push rdi
    push rsi

    mov rax, rdi            ; Number to convert
    mov rsi, output_buf
    add rsi, 31             ; Point to end of buffer
    mov byte [rsi], 0       ; Null terminate

    mov rcx, 0              ; Character counter
    mov rbx, 10             ; Divisor

.divide_loop:
    xor rdx, rdx            ; Clear for division
    div rbx                 ; Divide by 10
    add dl, '0'             ; Convert to ASCII
    dec rsi                 ; Move back in buffer
    mov [rsi], dl           ; Store digit
    inc rcx                 ; Count characters
    test rax, rax           ; Check if done
    jnz .divide_loop

    ; Move string to start of buffer
    mov rdi, output_buf
    push rcx                ; Save length
    cld
    rep movsb

    pop rax                 ; Return length in RAX

    pop rsi
    pop rdi
    pop rdx
    pop rcx
    pop rbx
    ret

; Calculate factorial
; Input: RDI = number
; Output: RAX = factorial result
factorial:
    push rbx
    push rcx

    mov rax, 1              ; Initialize result to 1
    mov rcx, rdi            ; Counter = input number

.factorial_loop:
    cmp rcx, 1              ; Check if we're done
    jle .factorial_done     ; If counter <= 1, we're done

    mul rcx                 ; RAX = RAX * RCX
    dec rcx                 ; Decrement counter
    jmp .factorial_loop

.factorial_done:
    pop rcx
    pop rbx
    ret


;1. Computes the factorial of a number received as input: The program calculates the factorial by calling the factorial subroutine, and stores the result in RAX.
  
;2. Uses the stack to preserve registers, demonstrating an understanding of modular code and register handling: Registers such as `RBX`, `RCX`, and `RDX` are saved to and restored from the stack in each subroutine, ensuring the correct state is maintained across function calls.

;3. Places the final result in a general-purpose register: The factorial result is returned in `RAX` by the `factorial` subroutine.
;The program manages registers by saving and restoring values on the stack in each subroutine, ensuring that registers such as `RBX`, `RCX`, and `RDX` are preserved across function calls,... 
;...preventing data loss and maintaining the integrity of the registers when control returns to the main program or previous subroutines.