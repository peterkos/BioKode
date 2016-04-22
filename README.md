# BioKode



This is a DNA encryption solver. The goal is to take a DNA sequence, transcribe it in terms of mRNA, and then translate it into words (a.k.a. codons) with the graph below.


<img src="graph_reference.png?raw=true" width="500px", height="500px" />

## Install

See the [releases]() page to download.

## Contribute

Feel free to add any interesting side features and/or optimizations! 
The coding style is pretty simple: 
- Opening brace is on same line as the containing call
- Spaces between operators
- Space before comment 
- Tab size set to 4 spaces

Here's an example:

````swift
func sayHelloAndDoMath() {
    // Says hello
    print("Hello, World!");
    
    // Does math
    print(10 + 12);
}

````

## To-Do's

Features
- [X] DNA to mRNA || English
- [ ] mRNA to DNA || English
- [ ] Englisht to mRNA || DNA
- [ ] Show biologically equivalent proteins


Enhancements
- [X] Add error-checking (exception handling)
- [X] Simplify the wall of switch-case 
- [ ] Autospace words (So the result isn't "POSTITNOTE")
- [ ] Fix AutoLayout so text boxes scale with window width and stay in center

