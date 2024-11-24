section .data
    prompt db "Enter sensor value: ", 0         ; Prompt message for user input
    motor_on_msg db "Motor is ON", 10, 0        ; Message for motor on
    motor_off_msg db "Motor is OFF", 10, 0      ; Message for motor off
    alarm_msg db "Alarm is triggered!", 10, 0   ; Message for alarm trigger
    no_alarm_msg db "No alarm", 10, 0           ; Message for no alarm

section .bss
    sensor_value resb 4     ; Reserve 4 bytes for input (sensor value)
    motor_status resb 1     ; Reserve 1 byte for motor status (ON/OFF)
    alarm_status resb 1     ; Reserve 1 byte for alarm status (triggered/no alarm)

section .text
    global _start           ; Entry point of the program

_start:
    mov byte [motor_status], 0    ; Initialize motor to OFF
    mov byte [alarm_status], 0    ; Initialize alarm to No Alarm

    ; Prompt user for input
    mov eax, 4             ; Syscall for write
    mov ebx, 1             ; File descriptor for stdout
    lea ecx, [prompt]      ; Load prompt message address
    mov edx, 19            ; Length of prompt message
    int 0x80               ; Execute syscall

    ; Read user input (sensor value)
    mov eax, 3             ; Syscall for read
    mov ebx, 0             ; File descriptor for stdin
    lea ecx, [sensor_value]   ; Load address to store input
    mov edx, 4             ; Read up to 4 bytes
    int 0x80               ; Execute syscall

    ; Convert input (ASCII to integer)
    lea esi, [sensor_value] ; Point to input string
    xor eax, eax            ; Clear eax (result accumulator)
    xor ebx, ebx            ; Clear ebx (temporary register)

convert_loop:
    movzx ecx, byte [esi]   ; Load next character
    cmp ecx, 10              ; Check if newline (end of input)
    je done_conversion       ; If newline, exit loop
    sub ecx, 48              
    imul eax, eax, 10        ; Multiply result by 10 (shift left)
    add eax, ecx             ; Add the new digit to result
    inc esi                  ; Move to next character
    jmp convert_loop         ; Repeat conversion

done_conversion:
    ; Perform logic based on sensor value
    cmp eax, 100             ; Check if value > 100
    jg trigger_alarm         ; Jump to alarm if true

    cmp eax, 50              ; Check if value > 50
    jg turn_on_motor         ; Jump to motor on if true

    jmp stop_motor           ; Otherwise, stop motor

trigger_alarm:
    mov byte [alarm_status], 1   ; Set alarm status to triggered
    mov eax, 4              ; Syscall for write
    mov ebx, 1              ; File descriptor for stdout
    lea ecx, [alarm_msg]    ; Load alarm message address
    mov edx, 20             ; Length of alarm message
    int 0x80                ; Execute syscall
    jmp exit                ; Exit program

turn_on_motor:
    mov byte [motor_status], 1   ; Set motor status to ON
    mov eax, 4              ; Syscall for write
    mov ebx, 1              ; File descriptor for stdout
    lea ecx, [motor_on_msg] ; Load motor-on message address
    mov edx, 14             ; Length of motor-on message
    int 0x80                ; Execute syscall
    jmp exit                ; Exit program

stop_motor:
    mov byte [motor_status], 0   ; Set motor status to OFF
    mov eax, 4              ; Syscall for write
    mov ebx, 1              ; File descriptor for stdout
    lea ecx, [motor_off_msg] ; Load motor-off message address
    mov edx, 15             ; Length of motor-off message
    int 0x80                ; Execute syscall
    jmp exit                ; Exit program

exit:
    mov eax, 1              ; Syscall for exit
    xor ebx, ebx            ; Return status 0 
    int 0x80                ; Exit program

    ; Sensor Input Handling:
    ;    - The user is prompted to enter a sensor value.
    ;    - The input is read and stored in the `sensor_value` memory location.
    ;
    ; Decision Logic:
    ;    - The program checks the sensor value:
    ;      - If the value is greater than 100, the alarm is triggered (set `alarm_status` to 1).
    ;      - If the value is greater than 50 but less than or equal to 100, the motor is turned on (set `motor_status` to 1).
    ;      - If the value is 50 or below, the motor is turned off (set `motor_status` to 0).
    ;
    ; Memory Location Manipulation:
    ;    - Motor Status: The `motor_status` memory location holds either a 0 (motor off) or 1 (motor on).
    ;      The value is modified when the program decides to turn the motor on or off based on the sensor input.
    ;    - Alarm Status: The `alarm_status` memory location holds either a 0 (no alarm) or 1 (alarm triggered).
    ;      It is set to 1 when the sensor value exceeds 100, triggering the alarm.
