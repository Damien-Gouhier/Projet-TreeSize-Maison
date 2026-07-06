@echo off
title DiskAnalyzer - Compilation en .exe

:: Se placer dans le dossier du script AVANT tout appel a pyinstaller.
:: pushd gere aussi les chemins reseau (UNC) en montant un lecteur temporaire.
:: -> evite l'erreur "Do not run pyinstaller from C:\Windows\System32"
::    lorsque le .bat est lance en tant qu'administrateur.
pushd "%~dp0"

echo.
echo  ========================================
echo    Compilation DiskAnalyzer en .exe
echo  ========================================
echo.

:: Verification de Python
python --version >nul 2>&1
if errorlevel 1 (
    echo  [ERREUR] Python n'est pas installe ou pas dans le PATH.
    echo  Telechargez Python : https://www.python.org/downloads/
    popd
    pause
    exit /b 1
)

:: Verification / installation de PyInstaller
python -m pip show pyinstaller >nul 2>&1
if errorlevel 1 (
    echo  Installation de PyInstaller...
    python -m pip install pyinstaller
)

echo  Compilation en cours...
echo.

python -m PyInstaller --onefile --windowed --name "DiskAnalyzer" --clean "DiskAnalyzer.py"

echo.
if exist "dist\DiskAnalyzer.exe" (
    echo  [OK] Compilation reussie !
    echo  Fichier : "%CD%\dist\DiskAnalyzer.exe"
    echo.
    for %%A in ("dist\DiskAnalyzer.exe") do echo  Taille : %%~zA octets
) else (
    echo  [ERREUR] Compilation echouee.
)

echo.
popd
pause
