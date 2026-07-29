<#
.SYNOPSIS
    Stamps a version across the design system's source files.

.DESCRIPTION
    The VERSION file at the repo root is the single source of truth. This script
    propagates it into the places a deployed copy can be read from without git:

      1. The /*! ... */ banner on the first line of each CSS/JS file.
      2. The --ds-version custom property in colors_and_type.css's :root block.

    Run it, review the diff, commit. Deployment stays a pure copy, so a deployed
    folder is byte-identical to the tagged source.

.PARAMETER Version
    New semver to set (e.g. 1.1.0). Omit to re-stamp using the current VERSION
    file — useful after adding a file, or to repair drift.

.EXAMPLE
    ./tools/Set-Version.ps1 1.1.0
.EXAMPLE
    ./tools/Set-Version.ps1 -WhatIf
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Position = 0)]
    [ValidatePattern('^\d+\.\d+\.\d+(-[A-Za-z0-9.]+)?$')]
    [string] $Version
)

$ErrorActionPreference = 'Stop'
$repo = Split-Path $PSScriptRoot -Parent
$versionFile = Join-Path $repo 'VERSION'

if (-not $Version) {
    if (-not (Test-Path $versionFile)) { throw "No -Version given and no VERSION file at $versionFile" }
    $Version = (Get-Content $versionFile -Raw).Trim()
    if (-not $Version) { throw "VERSION file is empty" }
    Write-Host "Re-stamping existing version $Version" -ForegroundColor Cyan
}

# Files that carry the banner. Add new shipped CSS/JS here.
$stamped = @(
    'colors_and_type.css'
    'components.css'
    'styles.css'
    'editorial.css'
    'fluent-icon.js'
)

$bannerRe = '^/\*!\s*BMO SharePoint Design System.*?\*/\r?\n'
$changed = 0

foreach ($name in $stamped) {
    $path = Join-Path $repo $name
    if (-not (Test-Path $path)) { Write-Warning "missing, skipped: $name"; continue }

    $text = Get-Content $path -Raw
    # Match the file's existing line endings — stamping must not rewrite EOLs,
    # which would leave a mixed-ending file and a diff on every single line.
    $eol = if ($text -match "`r`n") { "`r`n" } else { "`n" }
    $banner = "/*! BMO SharePoint Design System `u{00B7} v$Version `u{00B7} $name */$eol"

    $new = if ($text -match $bannerRe) {
        [regex]::Replace($text, $bannerRe, $banner, 'Singleline')
    } else {
        $banner + $text
    }

    # colors_and_type.css additionally carries the runtime-readable token.
    if ($name -eq 'colors_and_type.css') {
        if ($new -notmatch '--ds-version:') {
            throw "colors_and_type.css has no --ds-version declaration to update. Add it inside :root first."
        }
        $new = [regex]::Replace($new, '--ds-version:\s*"[^"]*";', "--ds-version: `"$Version`";")
    }

    if ($new -ne $text) {
        if ($PSCmdlet.ShouldProcess($name, "stamp v$Version")) {
            # No BOM: SharePoint serves these as-is and a BOM can leak into the page.
            [IO.File]::WriteAllText($path, $new, [Text.UTF8Encoding]::new($false))
            Write-Host "  stamped  $name" -ForegroundColor Green
            $changed++
        }
    } else {
        Write-Host "  current  $name" -ForegroundColor DarkGray
    }
}

if ($PSCmdlet.ShouldProcess('VERSION', "write $Version")) {
    [IO.File]::WriteAllText($versionFile, "$Version`n", [Text.UTF8Encoding]::new($false))
}

Write-Host ""
Write-Host "Version $Version — $changed file(s) updated." -ForegroundColor Cyan
Write-Host "Review the diff and commit; consider: git tag v$Version" -ForegroundColor DarkGray
