This is a styleguide for the autolisp-unit project. All code, tests, and 
documentation should follow these guidelines.

#Code

- File Names

File names should consist of full words, be in all caps with underscores 
separating words, and with a .lsp extension: FILE_NAME_EXAMPLE.lsp.


- General code file guidelines

80 characters wide, spaces not tabs, indentions at 3 spaces, one space after 
periods in paragraghs of text, one space after the last word on a line that 
continues to the next line, three empty lines between functions.


- File Headers

File headers should use the multi-line comment with no text on the first line 
or after the closing "|;".

The file header should have 3 parts: copyright line, filename and autolisp-unit 
identifier line, paragragh(s) describing what's in the file, and paragragh(s) 
identifying related files - with an empty line between each.

The copyright line and the autolisp-unit identifier should look like the example 
below in each file:

;|
 | Copyright 2016 original author or authors
 |
 | ASSERT.lsp
 | Part of the autolisp-unit unit testing framework.
 |
 | Asserts are the basic checking function of autolisp-unit. They define what is
 | being tested about the functions under test. In this framework, all asserts
 | stand on their own - they should never be wrapped in NOT functions or 
 | otherwise negated or altered. Separate assert functions are provided for all
 | opposites.
 |
 | Testing works most effectively if asserts are part of a defined test.
 | See TEST.lsp for more information about defining tests.
 |;
 

 - Function headers
 
Every function should have a header with a description, list of parameters with 
types expected, lisp of interactions with the user - model space, command line, 
etc. - and a description of any return value with type. All parts will follow a 
Java-doc like format as illustrated below: 
 
; Description of function - ideally one line but as long as necessary. No need 
; to list the function name as it is just a few lines down.
; @params: aString [string] - a string to work on
           index [fixnum] - the index to start from
; @output: N/A or give a description of what happens
; @return: result [string]

(defun aFunction (aString index / aLocalVariable)
   (princ aString))
   

   
#Tests



#Documentation
