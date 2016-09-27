;|
 | Copyright (c) 2016, J.D. Sandifer
 | See LICENSE file for use restrictions.
 |
 | Test.lsp
 | Part of the ALUnit testing framework.
 |
 | Tests are sets of asserts and the code needed to setup for and cleanup after
 | each assert (or group of closely related asserts).
 |
 | Tests should be grouped into logical test suites to enable running a group of
 | related tests easily. For this reason, it is a required parameter when 
 | defining a new test.
 |
 | See Assert.lsp for more information about which asserts are available.
 |;

 
;|
 | Global variables used:
 | *ALU:allTests* - assoc list of tests and test expressions
 | *ALU:testSuites* - assoc list of test suites and a list of their tests
 | *ALU:testsRun* - counter for total tests run in the current batch
 | *ALU:failMessages* - list of messages to print after testing
 |; 

;|
 | Resets test counter and list of fail messages.
 | @output: Resets variables for the above items.
 |;
 
(defun ALU:resetTestInfo ( / )
	(setq *ALU:testsRun* 0)
	(setq *ALU:failMessages* '())
	(princ))


;|		
 | Defines a test - adding it to both the test list and the test suite list.
 | @params: testName [string], testSuite [string], expressions [list]
 |;

(defun defineTest ( testName testSuite expressions / existingTestWithName )
	;; Add test to list of tests
	(if
		; Already exists in test list?
		(setq 
			existingTestWithName
			(assoc testName *ALU:allTests*))
		; If so, replace entry
		(subst
			(cons testName expressions)
			existingTestWithName
			*ALU:allTests*)
		; Else, add entry
		(setq 
			*ALU:allTests*
			(append 
				*ALU:allTests* 
				(cons testName expressions))))

	;; Add test to test suite list
	(if
		; Test suite already exists?
		(setq 
			existingTestSuite
			(assoc testSuite *ALU:testSuites*))
		; Add this test to the suite
		(setq
			*ALU:testSuites*
			(subst
				(cons 
					testSuite
					(append
						(cdr existingTestSuite)
						testName))
				existingTestSuite
				*ALU:testSuites*))
		; Else, add the suite and test
		(setq
			*ALU:testSuites*
			(append 
				*ALU:testSuites*
				(cons testSuite testName))))
	(princ))


;|
 | Runs a specific test.
 | @params: testName [string]
 | @output: Standard ALUnit output.
 |;

(defun runTest ( testName / )
	(ALU:resetTestInfo)
	(ALU:printOutputHeader)
	(foreach
		testExpression
		(cdr
			(assoc testName *ALU:allTests*))
		(eval testExpression))
	(ALU:printTestInfo)
	(print))


;|
 | Prints test info to the command line.
 | @output: Standard ALUnit test info output.
 |;

(defun ALU:printTestInfo ( / index )
	(setq index 0)
	(while
		(and *ALU:failMessages* (< index (length *ALU:failMessages*)))
		(princ
			(strcat
				(itoa (1+ index))
				") "
				(nth index *ALU:failMessages*)
				"\n"))
		(setq index (1+ index)))

	(princ "\n")
	(if
		(= index 0)
		(princ
			(strcat
				"OK ("
				(itoa *ALU:testsRun*)
				" tests run)"
				"\n"))
		(princ
			(strcat
				"FAILURES!!!"
				"\n"
				"Tests run: "
				(itoa *ALU:testsRun*)
				", failures: "
				(itoa (length *ALU:failMessages*)))))
		
	(print))



(princ "\n:: Test.lsp loaded ::")
(princ)
