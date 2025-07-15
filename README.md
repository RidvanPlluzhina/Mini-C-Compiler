# Mini-C-Compiler
A simple C subset compiler using FLEX, YACC, and C


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

### 🛠️ Step 1: Install MSYS2

1. Download from [https://www.msys2.org](https://www.msys2.org)
2. Run the installer and follow the setup
3. Open **MSYS2 UCRT64** from the Start Menu

---

### 🛠️ Step 2: Install Required Packages

In the **MSYS2 UCRT64 terminal**, run:

```bash
pacman -Syu
pacman -S git make flex bison gcc
```

### 📦 Step 3: Clone the Repository

```bash
git clone https://github.com/yourusername/Mini-C-Compiler.git
cd Mini-C-Compiler


### ⚙️ Step 4: Build the Compiler

make


### ▶️ Step 5: Run the Compiler

make run


### 🧪 Test Files

Example test input files:
* `test1.txt` – basic declaration and assignment
* `test2.txt` – type mismatch example
* `test3.txt` – float expressions
* `test4.txt` – arithmetic test
* `test5.txt` – undeclared variable test

### 💡 Notes

* This compiler supports `int` and `float` types
* Type checking and symbol table management are included
* Errors are shown for undeclared variables or type mismatches
