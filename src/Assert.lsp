;|
 | Copyright (c) 2016, J.D. Sandifer
 | See LICENSE file for use restrictions.
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
 | See Test.lsp for more information about defining tests.
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
 | @output: Prints "F" to command line
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
