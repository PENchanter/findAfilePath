@ECHO OFF
CALL :FindNow \ BACKUP
::            ^ ^^^^^^ = parameter %1 = BACKUP
::            ^ pathname to begin search for file

:: TEST FILE NAME     : BACKUPlocation.txt
::                      ^^^^^^ keyword (from 'CALL' line above)
:: TEST FILE LOCATION : D:\Folder\Test\
::                      ^^^^^^^^^^^^^^^ path where TEST FILE is (hopefully) found

:: test for success/failure
IF NOT "%_locatethis%"=="File Not Found" ECHO ** File '%_locatefile%location.txt' found in '%_locatethis%' **
:: i.e.: '%BACKUP%' ('keyword' from above)

:: the following line of code is all that fails...
::  %_locatethis% does not test true for    "File Not Found" when no search results are found
IF "%_locatethis%"=="File Not Found" ECHO. * File Not Found!!! *
:: i.e.: '%BACKUP%' ('keyword' from above)

PAUSE

EXIT /B
:: and for redundancy sake...
GOTO :EOF

:FindNow
:: set variable '_locatethis' to keyword from above
:: purpose is to use this keyword to set another
:: variable using this keyword as its name
SET "_searchthis=%1"
SET "_locatethis=%2"

:: a FOR/LOOP to search for a filename matching 'keyword' from above
:: starting from directory\pathname '%1' and looking through all its subdirectories
FOR /f "tokens=*" %%A IN ('DIR "%_searchthis%%_locatethis%location.txt" /b /s /a 2^>nul') DO SET _result=%%~dpA
::     should resolve to: 'DIR "\BACKUPlocation.txt" /b /s /a'
:: which should locate 'BACKUPlocation.txt' in 'D:\Folder\Test\' subdirectory
:: storing this pathname in variable 'BACKUP'('keyword' from above)
:: %_result% = D:\Folder\Test\     : variable to store (last) pathname of file, IF FOUND
:: %BACKUP%  = D:\Folder\Test\     : set variable name (using keyword) to pathname
SET "%_locatefile%=%_locatethis%"  : preserve 'keyword' in another variable
SET "%_locatethis%=%_result%"
ECHO Result: var '_locatethis' = var name '%_locatethis%' = pathname '%_result%'

EXIT /B
