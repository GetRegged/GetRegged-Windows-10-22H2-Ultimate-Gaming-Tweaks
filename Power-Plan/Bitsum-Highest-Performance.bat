REM Import GetRegged Power Plan
curl -g -k -L -# -o "%temp%\Bitsum-Highest-Performance.pow" "https://github.com/GetRegged/GetRegged-Windows-10-22H2-Ultimate-Gaming-Tweaks/raw/main/Power-Plan/bin/Bitsum-Highest-Performance.pow"
powercfg -import "%temp%\Bitsum-Highest-Performance.pow" 11111111-1111-1111-1111-111111111111
powercfg -setactive 11111111-1111-1111-1111-111111111111

echo Deleting other Power Plans
REM Delete Balanced Power Plan
powercfg -delete 381b4222-f694-41f0-9685-ff5bb260df2e

REM Delete Power Saver Power Plan
powercfg -delete a1841308-3541-4fab-bc81-f71556f20b4a

REM Delete High Performance Power Plan
powercfg -delete 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

REM Delete Ultimate Performance Power Plan
powercfg -delete e9a42b02-d5df-448d-aa00-03f14749eb61

REM Delete AMD Ryzen Balanced Power Plan
powercfg -delete 9897998c-92de-4669-853f-b7cd3ecb2790
