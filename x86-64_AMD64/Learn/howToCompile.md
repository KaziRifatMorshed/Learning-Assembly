Since you are on **Manjaro Linux**, your GCC/Clang is configured with modern security defaults (like PIE - Position Independent Executable) that can sometimes confuse assembly beginners.

Here is the exact way to compile and link `.s` (assembly) files in one step using the compiler drivers.

### 1\. The Standard Way (Linking with C Library)

If your assembly code uses `main` as the entry point and calls C functions (like `printf`, `puts`, `exit`), use this. The compiler automatically links the standard C library (`libc`).

**Command:**

```bash
gcc -g input.s -o output
# OR
clang -g input.s -o output
# OR
g++ -g input.s -o output
```

  * **`-g`**: Adds debugging information (crucial for `gdb`).
  * **`-o output`**: Specifies the name of the executable.

**Example Code (`main` entry):**

```asm
    .global main
    .text
main:
    mov     $60, %rax       # syscall: exit
    xor     %rdi, %rdi      # status: 0
    syscall
```

-----

### 2\. The "Pure" Assembly Way (No C Library)

If your assembly code uses `_start` as the entry point and relies **only** on system calls (no `printf`, no C headers), you must tell GCC/Clang *not* to include the standard startup files.

**Crucial for Manjaro Users:** You likely need the `-no-pie` flag. Modern Linux distros try to randomize memory addresses for security. Standard assembly tutorials often use absolute addresses, which fail under PIE.

**Command:**

```bash
gcc -g -nostartfiles -no-pie input.s -o output
```

  * **`-nostartfiles`**: Tells the linker not to add the standard C startup code **(which normally looks for `main`).**
  * **`-no-pie`**: Disables Position Independent Executable. This ensures your absolute labels work as expected.

**Example Code (`_start` entry):**

```asm
    .global _start
    .text
_start:
    mov     $60, %rax       # syscall: exit
    xor     %rdi, %rdi      # status: 0
    syscall
```

-----

### 3\. Handling Preprocessor Directives (`.S` vs `.s`)

If you want to use C-style macros in your assembly (like `#include`, `#define`), rename your file extension from lowercase `.s` to uppercase **`.S`**.

  * **`.s` (lowercase):** Passed directly to the assembler.
  * **`.S` (uppercase):** Passed through the **C Preprocessor** first, then to the assembler.

**Command (Same as above):**

```bash
gcc -g -no-pie file.S -o output
```

### Summary of Flags

| Flag | Function | When to use |
| :--- | :--- | :--- |
| `-g` | Generates debug symbols | **Always** (allows you to debug with GDB). |
| `-no-pie` | Disables position independence | **Recommended** for beginners learning x86-64 assembly to avoid relocation errors. |
| `-nostartfiles` | Skips C startup code | Use when your entry label is `_start` (pure asm). |
| `-m64` | Forces 64-bit compilation | Usually default on Manjaro, but good to be explicit. |

### Note on G++

You *can* use `g++` for `.s` files, but it is generally unnecessary. `g++` is just the driver for C++ that automatically links the C++ standard library (`libstdc++`). Since assembly rarely uses C++ library features, `gcc` is preferred to keep the binary size smaller.