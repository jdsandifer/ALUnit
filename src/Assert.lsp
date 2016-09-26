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



; Takes care of standard assert passing procedure.
; @output: Calls ALU:printPassCode and increments *ALU:testsRun*
; @return: Number of tests run.

(defun ALU:pass ( / )
	(ALU:printPassCode)
	(setq *ALU:testsRun*
		(1+ *ALU:testsRun*)))



; Takes care of standard assert failing procedure.
; @params: Failure message [string]
; @output: Calls ALU:printFailCode, increments *ALU:testsRun*, and appends 
;          fail message to *ALU:failureMessages*
; @return: Number of tests run.

(defun ALU:fail ( failureMessage / )
	(ALU:printFailCode)
	(append
		*ALU:failureMessages*
		(list failureMessage))
	(setq
		*ALU:testsRun*
		(1+ *ALU:testsRun*)))



; Takes care of standard assert error procedure.
; @params: Error message [string]
; @output: Calls ALU:printErrorCode, increments *ALU:testsRun*, and appends 
;          error message to *ALU:failureMessages*
; @return: Number of tests run.

(defun ALU:error ( errorMessage / )
	(ALU:printErrorCode)
	(append
		*ALU:failureMessages*
		(list errorMessage))
	(setq
		*ALU:testsRun*
		(1+ *ALU:testsRun*)))



; Prints code for passing to the command line
; @output: Prints "." to command line
; @return: Nothing

(defun ALU:printPassCode ( / )
	(princ ".")
	(princ))



; Prints code for failing to the command line
; @output: Prints "X" to command line
; @return: Nothing

(defun ALU:printFailCode ( / )
	(princ "X")
	(princ))



; Prints code for passing to the command line
; @output: Prints "F" to command line
; @return: Nothing

(defun ALU:printErrorCode ( / )
	(princ "E")
	(princ))



; Checks if function operates as expected and records results.
; @params: expected return value of expression, expression to test
; @output: "." for success, or error or failure message
; @return: string with failure or error message, or nil if successful

(defun AssertEquals (expectedReturn expressionToTest							
							/ functionReturnOrError failureOutput)
	; Catch any errors so testing proceeds through all tests
	(setq functionReturnOrError
		(vl-catch-all-apply 
			(eval expressionToTest)))
	
	; Print appropriate code for test result and 
	; add a failure / error message to.
	(cond
		(
			(vl-catch-all-error-p functionReturnOrError)
			(ALU:printErrorCode)
			(ALU:addError)
		(
			(equal expectedReturn functionReturnOrError)
			(princ ".")
			(setq failureOutput nil))
		(	
			T
			(princ "X")
			(setq failureOutput
				(strcat
					"("
					(vl-princ-to-string functionName)
					" "
					(vl-string-subst "" ")"
						(vl-string-subst "" "("
							(vl-princ-to-string argumentList)))
					") returned "
					(vl-princ-to-string functionReturnOrError)
					" instead of "
					(vl-princ-to-string expectedReturn)
					"."))))
	failureOutput)
	
	
	
(vl-load-com)
(princ "\n:: Assert.lsp loaded ::")
(princ)
