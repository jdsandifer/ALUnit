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
 | Takes care of standard assert passing procedure.
 | @output: Calls ALU:printPassCode and increments *ALU:testsRun*
 | @return: Number of tests run.
 |;
 
(defun ALU:pass ( / )
	(ALU:printPassCode)
	(setq *ALU:testsRun*
		(1+ *ALU:testsRun*)))


;|		
 | Takes care of standard assert failing procedure.
 | @params: Failure message [string]
 | @output: Calls ALU:printFailCode, increments *ALU:testsRun*, and appends 
 |          fail message to *ALU:failureMessages*
 | @return: Number of tests run.
 |;

(defun ALU:fail ( failureMessage / )
	(ALU:printFailCode)
	(append
		*ALU:failureMessages*
		(list failureMessage))
	(setq
		*ALU:testsRun*
		(1+ *ALU:testsRun*)))


;|
 | Takes care of standard assert error procedure.
 | @params: Error message [string]
 | @output: Calls ALU:printErrorCode, increments *ALU:testsRun*, and appends 
 |          error message to *ALU:failureMessages*
 | @return: Number of tests run.
 |;

(defun ALU:error ( errorMessage / )
	(ALU:printErrorCode)
	(append
		*ALU:failureMessages*
		(list errorMessage))
	(setq
		*ALU:testsRun*
		(1+ *ALU:testsRun*)))


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
 | Adds an error message to the global failure list.
 | @params: error message [string]
 | @output: Appends errorMessage to globabl failure list.
 | @return: Nothing
 |;

(defun ALU:addFailure ( errorMessage / )
	(append *ALU:failureList* (list errorMessage))
	(princ))
	
	
;|
 | Checks if the expression evaluates to the same value as the expected value 
 | and records results. (Works like the equal function.)
 | @params: expected return value of expression, expression to test
 | @output: appropriate code for test result
 |;

(defun AssertEqual (expectedReturn expressionToTest / returnValueOrError)
	
	;; Catch any errors so testing proceeds through all tests
	(setq returnValueOrError
		(vl-catch-all-apply 
			(eval expressionToTest)))
	
	;; Print appropriate code for test result and 
	;; add a failure or error message to the global list.
	(cond
		(
			(vl-catch-all-error-p returnValueOrError)
			(ALU:printErrorCode)
			(ALU:addFailure
				(strcat
					(vl-princ-to-string expressionToTest)
					" caused an error - "
					(vl-catch-all-error-message returnValueOrError))))
		(
			(equal expectedReturn returnValueOrError)
			(ALU:printPassCode))
		(	
			T
			(ALU:printFailCode)
			(ALU:addFailure
				(strcat
					(vl-princ-to-string expressionToTest)
					" returned "
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

(defun AssertTrue (expressionToTest / )
		(AssertEqual T expressionToTest))
	

;|
 | Checks if the expression evaluates to nil and records results.
 | @params: expression to test
 | @output: appropriate code for test result
 |;

(defun AssertFalse (expressionToTest / )
		(AssertEqual nil expressionToTest))
	

;|
 | Checks if the expression doesn't evaluate to the same value as the expected
 | value and records results. (Works like the not & equal functions combined.)
 | @params: expected return value of expression, expression to test
 | @output: appropriate code for test result
 |;

(defun AssertNotEqual (expectedReturn expressionToTest / returnValueOrError)
	
	;; Catch any errors so testing proceeds through all tests
	(setq returnValueOrError
		(vl-catch-all-apply 
			(eval expressionToTest)))
	
	;; Print appropriate code for test result and 
	;; add a failure or error message to the global list.
	(cond
		(
			(vl-catch-all-error-p returnValueOrError)
			(ALU:printErrorCode)
			(ALU:addFailure
				(strcat
					(vl-princ-to-string expressionToTest)
					" caused an error - "
					(vl-catch-all-error-message returnValueOrError))))
		(
			(not (equal expectedReturn returnValueOrError))
			(ALU:printPassCode))
		(	
			T
			(ALU:printFailCode)
			(ALU:addFailure
				(strcat
					(vl-princ-to-string expressionToTest)
					" returned "
					(vl-princ-to-string returnValueOrError)
					" instead of "
					(vl-princ-to-string expectedReturn)
					"."))))
	(princ))
	

; TODO AssertEqualFuzz (equal with a rounding factor)
; TODO AssertNotEqualFuzz (not equal with a rounding factor)
; TODO AssertSameObject (use eq)
; TODO AssertNotSameObject (use not & eq)
	

(princ "\n:: Assert.lsp loaded ::")
(princ)
