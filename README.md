Language: [English] | [Po polsku](README.pl.md)

---

# Source Code Transpiler from C to Shell Script (POSIX sh)

## Project Description
This project implements a source-to-source compiler (transpiler) that translates simple C programs into shell scripts compliant with the POSIX sh standard. The tool is written entirely in the sh shell language and relies on pipeline processing and text file operations. It automatically analyzes the input structure, maps C syntactic constructs to their system equivalents, and provides full error diagnostics for unhandled sequences.

## Features
* **Text Preprocessor:** Automatically cleans the source code by removing single-line comments (`//`) and redundant blank lines.
* **Variable Declaration Translation:** Converts static C declarations (e.g., `int x = 5;`) into dynamic shell assignments (`x=5`) while maintaining strict spacing rules around the assignment operator.
* **Advanced `printf` Conversion:** Extracts variable names and formatting strings using capturing groups in `sed`, mapping the `%d` mask to native shell variable evaluation (`$variable`) within the `echo` command.
* **Autonomous Diagnostic Module:** Detects syntax outside the defined project scope (e.g., loops, conditional statements), skips them in the output file, and logs them to an external error registry (`diagnostics.txt`).
* **Executable System Script Generation:** The output file automatically receives the `#!/bin/sh` environment header, allowing it to run directly in the system after permissions are granted.

## What I Learned
* **Stream Text Processing:** Practical mastery of pipelines (`|`), `grep`, and `sed` for filtering and modifying data on the fly.
* **Regular Expressions (Regex):** Utilizing advanced mechanisms such as POSIX character classes (`[[:space:]]`) and capturing groups to isolate specific text fragments.

## Step-by-Step Execution Guide

All steps should be executed in a Linux / ChromeOS terminal.

1. Edit the input C code file named `test.c` using a text editor:

   ```bash
   nano test.c
   ```

   *Example code for `test.c`:*

   ```c
   // Example translator test
   int counter = 10;
   printf("Counter value is %d", counter);
   for(int i=0; i<counter;i++){}
   ```

   Save the file and exit the editor.

2. Grant execution permissions to the main translator script:

   ```bash
   chmod +x translator.sh
   ```

3. Run the translation process:

   ```bash
   ./translator.sh
   ```

4. Verify the generated files:

   * To see the translated sh code:
     ```bash
     cat program.sh
     ```
   * To check unhandled lines (e.g., the for loop):
     ```bash
     cat diagnostics.txt
     ```

5. Grant execution permissions to the newly created script:

   ```bash
   chmod +x program.sh
   ```

6. Run the translated program to see the output:

   ```bash
   ./program.sh
   ```
