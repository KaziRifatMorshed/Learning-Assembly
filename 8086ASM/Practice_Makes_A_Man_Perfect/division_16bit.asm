.model small
.stack 100h

; DONE

.data
kake_vag_korbo dw ?
koto_diye_vag_korbo dw ?
vagfol dw ?
vagsesh dw ?
newline db 10, 13, "$"

.code
main proc
   mov ax, @data
   mov ds, ax

   input_one:
   mov ah, 1
   int 21h
   sub ax, 48
   mov ah, 0 ; otherwise, input korar ah=1 roye jabe
   mov kake_vag_korbo, ax

   new_line_print:
   lea dx, newline
   mov ah, 9
   int 21h

   input_two:
   mov ah, 1
   int 21h
   sub ax, 48
   mov ah, 0 ; ----------------------- otherwise, input korar ah=1 roye jabe
   mov koto_diye_vag_korbo, ax

   ;new_line_print:
   lea dx, newline
   mov ah, 9
   int 21h

   DIVISION:
   mov ax, kake_vag_korbo
   mov dx, 0
   mov bx, koto_diye_vag_korbo
   ;div bx
   idiv bx

   storing_result:
   mov vagfol, ax
   mov vagsesh, dx

   mov dx, ax
   add dx, 48

   mov ah, 2
   int 21h

   mov ax, 4c00h
   int 21h
main endp
end main

; --------------------------------------------------------------------

; Example: 16-bit/16-bit unsigned division

;    mov AX, 1000  ; Dividend (16-bit)
;    mov BX, 10    ; Divisor (16-bit)
;    mov DX, 0     ; Very important to clear DX.
;    div BX          ; Assembler knows: 16-bit division

    ; AX = Quotient
    ; DX = Remainder

    ; Example: 32-bit/16-bit unsigned division

;    mov AX, 0FFFFh ; low word of dividend
;    mov DX, 0001h ; high word of dividend
;    mov BX, 10    ; Divisor (16-bit)

;    div BX          ; Assembler knows: 32-bit/16-bit division

    ; AX = Quotient
    ; DX = Remainder

; -------------------------------------------------------------------
;
; ;In 16-bit division within 8086 assembly, the dividend, divisor, quotient, and remainder are handled as follows:
;
;**Registers and Memory:**
;
;* **Dividend:**
;    * The 32-bit dividend (if it's a 32-bit/16-bit division) is stored in the `DX:AX` register pair. `DX` holds the high-order 16 bits, and `AX` holds the low-order 16 bits.
;    * If your dividend is only 16 bits, it is stored in the AX register, and DX must be set to zero.
;* **Divisor:**
;    * The 16-bit divisor is stored in a general-purpose register or a memory location.
;* **Quotient:**
;    * After the division, the 16-bit quotient is stored in the `AX` register.
;* **Remainder:**
;    * After the division, the 16-bit remainder is stored in the `DX` register.
;
;**The `DIV` Instruction:**
;
;The 8086 uses the `DIV` (unsigned divide) instruction for unsigned division and the `IDIV` (signed divide) instruction for signed division.
;
;**Example (16-bit/16-bit unsigned division):**
;
;Let's say you want to divide the value in `AX` (dividend) by the value in `BX` (divisor).
;
;```assembly
;    ; Assume AX contains the 16-bit dividend
;    ; Assume BX contains the 16-bit divisor
;
;    mov DX, 0       ; Clear DX (high-order part of 32-bit dividend)
;    div BX          ; Divide DX:AX by BX
;
;    ; Now, AX contains the quotient
;    ; And DX contains the remainder
;```
;
;**Example (32-bit/16-bit unsigned division):**
;
;If your dividend is a 32-bit value stored in `DX:AX`, and your divisor is in `BX`:
;
;```assembly
;    ; Assume DX:AX contains the 32-bit dividend
;    ; Assume BX contains the 16-bit divisor
;
;    div BX          ; Divide DX:AX by BX
;
;    ; Now, AX contains the quotient
;    ; And DX contains the remainder
;```
;
;**Important Considerations:**
;
;* **Division by Zero:** If the divisor is zero, a divide-by-zero interrupt (interrupt 0) occurs, and the program will likely crash. You should always check for a zero divisor before performing the division.
;* **Overflow:** If the quotient is too large to fit in `AX` (for a 16-bit/16-bit division) or if the quotient is too large to fit in AX (for a 32-bit/16-bit division), a divide-by-zero interrupt occurs. To avoid this, you should ensure that the quotient will fit in the destination register.
;* **Signed Division:** For signed division, use the `IDIV` instruction. The same register conventions apply, but the values are treated as signed integers.
;* **Clearing DX:** When doing a 16 bit divided by 16 bit division, it is very important to clear the DX register. If you do not clear the DX register, then the 8086 will treat the AX register as the lower 16 bits of a 32 bit number stored in the DX:AX register pair.
;* **Error Checking:** it is always good practice to check the divisor to make sure it is not zero before performing the division.
;
;**In summary:**
;
;1.  **Dividend:** `DX:AX` (32-bit) or `AX` (16-bit).
;2.  **Divisor:** A 16-bit register or memory location.
;3.  **Quotient:** `AX`.
;4.  **Remainder:** `DX`.
;
;Remember to use `DIV` for unsigned division and `IDIV` for signed division. Always check for division by zero and potential overflow.
;
