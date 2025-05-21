# Mini-C-Compiler
A simple C subset compiler using FLEX, YACC, and C


## 🔧 Installation & Setup Instructions

Follow these steps to install and run the Mini-C Compiler on a Windows system using MSYS2.

### ✅ Prerequisites

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
pacman -Syu # First-time update (may require restarting MSYS2)
pacman -S flex bison gcc git
```

### 📦 Step 3: Clone the Repository

```bash
cd ~
git clone https://github.com/RidvanPlluzhina/Mini-C-Compiler.git
cd Mini-C-Compiler
```

### ⚙️ Step 4: Build the Compiler

```bash
flex compiler.l
bison -d parser.y
gcc -o my_compiler lex.yy.c parser.tab.c symbol_table.c -lm
```

### ▶️ Step 5: Run the Compiler

Use one of the provided test files:

```bash
./my_compiler < test1.txt
```

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
