@echo off
powershell -ExecutionPolicy Bypass -File Find-Suspects.ps1 -CommitSha %1
