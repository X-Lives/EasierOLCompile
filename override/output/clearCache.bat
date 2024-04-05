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

cd animations && del /s /q cache.fcz && cd ..
cd categories && del /s /q cache.fcz && cd ..
cd objects && del /s /q cache.fcz && cd ..
cd sprites && del /s /q cache.fcz && cd ..
cd transitions && del /s /q cache.fcz && cd ..
cd sprites && del /s /q *cache.fcz && cd ..
cd sounds && del /s /q *cache.fcz && cd ..
pause