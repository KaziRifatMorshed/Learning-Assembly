; kernel.asm (The Kernel)

; The kernel is loaded into memory at an address higher than the bootloader (0x7c00).
; The bootloader would handle loading this file into a safe location like 0x1000.
org 0x1000

start_kernel:
    ; 1. Initialization and Setup
    mov ah, 0x00     ; Function 00h: Set Video Mode
    mov al, 0x03     ; Mode 03h: 80x25 text mode (used for a clear screen)
    int 0x10

    mov si, WELCOME_MSG ; Print Welcome Message
    call print_string

main_loop:
    ; 2. Print Command Prompt
    mov si, PROMPT_MSG
    call print_string

    ; 3. Get User Input (Stub: Actual routine would handle backspace and Enter)
    call get_input   ; Routine to read input into COMMAND_BUFFER

    ; 4. Command Parsing and Execution (Transcript: "minimal command system" [00:00:39])

    ; Check for "clear" command
    ; (Code for string_compare with CLEAR_CMD)
    ; je .clear_command

    ; Check for "info" command
    ; (Code for string_compare with INFO_CMD)
    ; je .info_command

    ; Fallback for unknown command
    mov si, UNKNOWN_CMD_MSG
    call print_string

    jmp main_loop ; Loop back to display the prompt again

.clear_command:
    ; Clear the screen (Transcript: "clear which resets the entire screen" [00:00:48])
    mov ah, 0x06     ; Function 06h: Scroll Active Page Up
    mov al, 0        ; AL=0 clears the entire window
    mov bh, 0x07     ; Attribute (white on black)
    mov cx, 0x0000   ; Start top-left
    mov dx, 0x184f   ; End bottom-right
    int 0x10
    jmp main_loop

.info_command:
    ; Print system details (Transcript: "info which displays system details" [00:00:48])
    mov si, INFO_DETAILS
    call print_string
    jmp main_loop

; --- Utility Procedures (Stubs - full code omitted for brevity but required for function) ---
; print_string: (Same teletype function as in Video 1)
; get_input: (Reads keyboard buffer, handles backspace, terminates on Enter key)
; string_compare: (Compares two strings to determine the command)

; --- Data Definitions ---
WELCOME_MSG db "Welcome to My OS Kernel!", 0Ah, 0Dh, 0  ; \n\r, Null-terminated
PROMPT_MSG  db "> ", 0
UNKNOWN_CMD_MSG db "Error: Unknown command.", 0Ah, 0Dh, 0
INFO_DETAILS db "My OS (Assembly) v0.1", 0Ah, 0Dh, 0

; Command buffer for user input
COMMAND_BUFFER times 64 db 0
CLEAR_CMD db "clear", 0
INFO_CMD db "info", 0
