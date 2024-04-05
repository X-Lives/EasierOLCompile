@echo off
cd windows

for /d %%d in (*) do (
    if not "%%d"=="" if not "%%d"=="." if not "%%d"==".." (
        echo %%d
    )
)

set /p "choice=Please select a subfolder: "

if not "%choice%"=="" (
    if exist "%choice%" (
        cd "%choice%"
    ) else (
        echo Invalid input
    )
) else (
    echo Invalid input
)


gdb -ex="set logging on debugOut.txt" -ex=r -ex=bt OneLife.exe