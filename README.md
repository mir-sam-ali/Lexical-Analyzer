# Lexical Analyzer for Java

- I've followed [Oracle's Documentation](https://docs.oracle.com/javase/specs/jls/se6/html/lexical.html) of Java's Lexical Structure to write the rules.
- My lexer categorizes each lexeme of the Java program as one of the following tokens:
  - Identifiers
  - Keywords
  - Integer Literals
  - Floating-Point Literals
  - Boolean Literals
  - Character Literals
  - String Literals
  - The Null Literal
  - Separators
  - Operators

## Symbol Table

<p>I've used Seperate Chaining method to implement the Hash table data structure. </p>
The Hashing function is the following:

```bash
Hash = (key)%(SIZE_OF_BUCKET);
```

Here the key is the sum of ASCII values of the characters of the lexeme.

If there is a collision, then the node is added to the linked list at the position of Hash value.

Each Node in the Linked List present at each position in the array will represent a lexeme.

It will consist the following data:

- Token Name
- Lexeme Value
- Line Number

I've decided to add the following tokens in the Symbol Table:

- Integer Literals
- Floating-Point Literals
- Boolean Literals
- Character Literals
- String Literals
- Null Literal
- Identifier
  - When an identifier is matched, my implementation checks if the matched identifier is already present in the symbol table. If it exists, then it is not added to the Symbol Table.

## Functions used

- HASH
  > Calculates and returns the hash value of the lexeme.
- Insert
  > Inserts the given token and it's value to the symbol table.
- lookUp
  > Checks if the given lexeme is already present in the table.
- printSymbolTable
  > Prints the contents of the Symbol table.
- copyString
  > Copies the passed string into new array and returns the pointer.

## Execution

Clone this repository

```bash
git clone https://github.com/mir-sam-ali/Lexical-Analyzer
```

Open the cloned repository and run the following commands:

- make -f Makefile.f
- ./mylexer FILE_NAME.java
