;|
 | Copyright (c) 2016, J.D. Sandifer
 | All rights reserved.
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
(princ
   (strcat
      "\n:: ASSERT.lsp loaded. | \\U+00A9 J.D. Sandifer "
      (menucmd "m=$(edtime,0,yyyy)")
      " ::"))
(princ)



;; Copyright (c) 2016, J.D. Sandifer
;; All rights reserved.
;;
;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions are
;; met:
;;
;;  - Redistributions of source code must retain the above copyright
;;    notice, this list of conditions and the following disclaimer.
;;
;;  - Redistributions in binary form must reproduce the above copyright
;;    notice, this list of conditions and the following disclaimer in the
;;    documentation and/or other materials provided with the distribution.
;;
;;  - Neither the name of J.D. Sandifer, nor autolisp-unit, nor the names
;;    of its contributors may be used to endorse or promote products
;;    derived from this software without specific prior written permission.
;;
;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
;; "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
;; LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
;; A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
;; OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
;; SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
;; LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
;; DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
;; THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
;; (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
;; OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE