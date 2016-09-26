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
 

; Checks if function operates as expected and adds result to testList
; @params: expected return value of functions, function to test (symbol), 
;          argument(s) (list) to feed to function
; @output: "." for success, or error or failure message
; @return: string with failure or error message, or nil if successful

(defun AssertEqual (expectedReturn functionName argumentList 
						   / functionReturnOrError failureOutput)
	; Catch any errors so testing proceeds through all tests
	(setq functionReturnOrError
		(vl-catch-all-apply functionName argumentList))
	
	; Print '.', 'X', or 'E' based on success, failure, or error of function.
	; Return an appropriate output (failure/error) message - nil if success
	(cond
		(
			(vl-catch-all-error-p functionReturnOrError)
			(princ "E")
			(setq failureOutput
				(strcat 
					"* ("
					(vl-princ-to-string functionName)
					" "
					(vl-string-subst "" ")"
						(vl-string-subst "" "("
							(vl-princ-to-string argumentList)))
					") caused "(vl-catch-all-error-message functionReturnOrError))))
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
