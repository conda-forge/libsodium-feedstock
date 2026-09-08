@echo on

if "%target_platform%" == "win-arm64" (
  set SODIUM_PLATFORM=ARM64
) else if "%ARCH%" == "32" (
  set SODIUM_PLATFORM=Win32
) else (
  set SODIUM_PLATFORM=x64
)


cd /d %SRC_DIR%\builds\msvc\vs%VS_YEAR%\
msbuild libsodium.sln /p:Configuration=DynRelease /p:Platform=%SODIUM_PLATFORM%
if errorlevel 1 exit 1
set ARTIFACTS_DIR=%SRC_DIR%\bin\%SODIUM_PLATFORM%\Release\v143

if not exist %ARTIFACTS_DIR%\dynamic\libsodium.dll    exit 1
if not exist "%LIBRARY_LIB%" mkdir %LIBRARY_LIB%

move /y %ARTIFACTS_DIR%\dynamic\libsodium.dll %LIBRARY_BIN%
move /y  %ARTIFACTS_DIR%\dynamic\libsodium.lib %LIBRARY_LIB%
xcopy /s /y /i %SRC_DIR%\src\libsodium\include\sodium %LIBRARY_INC%\sodium
xcopy /s /y %SRC_DIR%\src\libsodium\include\sodium.h %LIBRARY_INC%\
