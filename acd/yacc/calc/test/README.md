# Bison-Flex-Calculator
CS Assignment - scientific calculator using Bison &amp; Flex, with additonal functionality implemented in C

## Functionality 
* Basic arithmetic following BODMAS rules e.g, 4 * (3 + 2) = 20
* Standard functions (modulo, ceil, abs, floor) 
* Logarithmic functions (log2, log10)
* Trig functions (cos, sin, tan)
* Hyperbolic functions (cosh, sinh, tanh)
* Conversions (currency, temperature, distance) 
* Variable stores (create and use your own variables. See example)
* Can read input the command line or a file

## Example
![example screenshot](http://i.imgur.com/FArh5XE.png "Example use of the calculator")

## Requirements
1. Bison (needs adding to PATH on windows)
2. Flex (needs adding to PATH on windows)
3. gcc compiler

## Compile and execute
1. bison -d gram.y
2. flex lex.l
3. gcc gram.tab.c lex.yy.c -lm -o scientific-calc
4. scientific-calc
