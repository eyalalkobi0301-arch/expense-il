# ExpenseIL Setup Script
# Creates desktop shortcuts for the app and Excels folder

$Desktop = [Environment]::GetFolderPath('Desktop')
$AppDir = Join-Path $Desktop 'ExpensesIL'
$AppFile = Join-Path $AppDir 'ExpenseIL.html'
$ExcelsDir = Join-Path $AppDir 'Excels'

# 1. Verify app exists
if (-not (Test-Path $AppFile)) {
    Write-Host ""
    Write-Host "  [ERROR] ExpenseIL.html not found in ExpensesIL folder" -ForegroundColor Red
    Write-Host "  Expected: $AppFile"
    exit 1
}
Write-Host "  [OK] App found: ExpenseIL.html" -ForegroundColor Green

# 2. Ensure Excels folder exists
if (-not (Test-Path $ExcelsDir)) {
    New-Item -ItemType Directory -Path $ExcelsDir | Out-Null
    Write-Host "  [OK] Excels folder created" -ForegroundColor Green
} else {
    Write-Host "  [OK] Excels folder exists" -ForegroundColor Green
}

# 3. Create desktop shortcut to the app
$ShortcutApp = Join-Path $Desktop 'ExpenseIL.lnk'
$ws = New-Object -ComObject WScript.Shell
$sc = $ws.CreateShortcut($ShortcutApp)
$sc.TargetPath = $AppFile
$sc.WorkingDirectory = $AppDir
$sc.Save()

if (Test-Path $ShortcutApp) {
    Write-Host "  [OK] Desktop shortcut created: ExpenseIL" -ForegroundColor Green
} else {
    Write-Host "  [!] Failed to create app shortcut" -ForegroundColor Yellow
}

# 4. Create desktop shortcut to Excels folder
$ShortcutExcels = Join-Path $Desktop 'ExpenseIL-Excels.lnk'
$sc2 = $ws.CreateShortcut($ShortcutExcels)
$sc2.TargetPath = $ExcelsDir
$sc2.Save()

if (Test-Path $ShortcutExcels) {
    Write-Host "  [OK] Desktop shortcut created: ExpenseIL-Excels" -ForegroundColor Green
} else {
    Write-Host "  [!] Failed to create Excels shortcut" -ForegroundColor Yellow
}

# 5. Summary
Write-Host ""
Write-Host "  ========================================" -ForegroundColor Cyan
Write-Host "  Setup complete!" -ForegroundColor Cyan
Write-Host "  ========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Desktop shortcuts created:"
Write-Host "    * ExpenseIL        - opens the app"
Write-Host "    * ExpenseIL-Excels - folder for XLSX files"
Write-Host ""
Write-Host "  Next steps:"
Write-Host "    1. Double-click ExpenseIL on your desktop"
Write-Host "    2. Download XLSX files from your credit card site"
Write-Host "    3. Save them in the ExpenseIL-Excels folder"
Write-Host "    4. Use Coffee Morning Mode to auto-import"
Write-Host ""
