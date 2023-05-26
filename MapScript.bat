@echo off

REM ###########################################
REM Written by Anderson Lobo
REM ###########################################



echo ########## Deleting connected folders #########
echo ...
echo ...
echo ...
echo ...

net use * /delete /Y > NUL 2>&1





echo ############### Mapping shared folders ##############


set "FS=\\server\"

REM delayed expansion so it updates the variables
setlocal enabledelayedexpansion

REM up to 25 shared folders
set "share[0]=Share1"
set "share[1]=Share2"
set "share[2]=Share3"
set "share[3]=Share4"
set "share[4]=Share5"
set "share[5]=Share6"


set "letter[0]=A"
set "letter[1]=B"
set "letter[2]=C"
set "letter[3]=D"
set "letter[4]=E"
set "letter[5]=F"
set "letter[6]=G"
set "letter[7]=H"
set "letter[8]=I"
set "letter[9]=J"
set "letter[10]=K"
set "letter[11]=L"
set "letter[12]=M"
set "letter[13]=N"
set "letter[14]=O"
set "letter[15]=P"
set "letter[16]=Q"
set "letter[17]=R"
set "letter[18]=S"
set "letter[19]=T"
set "letter[20]=U"
set "letter[21]=V"
set "letter[22]=W"
set "letter[23]=X"
set "letter[24]=Y"
set "letter[25]=Z"


set "controller=1"


REM Map every folder in the shared folder vector
REM outputs is being throwed to NUL for redabillity
for /L %%i in (0,1,5) do (
    REM try shared folder permission
    icacls %FS%!share[%%i]! > NUL 2>&1
    if !errorlevel! equ 0 (
        net use !letter[%%i]!: %FS%!share[%%i]! > NUL 2>&1
        if !errorlevel! equ 0 (
            echo.
            echo.
            echo.
            echo !share[%%i]! mapped sucefully
            echo.
        ) else (

            set "controller=1"
            
            echo.
            echo.
            echo.
            echo Error mapping !share[%%i]!
            echo Trying to map again...

            REM If the drive letter is not available, then try the next letter
            for /L %%x in (0,1,26) do (
                if !controller! equ 1 (
                    net use !letter[%%x]!: %FS%!share[%%i]! > NUL 2>&1
                    if !errorlevel! equ 0 (
                        echo.
                        echo.
                        echo.
                        echo !share[%%i]! mapped sucefully
                        echo.
                        set "controller=0"
                    ) else (
                        REM do nothing and go back to loop
                    )
                )
            ) 
        )
    )
)



endlocal

REM reate / map a private folder to a user
REM it depends on the FS design
REM 'users' is the parent folder for the private folders
REM It is hardcoded to map on Z:
if exist %FS%users\%username% (
    echo ######## Mapping private folder #########
    echo ...
    echo ...
    echo.
    echo.
    net use Z: %FS%Users\%username% > NUL 2>&1
) else (
    echo.
    echo ######## Creating private folder ##########
    echo.
    mkdir %FS%Users\%username%
    if %errorlevel% equ 0 (
        echo.
        echo Private folder created sucefully
        echo Mapping private folder
        echo.
        net use Z: %FS%Users\%username% > NUL 2>&1
    )
)

pause
