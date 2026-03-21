# =============================================
# Fresh - Ejecutar scripts SQL (Windows/PowerShell)
# =============================================
# Uso:
#   .\run.ps1
#   .\run.ps1 tables/01_users.sql
#   .\run.ps1 seeds/01_categories.sql
# =============================================

param(
    [string]$SqlFile = "init.sql"
)

$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Conexion a Neon PostgreSQL
if (-not $env:DB_HOST -or [string]::IsNullOrWhiteSpace($env:DB_HOST)) {
    $env:DB_HOST = "ep-bitter-wildflower-amdy6uti-pooler.c-5.us-east-1.aws.neon.tech"
}
if (-not $env:DB_NAME -or [string]::IsNullOrWhiteSpace($env:DB_NAME)) {
    $env:DB_NAME = "dbfresh"
}
if (-not $env:DB_USER -or [string]::IsNullOrWhiteSpace($env:DB_USER)) {
    $env:DB_USER = "neondb_owner"
}
if (-not $env:DB_SSLMODE -or [string]::IsNullOrWhiteSpace($env:DB_SSLMODE)) {
    $env:DB_SSLMODE = "require"
}

if (-not $env:DB_PASSWORD -or [string]::IsNullOrWhiteSpace($env:DB_PASSWORD)) {
    Write-Host "Error: Falta la variable DB_PASSWORD" -ForegroundColor Red
    Write-Host ""
    Write-Host "Uso:" -ForegroundColor Yellow
    Write-Host "  `$env:DB_PASSWORD='tu_password'; .\run.ps1"
    Write-Host "  `$env:DB_PASSWORD='tu_password'; .\run.ps1 tables/01_users.sql"
    exit 1
}

$targetFile = Join-Path $scriptDir $SqlFile
if (-not (Test-Path $targetFile)) {
    Write-Host "Error: No se encontro el archivo $SqlFile" -ForegroundColor Red
    exit 1
}

$connection = "host=$($env:DB_HOST) dbname=$($env:DB_NAME) user=$($env:DB_USER) password=$($env:DB_PASSWORD) sslmode=$($env:DB_SSLMODE)"

Write-Host "=== Fresh Database ===" -ForegroundColor Cyan
Write-Host "  Host: $($env:DB_HOST)"
Write-Host "  Base: $($env:DB_NAME)"
Write-Host "  Script: $SqlFile"
Write-Host ""

Push-Location $scriptDir
try {
    psql $connection -f $SqlFile
}
finally {
    Pop-Location
}

Write-Host ""
Write-Host "=== Listo ===" -ForegroundColor Green
