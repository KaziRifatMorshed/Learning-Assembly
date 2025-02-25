.MODEL SMALL
.STACK 100H

.DATA
A DW 2
B DW 3
SUM DW ?

.CODE
MAIN PROC
// INIT DS
MOV AX, @DATA
MOV DS, AX
;/*
;Let's break down the 8086 assembly instructions `MOV AX, @DATA` and `MOV DS, AX`.

;**1. `MOV AX, @DATA`**

;* **`MOV`**: This is the move instruction.  It copies data from a source to a destination.
;* **`AX`**:  `AX` is a 16-bit general-purpose register.  It's often used for arithmetic operations and, as in this case, for holding intermediate values.
;* **`@DATA`**: This is a crucial part. `@DATA` is *not* the data itself.  Instead, it's the *offset* (memory address) of the beginning of your data segment.  Think of it as a pointer to where your data lives in memory.  The assembler replaces `@DATA` with the actual numerical offset value during the assembly process.

;So, this instruction copies the *offset* of the data segment into the `AX` register.  `AX` now holds the starting address of your data.

;**2. `MOV DS, AX`**

;* **`DS`**: This is the Data Segment register.  The 8086 uses segment registers to manage memory.  The `DS` register points to the start of the data segment.  All memory accesses related to data use the offset stored in the `DS` register.
;* **`AX`**:  As explained above, `AX` currently holds the offset of the data segment.

;This instruction copies the value in `AX` (which is the data segment offset) into the `DS` register.  Now, the `DS` register is properly initialized to point to the beginning of your data segment.

;**Why is this necessary?**

;The 8086 uses a segmented memory model.  This means that memory is divided into segments (code, data, stack, etc.).  To access data, the CPU needs both a segment address and an offset within that segment.

;* The segment address is held in a segment register (like `DS`).
;* The offset is typically provided by other registers or addressing modes.

;Before your program can access any data, you *must* initialize the appropriate segment registers.  In this case, you're initializing the `DS` register to point to your data segment.  Without these two instructions, the CPU wouldn't know where your data is located in memory.

;**Example**

;Let's imagine your data segment starts at memory address `1000h` (hexadecimal).

;1. `MOV AX, @DATA`:  The assembler would replace `@DATA` with `1000h`.  So, `AX` would contain `1000h`.
;2. `MOV DS, AX`: The value in `AX` (`1000h`) is copied into `DS`.  Now, `DS` also contains `1000h`.

;Now, if you want to access a variable located at offset `0010h` within your data segment, the CPU would use the `DS` register (`1000h`) and add the offset (`0010h`) to calculate the physical memory address (`1000h + 0010h = 10010h`).

;**In Summary**

;These two instructions are essential for any 8086 assembly program that uses a data segment. They set up the `DS` register, allowing your program to access data correctly.  They don't move the data itself; they move the *address* of the data segment into the `DS` register.

;====================================================================================================

;You can't directly use `MOV DS, @DATA` in 8086 assembly because of a fundamental limitation in the architecture: you cannot directly move an immediate value (like the offset represented by `@DATA`) into a segment register (like `DS`).

;Here's why:

;1. **Segment Registers are Special:** Segment registers (CS, DS, ES, SS) hold segment addresses, not general-purpose data.  They are used by the CPU for memory segmentation.

;2. **Immediate Values and Segment Registers:** The 8086 architecture restricts the use of immediate values (constants or addresses known at assembly time) with segment registers.  You can't directly load a segment register with a constant value.  This is a hardware limitation.

;3. **The Need for an Intermediary:** To work around this, you must use a general-purpose register (like AX) as an intermediary.  You first move the immediate value into the general-purpose register and then move the contents of that register into the segment register.

**Why the Restriction?**

The reason for this restriction is related to the way the 8086 handles memory segmentation.  Segment registers aren't just holding raw addresses; they are part of the segmented addressing scheme.  The CPU uses them in a specific way to calculate physical addresses.  Directly loading them with arbitrary immediate values could potentially lead to addressing issues or memory protection violations.

**The Correct Approach (as you've seen):**

;```assembly
;MOV AX, @DATA  ; Move the OFFSET of the data segment into AX
;MOV DS, AX      ; Move the contents of AX (the offset) into DS
;```

This two-step process is the standard and required way to initialize segment registers with the offset of a segment.  `@DATA` represents the *offset* of your data segment, and this offset must be loaded into a general-purpose register first before being transferred to `DS`.

**In short:** The 8086 architecture simply doesn't allow direct `MOV` instructions from immediate values (like `@DATA`) to segment registers (like `DS`).  The use of a general-purpose register as an intermediary is the required workaround.

*/

// ADD NUMBERS
MOV AX, A
ADD AX, B
MOV SUM, AX

// print sum
// Displaying the sum on the screen requires more complex code involving DOS interrupts.
MOV DL, SUM // This is an 8-bit register (part of the `DX` register). It's often used to hold data for output operations
ADD DL, 48 // ascii character conversion
MOV AH, 2 // higher AX এ ২ রাখো যেটা প্রিন্টের কাজ করবে
INT 21H // DOS interrupt // This instruction triggers the DOS interrupt handler.  Because AH was set to 2, DOS knows to execute the "display character" function.  The character to be displayed is taken from the DL register.




// EXIT TO DOS
MOV AX, 4C00H
INT 21H

MAIN ENDP
END MAIN

/*
Let's break down the 8086 assembly code `MOV AX, 4C00H` and `INT 21H`.  This code snippet is a standard way to terminate a DOS program.

**1. `MOV AX, 4C00H`**

* **`MOV`**: This is the "move" instruction. It copies data from one location to another.
* **`AX`**:  `AX` is a 16-bit register in the 8086 microprocessor. It's often used for general-purpose operations, but in this case, it's being used to specify the DOS function we want to call.
* **`4C00H`**: This is a hexadecimal value.  It's the specific code that tells DOS "terminate the program."  The `H` indicates that the number is in hexadecimal.

In essence, this instruction is loading the value `4C00H` into the `AX` register.  This sets up the DOS function call for program termination.

**2. `INT 21H`**

* **`INT`**: This is the "interrupt" instruction. It interrupts the normal flow of program execution and calls an interrupt handler.
* **`21H`**: This is the interrupt number.  Interrupt `21H` is the DOS function call interrupt.  It's the primary way for a program to request services from the DOS operating system.

When the `INT 21H` instruction is executed, the 8086 processor jumps to the interrupt handler for interrupt `21H`.  This handler is part of DOS.  DOS looks at the value in the `AH` register (the upper byte of `AX`).  Since we loaded `4C00H` into `AX`, `AH` contains `4C`.  DOS recognizes `4C` as the terminate program function and proceeds to end the program's execution.

**In Summary**

The two lines of code work together as follows:

1. The `MOV AX, 4C00H` instruction prepares the DOS function call by placing the terminate program code (`4C00H`) into the `AX` register.
2. The `INT 21H` instruction triggers the DOS interrupt handler, which recognizes the function code in `AX` and terminates the program.

**Why this is important**

This is the standard way to exit a DOS program.  Without these lines, the program wouldn't properly release resources and could potentially cause issues with the operating system.  Every well-behaved DOS program should end with this sequence (or an equivalent).

**Example in Context (Simplified)**

```assembly
.MODEL SMALL  ; Define memory model
.STACK 100H   ; Define stack size

.DATA        ; Data segment (if you have any data)

.CODE       ; Code segment
MAIN PROC    ; Main procedure

    MOV AX, 4C00H  ; Terminate program function
    INT 21H      ; Call DOS interrupt

MAIN ENDP    ; End of main procedure
END MAIN     ; End of program
```

This is a very basic program structure, but it includes the crucial lines for termination.  The `INT 21H` with `AH = 4Ch` is the essential part.

*/

/*
This is a short snippet of 8086 assembly code that's designed to display a character on the DOS screen. Let's break down each instruction:

**1. `MOV DL, AL`**

* **`MOV`**: This instruction copies data from one register to another.
* **`DL`**: This is an 8-bit register (part of the `DX` register). It's often used to hold data for output operations.
* **`AL`**: This is an 8-bit register (part of the `AX` register). It's a general-purpose register, but in this context, it's assumed to hold the ASCII value of the character you want to display.

This instruction copies the value stored in the `AL` register into the `DL` register.  So, `DL` now holds the ASCII value of the character to be displayed.

**2. `ADD DL, 48`**

* **`ADD`**: This instruction adds two values together.
* **`DL`**: The destination register (and one of the operands).
* **`48`**: An immediate value (a constant).  In ASCII, the characters '0' through '9' are represented by the decimal values 48 through 57.

This instruction adds 48 (decimal) to the value in the `DL` register.  This is a crucial step if you want to display a numeric digit.  If `AL` initially held a number from 0 to 9, adding 48 converts that number into its corresponding ASCII character representation.  For example:

* If `AL` held 0, `DL` will become 48 (ASCII for '0').
* If `AL` held 5, `DL` will become 53 (ASCII for '5').

**3. `MOV AH, 2`**

* **`MOV`**: Copy data.
* **`AH`**: The upper 8 bits of the `AX` register.  It's used to specify the DOS function you want to call.
* **`2`**:  This value represents the DOS function for displaying a character.

This instruction sets the `AH` register to 2. This prepares DOS to use function 2, which is "display character output."

**4. `INT 21H`**

* **`INT`**: This is the interrupt instruction. It calls a specific interrupt handler.
* **`21H`**: This is the interrupt number.  Interrupt `21H` is the DOS function call interrupt.

This instruction triggers the DOS interrupt handler.  Because `AH` was set to 2, DOS knows to execute the "display character" function.  The character to be displayed is taken from the `DL` register.

**In Summary**

This code snippet takes the ASCII value of a character (or a digit 0-9), potentially converts it to its displayable ASCII form, and then uses DOS function 2 to display that character on the screen.

**Example**

Let's say you want to display the character '7'.  You would:

1. Put the ASCII value of '7' (which is 55 decimal or 37 hex) into the `AL` register.
2. Execute the code:
   ```assembly
   MOV DL, AL   ; DL = AL (55)
   ADD DL, 48   ; DL = DL + 48 = 103 (ASCII of '7')
   MOV AH, 2    ; AH = 2 (display character function)
   INT 21H      ; Call DOS interrupt
   ```

After this code runs, the character '7' would appear on the DOS screen.

*/
