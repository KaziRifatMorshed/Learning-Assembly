; boot.asm (The Bootloader)

; Set the origin address where the BIOS loads this code into memory.
org 0x7c00

start:
    ; --- Set up environment (minimal) ---
    ; Clear the Direction Flag (DF) for string operations.
    cld

    ; --- Print the Welcome Message ---
    mov si, MESSAGE  ; Load the address of the message into SI (Source Index)
    call print_string

    ; --- Halt the System ---
    jmp $            ; Loop forever ($ refers to the current address), effectively halting the CPU.

; ===========================================
; Procedure: print_string
; Prints a null-terminated string pointed to by SI.
; ===========================================
print_string:
    ; Uses BIOS Interrupt 0x10, function 0x0E (Teletype Output)
.loop:
    lodsb            ; Load byte from [SI] into AL (Accumulator) and increment SI
    cmp al, 0        ; Check if the character is the null terminator (ASCII 0)
    je .done         ; If null, finish printing

    mov ah, 0x0e     ; AH = 0x0E (Teletype Output function)
    int 0x10         ; Call BIOS video services (prints char in AL)
    jmp .loop        ; Loop back for the next character
.done:
    ret              ; Return from the procedure

; --- Data Section ---
MESSAGE:
    db "hello from my OS", 0  ; The message string, terminated by a null byte (0)

; --- Boot Signature and Padding ---
; Fill the remaining space with zeros until the 510th byte.
times 510 - ($ - $$) db 0
; Magic boot signature: 0xAA55 (required by BIOS to recognize a bootable sector).
dw 0xAA55
