@echo off
REM Launch Abuse directly into editor mode with helper windows
pushd "%~dp0msvc-install"
start "" ".\abuse.exe" -edit
