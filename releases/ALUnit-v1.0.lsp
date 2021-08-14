;| MIT License

Copyright (c) 2016 J.D. Sandifer

Permission is hereby granted, free of charge, to any person obtaining a copy of 
this software and associated documentation files (the "Software"), to deal in 
the Software without restriction, including without limitation the rights to 
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
of the Software, and to permit persons to whom the Software is furnished to do 
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all 
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE 
SOFTWARE.
|;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;##############################################################################;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;|
 | Copyright (c) 2016, J.D. Sandifer
 | See LICENSE above for use restrictions.
 |
 | Assert.lsp
 | Part of the ALUnit testing framework.
 |
 | Asserts are the basic checking function of ALUnit. They define what is
 | being tested about the functions under test. In this framework, all asserts
 | stand on their own - they should never be wrapped in NOT functions or 
 | otherwise negated or altered. Separate assert functions are provided for all
 | opposites.
 |
 | Testing works most effectively if asserts are part of a defined test.
 | See Test.lsp (included below) for more information about defining tests.
 |;

 
;|
 | Global variables used:
 | *ALU:testsRun*
 | *ALU:failMessages*
 |; 

;|
 | Takes care of standard assert passing procedure.
 | @output: Calls ALU:printPassCode and increments *ALU:testsRun*
 | @return: Number of tests run.
 |;
 
(defun ALU:pass ( / )
	(ALU:printPassCode)
	(ALU:incrementTestsRun))


;|		
 | Takes care of standard assert failing procedure.
 | @params: Failure message [string]
 | @output: Calls ALU:printFailCode, increments *ALU:testsRun*, and appends 
 |          fail message to *ALU:failureMessages*
 | @return: Number of tests run.
 |;

(defun ALU:fail ( failureMessage / )
	(ALU:printFailCode)
	(ALU:addFailMessage failureMessage)
	(ALU:incrementTestsRun))


;|
 | Takes care of standard assert error procedure.
 | @params: Error message [string]
 | @output: Calls ALU:printErrorCode, increments *ALU:testsRun*, and appends 
 |          error message to *ALU:failureMessages*
 | @return: Number of tests run.
 |;

(defun ALU:error ( errorMessage / )
	(ALU:printErrorCode)
	(ALU:addFailMessage errorMessage)
	(ALU:incrementTestsRun))


;|
 | Prints code for passing to the command line
 | @output: Prints "." to command line
 | @return: Nothing
 |;

(defun ALU:printPassCode ( / )
	(princ ".")
	(princ))


;|
 | Prints code for failing to the command line
 | @output: Prints "X" to command line
 | @return: Nothing
 |;

(defun ALU:printFailCode ( / )
	(princ "X")
	(princ))


;|
 | Prints code for passing to the command line
 | @output: Prints "E" to command line
 | @return: Nothing
 |;

(defun ALU:printErrorCode ( / )
	(princ "E")
	(princ))
	
	
;|
 | Adds one to total tests run.
 | @output: Adds one to global tests run counter.
 |;

(defun ALU:incrementTestsRun ( / )
	(if *ALU:testsRun*
		(setq
			*ALU:testsRun*
			(1+ *ALU:testsRun*))
		(setq *ALU:testsRun* 1))
	(princ))
	
	
;|
 | Adds an error / failure messages to the global list.
 | @params: failureMessage [string]
 | @output: Adds message to global list.
 |;

(defun ALU:addFailMessage ( failMessage / )
	(setq
		*ALU:failMessages*
		(append
			*ALU:failMessages*
			(list failMessage)))
	(princ))
	
	
;|
 | Checks if the expression evaluates to the same value as the expected value 
 | and records results. (Works like the equal function.)
 | @params: expectedReturn [a value], functionName [symbol], arguments [list]
 | @output: appropriate code for test result
 |;

(defun assertEqual (expectedReturn functionName arguments / returnValueOrError)
	
	;; Catch any errors so testing proceeds through all tests
	(setq returnValueOrError
		(vl-catch-all-apply
			functionName 
			arguments))
	
	;; Print appropriate code for test result and 
	;; add a failure or error message to the global list.
	(cond
		(
			(vl-catch-all-error-p returnValueOrError)
			(ALU:error
				(strcat
					*ALU:currentTestName*
					"("
					(vl-princ-to-string functionName)
					" "
					(vl-princ-to-string arguments)
					") caused an error - "
					(vl-catch-all-error-message returnValueOrError))))
		(
			(equal expectedReturn returnValueOrError)
			(ALU:pass))
		(	
			T
			(ALU:fail
				(strcat
					*ALU:currentTestName*
					"("
					(vl-princ-to-string functionName)
					" "
					(vl-princ-to-string arguments)
					") returned "
					(vl-princ-to-string returnValueOrError)
					" instead of "
					(vl-princ-to-string expectedReturn)
					"."))))
	(princ))


;|
 | Checks if the expression evaluates to true and records results.
 | @params: expression to test
 | @output: appropriate code for test result
 |;

(defun assertTrue (functionName arguments / )
		(assertEqual T functionName arguments))
	

;|
 | Checks if the expression evaluates to nil and records results.
 | @params: expression to test
 | @output: appropriate code for test result
 |;

(defun assertFalse (functionName arguments / )
		(assertEqual nil functionName arguments))
	

;|
 | Checks if the expression doesn't evaluate to the same value as the expected
 | value and records results. (Works like the not & equal functions combined.)
 | @params: expected return value of expression, expression to test
 | @output: appropriate code for test result
 |;

(defun assertNotEqual (expectedReturn functionName arguments 
							  / returnValueOrError)
	
	;; Catch any errors so testing proceeds through all tests
	(setq returnValueOrError
		(vl-catch-all-apply 
			functionName
			arguments))
	
	;; Print appropriate code for test result and 
	;; add a failure or error message to the global list.
	(cond
		(
			(vl-catch-all-error-p returnValueOrError)
			(ALU:error
				(strcat
					"("
					(vl-princ-to-string functionName)
					" "
					(vl-princ-to-string arguments)
					") caused an error - "
					(vl-catch-all-error-message returnValueOrError))))
		(
			(not (equal expectedReturn returnValueOrError))
			(ALU:pass))
		(	
			T
			(ALU:fail
				(strcat
					"("
					(vl-princ-to-string functionName)
					" "
					(vl-princ-to-string arguments)
					") returned "
					(vl-princ-to-string returnValueOrError)
					" instead of "
					(vl-princ-to-string expectedReturn)
					"."))))
	(princ))
	

; TODO assertEqualFuzz (equal with a rounding factor)
; TODO assertNotEqualFuzz (not equal with a rounding factor)
; TODO assertSameObject (use eq)
; TODO assertNotSameObject (use not & eq)
	

(princ "\n:: Assert.lsp loaded ::")
(princ)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;##############################################################################;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;|
 | Copyright (c) 2016, J.D. Sandifer
 | See LICENSE at top of file for use restrictions.
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
 | See Assert.lsp (included above) for more information about which asserts are available.
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
