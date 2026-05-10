param(
    # ~/.agents/ is the shared staging area from `npx skills --global`.
    # It is NOT agent-specific — all agents download skills here.
    [string]$AgentsDir = "$env:USERPROFILE\.agents",
    [switch]$Force = $false
)

$skillsPath = Join-Path $AgentsDir "skills"
if (-not (Test-Path $AgentsDir)) {
    Write-Host "Directory not found: $AgentsDir" -ForegroundColor Red
    exit 1
}

$skillCount = 0
if (Test-Path $skillsPath) {
    $skillCount = (Get-ChildItem -Directory $skillsPath).Count
}

Write-Host "Target: $AgentsDir" -ForegroundColor Cyan
Write-Host "Skills subdirs: $skillCount" -ForegroundColor Cyan
Write-Host "Warning: This folder may be shared by other tools (GitHub Copilot, Cline, etc.)" -ForegroundColor Yellow
Write-Host ""

if (-not $Force) {
    $confirm = Read-Host "Delete entire $AgentsDir ? [y/N]"
    if ($confirm -ne "y" -and $confirm -ne "Y") {
        Write-Host "Cancelled." -ForegroundColor Yellow
        exit 0
    }
}

try {
    Remove-Item -Recurse -Force $AgentsDir
    Write-Host "[✓] Deleted: $AgentsDir" -ForegroundColor Green
} catch {
    Write-Host "[✗] Failed to delete: $_" -ForegroundColor Red
    exit 1
}
