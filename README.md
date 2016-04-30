# BioKode


[![Build Status](https://travis-ci.org/peterkos/BioKode.svg?branch=v1.3)](https://travis-ci.org/peterkos/BioKode)

This is a DNA encryption solver. The goal is to take a DNA sequence, transcribe it in terms of mRNA, and then translate it into words (a.k.a. codons) with the graph below.


<img src="graph_reference.png?raw=true" width="500px"/>

## Install

See the [releases](https://github.com/peterkos/BioKode/releases) page to download.

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
}

````

## To-Do's

Features
- [X] DNA to mRNA || English
- [X] mRNA to DNA || English
- [X] English to mRNA || DNA
- [ ] Show biologically equivalent proteins


Enhancements
- [ ] Autospace words (So the result isn't "POSTITNOTE") (Preference-based)
- [X] Add error-checking (exception handling)
- [X] Simplify the wall of switch-case 
- [X] Fix AutoLayout so text boxes scale with window width and stay in center
- [X] An app icon
