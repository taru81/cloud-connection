REM Runs the Android build for java source files

REM Build in release mode
REM call ant release

REM Build in debug mode
SET ANDROID_HOME=%ADTROOT%\sdk
ant debug

PAUSE