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
 | *ALU:startTime* - milliseconds since boot time for start of testing
 | *ALU:currentTestName* - name of test currently running
 |; 


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
		(setq 
			*ALU:allTests*
			(subst
				(cons testName expressions)
				existingTestWithName
				*ALU:allTests*))
		; Else, add entry
		(setq 
			*ALU:allTests*
			(append 
				*ALU:allTests* 
				(list (cons testName expressions)))))

	;; Add test to test suite list
	(if
		; Test suite already exists?
		(setq 
			existingTestSuite
			(assoc testSuite *ALU:testSuites*))
			
		
		(if
			; Test not already in suite?
			; (If it's already there, the name will refer to the new test - 
			;  no need to re-add it.)
			(not
				(member testName existingTestSuite))
			
			; Add this test to the suite
			(setq
				*ALU:testSuites*
				(subst
					(cons 
						testSuite
						(append
							(cdr existingTestSuite)
							(list testName)))
					existingTestSuite
					*ALU:testSuites*)))
					
		; If test suite doesn't exist, add the suite and test
		(setq
			*ALU:testSuites*
			(append 
				*ALU:testSuites*
				(list (cons testSuite (list testName))))))
	(princ))


;|
 | Runs a specific test suite.
 | @params: testSuiteName [string]
 | @output: Standard ALUnit output.
 |;

(defun runTestSuite ( testSuiteName / testSuite)
	(if
		(setq
			testSuite
			(assoc
				testSuiteName
				*ALU:testSuites*))
				
		(progn
			(ALU:resetTestInfo)
			(ALU:printOutputHeader)
			(ALU:startTimer)
			(mapcar
				'(lambda (testName)
					(setq *ALU:currentTestName* testName)
					(eval
						(cdr
							(assoc testName *ALU:allTests*))))
				(cdr testSuite))
			(ALU:printElapsedTime)
			(ALU:printTestInfo))
		
		(princ
			(strcat
				"\nNo test suite named \""
				testSuiteName
				"\".")))
	(princ))


;|
 | Runs a specific test.
 | @params: testName [string]
 | @output: Standard ALUnit output.
 |;

(defun runTest ( testName )
	(ALU:resetTestInfo)
	(ALU:printOutputHeader)
	(ALU:startTimer)
	(setq *ALU:currentTestName* testName)
	(eval
		(cdr
			(assoc testName *ALU:allTests*)))
	(ALU:printElapsedTime)
	(ALU:printTestInfo)
	(print))


;|
 | Removes all tests so they can be defined again.
 | @output: Removes test lists.
 |;

(defun removeAllTests ( / )
	(setq *ALU:allTests* '())
	(setq *ALU:testSuites* '())
	(princ "\nAll ALUnit tests have been removed.")
	(print))


;|
 | Resets test counter and list of fail messages.
 | @output: Resets variables for the above items.
 |;
 
(defun ALU:resetTestInfo ( / )
	(setq *ALU:testsRun* 0)
	(setq *ALU:failMessages* '())
	(princ))


;|
 | Prints ALUnit header to the command line.
 | @output: Header info
 |;
 
(defun ALU:printOutputHeader ( / )
	(setq ALU:version "1.0")
	(princ
		(strcat
			"\n"
			"ALUnit version "
			ALU:version
			"\n"))
	(princ))


;|
 | Starts function timer.
 | @output: Header info
 |;
 
(defun ALU:startTimer ( / )
	(setq 
		*ALU:startTime*
		(getvar "millisecs"))
	(princ))


;|
 | Prints elapsed time to command line.
 | @output: Elapsed time in milliseconds.
 |;
 
(defun ALU:printElapsedTime ( / DECIMAL_FORMAT ZERO_DECIMAL_PLACES)
	(setq DECIMAL_FORMAT 2
			ZERO_DECIMAL_PLACES 0)
	(princ
		(strcat
			"\nTime: "
			(rtos
				(-
					(getvar "millisecs")
					*ALU:startTime*)
				DECIMAL_FORMAT
				ZERO_DECIMAL_PLACES)
			" ms"))
			
	(princ))


;|
 | Prints test info to the command line.
 | @output: Standard ALUnit test info output.
 |;

(defun ALU:printTestInfo ( / index )
	(princ "\n")
	
	(setq index 0)
	(while
		(and *ALU:failMessages* (< index (length *ALU:failMessages*)))
		(princ
			(strcat
				(itoa (1+ index))
				". "
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
				", Failures: "
				(itoa (length *ALU:failMessages*)))))
		
	(print))



(princ "\n:: Test.lsp loaded ::")
(princ)
