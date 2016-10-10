# ALUnit
A simple, fast, unit testing framework for AutoLISP

This framework will follow the style of JUnit as much as possible, drawing from lisp-unit
for AutoLISP implementation ideas from Common Lisp.

Some goals for the project:
- All tests can be run with one command.
- Tests run quickly and display total elapsed time.
- Enough information is displayed about the results, but not too much.
- Low memory usage.
- The framework is properly unit tested itself. (After the first version is finished.)

To use the framework, download the latest release from the releases folder; it should be 
one file named something like this "ALUnit-v1.0.lsp". Add it to your AutoCAD app startup suite 
or just use APPLOAD to load it manually and you're ready to use the testing functions.

To make full use of the framework, you'll need to create lots of tests - perhaps in the 
same files as the functions they're testing - so review the documentation to see how 
that's done. Don't worry, if you do that part well you'll only have to create the tests once 
and then they will always be there for you to double check that everything's working the way 
it should.
