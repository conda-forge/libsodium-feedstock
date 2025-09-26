@echo on

if "%ARCH%" == "32" (
  set ARCH=Win32
) else (
  set ARCH=x64
)


cd /d %SRC_DIR%\builds\msvc\vs%VS_YEAR%\
msbuild libsodium.sln /p:Configuration=StaticRelease /p:Platform=%ARCH%
if errorlevel 1 exit 1
set ARTIFACTS_DIR=%SRC_DIR%\bin\%ARCH%\Release\v143

move /y %ARTIFACTS_DIR%\static\libsodium.lib %LIBRARY_LIB%\libsodium_static.lib