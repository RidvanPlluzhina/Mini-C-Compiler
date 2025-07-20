# Mini-C-Compiler
A simple C subset compiler using FLEX, YACC, and C

## Description 
I created a Makefile to run and automate the building of the compiler doing all the steps. I also removed shift/reduce conflict plus added the typed_val.h to store the value and the type of expression and lookup that.
Also implemented scope blocks via a scope stack using:
    - push_scope() – adds a new local scope
    - pop_scope() – removes a local scope and frees memory


## src 
1. compiler.l — Lexical Analyzer (Flex Input)
Defines token patterns (keywords, identifiers, numbers, operators) for the Mini-C language. It breaks the input source code into meaningful tokens.
Purpose: Lexical analysis — the first step of compilation.
Why needed: Without it, the compiler can't recognize or categorize input symbols.

2. parser.y — Parser (Bison Input)
Specifies grammar rules and semantic actions for the Mini-C language. Handles syntax parsing, symbol management, and basic type checking.
Purpose: Syntactic and semantic analysis — the second compilation phase.
Why needed: Ensures code is structurally correct and performs actions like type checks and variable handling.

3. symbol_table.c/.h — Symbol Table Implementation & Interface
Manages declared variables: their names, types, values, and scope levels. Supports insertion, lookup, and value management.
Purpose: Tracks identifiers and enforces semantic rules.
Why needed: Essential for variable declaration, type safety, and scoping.

4. typed_val.h — Typed Value Struct
Defines a structure to hold both a value and its type ("int" or "float").
Purpose: Helps with expression evaluation and type consistency.
Why needed: Enables mixed-type operations and simple type checking during parsing.

##  Installation & Setup Instructions

Follow these steps to install and run the Mini-C Compiler on a Windows system using MSYS2.
Make sure you have the following installed:

1. Git – to clone the repository

2. Flex – for lexical analysis

3. Bison – for parsing

4. GCC – for compilation

5. Make – to automate building (can be installed via MSYS2 or Chocolatey on Windows)

### Prerequisites

You need the following installed:
- [MSYS2](https://www.msys2.org/) – UNIX-like development environment for Windows
- Git (included with MSYS2 or install separately)

---

### Step 1: Install MSYS2

1. Download from [https://www.msys2.org](https://www.msys2.org)
2. Run the installer and follow the setup
3. Open **MSYS2 UCRT64** from the Start Menu

---

### Step 2: Install Required Packages

In the **MSYS2 UCRT64 terminal**, run:

```bash
pacman -Syu
pacman -S git make flex bison gcc
```

### Step 3: Clone the Repository

```bash
git clone https://github.com/yourusername/Mini-C-Compiler.git
cd Mini-C-Compiler
```

### Step 4: Build the Compiler

make


### Step 5: Run the Compiler

make run


### Test Files

Example test input files:
* `test1.txt` – Basic variable declarations and arithmetic
* `test2.txt` – Control Flow with If-Else
* `test3.txt` – Corrected variable declaration order
* `test4.txt` – Test different variable types
* `test5.txt` – Basic Looping 


