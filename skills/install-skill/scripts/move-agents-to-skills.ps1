param(
    [string]$AgentsDir = "$env:USERPROFILE\.agents\skills",
    # Target skills directory. Override for other agents:
    #   OpenCode (default):  "$env:USERPROFILE\.config\opencode\skills"
    #   Claude Code:         "$env:USERPROFILE\.claude\skills"
    #   Cursor:              "$env:USERPROFILE\.cursor\skills"
    #   Windsurf:            "$env:USERPROFILE\.windsurf\skills"
    #   CodeBuddy:           "$env:USERPROFILE\.codebuddy\skills"
    [string]$SkillsDir = "$env:USERPROFILE\.config\opencode\skills",
    [switch]$WhatIf = $false
)

$openspecMap = @{
    "openspec-proposal-creation"  = "openspec/openspec-propose"
    "openspec-implementation"     = "openspec/openspec-apply-change"
    "openspec-archiving"          = "openspec/openspec-archive-change"
    "openspec-context-loading"    = "openspec/openspec-explore"
}

function Get-TargetRelPath([string]$DirName) {
    if ($DirName -match '^obra-superpowers-(.+)$') {
        return "superpowers/$($matches[1])"
    }
    if ($openspecMap.ContainsKey($DirName)) {
        return $openspecMap[$DirName]
    }
    if ($DirName -match '^openspec-') {
        Write-Host "  [?] unknown openspec variant: $DirName, using as-is" -ForegroundColor Yellow
        return $DirName
    }
    return $DirName
}

if (-not (Test-Path $AgentsDir)) {
    Write-Host "Source not found: $AgentsDir" -ForegroundColor Red; exit 1
}

$moved = 0
foreach ($entry in Get-ChildItem -Directory $AgentsDir) {
    $srcName = $entry.Name
    $relPath = Get-TargetRelPath $srcName
    $dstDir = Join-Path $SkillsDir $relPath

    if (-not (Test-Path $dstDir)) {
        New-Item -ItemType Directory -Path $dstDir -Force | Out-Null
    }

    if ($WhatIf) {
        Write-Host "  [~] MOVE: $srcName -> $relPath" -ForegroundColor Cyan
    } else {
        Get-ChildItem -Path $entry.FullName | Move-Item -Destination $dstDir -Force
        Write-Host "  [✓] $srcName -> $relPath" -ForegroundColor Green
    }
    $moved++
}

Write-Host "`nDone. $moved skills moved." -ForegroundColor $(
    if ($moved -gt 0) { "Green" } else { "Yellow" }
)
