This is a styleguide for the autolisp-unit project. All code, tests, and 
documentation should follow these guidelines.

##Code

### File Names

File names should consist of full words, be in all caps with underscores 
separating words, and with a .lsp extension: `FILE_NAME_EXAMPLE.lsp`. All 
code should be stored in the `autolisp-unit/src` folder.


### General Guidelines

80 characters wide, spaces not tabs, indentions at 3 spaces, one space after 
periods in paragraghs of text, one space after the last word on a line that 
continues to the next line, three empty lines between functions and other 
logical sections, and no extra whitespace.


### File Headers

File headers should use the multi-line comment with no text (except the added 
`|`) on the first line or after the closing `|;`.

The file header should have 3 parts: copyright line, filename and autolisp-unit 
identifier line, paragragh(s) describing what's in the file, and paragragh(s) 
identifying related files - with an empty line between each.

The copyright line and the autolisp-unit identifier should look like the example 
below in each file:
```lisp
;||
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
``` 

### Function headers
 
Every function should have a header with 
- a description
- list of parameters with types expected
- list of interactions with the user - model space, command line, etc. - and
- a description of any return value with type.

All parts will follow a Javadoc-like format as illustrated below: 
```lisp
;||
 | Description of function - ideally one line but as long as necessary. No need 
 | to list the function name as it is just a few lines down.
 | @param:  aString [string] - a string to work on
 |          index [fixnum] - the index to start from
 | @output: N/A or give a description of what happens at the command line, etc.
 | @return: result [string]
 | @see: important, related functions or files (especially opposite functions)
 |;

(defun aFunction (aString index / aLocalVariable)
   (setq aLocalVariable
      (substr aString index)))
```   

### Naming

Autolisp-unit naming will follow a style more akin to those used in the major 
programming languages (Java, C, C#, etc.) than in common lisp. The main reasons 
for this are readability and brevity. The hyphen separated words of lisp can be 
harder to read than camel case and the hyphens constitute additional, unneeded 
characters. Here are some examples of the style used in autolisp-unit:

- Variables: `aVariableName`, `anotherVariable`, `index2` - Descriptive words/numbers 
in camelCase.
- Public Functions (listed in docs and used directly by the user): 
`AFunctionName`, `Function1`, `TheAwesomeFunction` - Descriptive words/numbers in 
PascalCase. 
- Private Functions (functions not directly accessed by users): 
`ALU:StringConcatenator`, `ALU:TimerStart` - Add `ALU:` to the start of the 
function's name to prevent conflicts with similar functions already defined in 
the namespace.
- AutoLISP Functions: `vl-princ-to-string`, `foreach`, `mapcar` - Use the style found in the official documentation to avoid confusion.

Example (not a real function):
```lisp
(defun Assert (functionToUse argumentsForFunction / stringToRun)
   (setq stringToRun
      (vl-princ-to-string
         (strcat functionToUse argumentsForFunction)))
   (ALU:RunFunctionWithArgs stringToRun))
```

### Formatting

TL;DR - 3 spaces for all indents, closing parentheses on the last line, see 
examples for specific formatting of odd cases

Functions:
```lisp
(defun TestFunction ( / )
   (princ))
   
(defun TestFunction (aString / )
   (princ aString)
   (princ))
   
(defun ALU:InternalFunction (argument1 argument2 argument3 argument4 
                             argument5 argument6 bigArgument1 bigArgument2 
                             / localVariable1 localVariable2 localVariable3 
                               localVariable4 localBiggerVariable1)
   (firstFunction
      (secondFunction
         (thirdFunction argument1 argument2))))
```

## Tests

Tests are code files and should follow all code style guidelines with the 
addition of only a few other things.

- Tests should be stored in the autolisp-unit/test folder.

- Test files should only be responsible for testing one code file. The 
file name should be the name of the file tested plus `_TEST` between the file 
and the extension: E.g. `ASSERT_TEST.lsp` would contain all tests for `ASSERT.lsp`.

- Test functions should descibe the functionality under test and be part of a
test suite for the function under test. `returnsTrueForGoodAssert` might be a 
test function in the `assertTrue` suite of tests.

- Usually, there should be only one assert per test function, but occasionally it 
makes sense to combine multiple asserts that test the same basic fuctionality.


## Documentation

Following these guidelines should make the code largely self-documenting - at 
least, from a development standpoint. Making its use clear to the end user is 
another thing.

Documentation outside the source files themselves is designed to help users 
learn the commands, techniques, and processes for using autolisp-unit 
effectively on every AutoLISP project they undertake. To that end, it should 
include clear descriptions of all commands and techniques with good 
examples that focus on illuminating one idea at a time.

Aside from using proper grammar, spelling, and prose style and following the 
guidelines above in all code samples - including testing samples - there is 
little else to say about documentation style. For autolisp-unit, we will use 
an American English style. Typically that simply means the shorter spelling 
of a word with multiple spellings - e.g. color, not colour. They only 
exception to this rule is using "grey" instead of "gray" as both are 
exceptable in the U.S. but the former seems to be more prevalent worldwide.

Documentation files should be stored in the `autolisp-unit` folder with `.md`.
