<#
.SYNOPSIS
    Takes the design system live — copies the runtime files into a `bsp-design`
    folder under the destination you name.

.DESCRIPTION
    Deployment is a PURE COPY. Nothing is generated, minified, rewritten, or built,
    so the deployed tree is byte-identical to the source at the commit you deployed
    and can be diffed against a tag. The single exception is DEPLOY-INFO.txt, which
    records what landed and when.

    -Destination is the CONTAINER; the script creates `bsp-design` inside it. It
    defaults to the work machine's OneDrive-synced folder for the FCUPortal Code
    library:

        C:\dev\fcuportal-code\bsp-design\         -> /sites/FCUPortal/Code/bsp-design
        C:\dev\fcuportal-code\bsp-design\1.0.0\   (with -Versioned)

    If -Destination already ends in `bsp-design`, it is used as-is rather than
    nesting a second one.

    SHIPS      the CSS layers, the icon sprite, fluent-icon.js, everything in
               assets/ (logos SVG+PNG, the five bokeh variants SVG+JPG), and the
               SVGs of both asset libraries.
    DOES NOT   examples/, docs/, context/, tools/, index.html, every .md, and each
               library's catalog.json / index.html / README.md. Those are docs and
               authoring aids — they have no business on the server.

    Alpine is NOT in this repo and therefore NOT deployed. It lives with the other
    script libraries in the Code library's lib/ folder (alongside pnp2.bundle.js),
    a sibling of bsp-design/ rather than inside it.

.PARAMETER Destination
    Container folder that the deployment goes INSIDE. Defaults to the work machine's
    OneDrive-synced folder for the FCUPortal Code library, C:\dev\fcuportal-code,
    which surfaces as /sites/FCUPortal/Code. The container must already exist — the
    script creates only the `bsp-design` folder within it. Pass -Destination on any
    other machine (staging, a scratch dir).

.PARAMETER FolderName
    Override the deployed folder name. Defaults to `bsp-design`.

.PARAMETER Versioned
    Nest the payload one level deeper, in a folder named for the current VERSION —
    `bsp-design/1.0.0/`. Lets two versions coexist so consumers migrate by changing
    one link.

.PARAMETER SkipIllustrations
    Omit spot-illustrations/ (481 files, ~4.3 MB).

.PARAMETER SkipAbacusIcons
    Omit abacus-icons/ (712 files, ~3.9 MB).

.PARAMETER Clean
    Delete the target folder's contents first. Refuses on a non-empty folder that
    has no DEPLOY-INFO.txt, so a mistyped path cannot wipe an unrelated directory.

.PARAMETER AllowDirty
    Proceed even though the git working tree has uncommitted changes.

.EXAMPLE
    ./tools/Deploy-BspDesign.ps1 -WhatIf
    Previews:  C:\dev\fcuportal-code\bsp-design\

.EXAMPLE
    ./tools/Deploy-BspDesign.ps1 -Destination D:\staging -Versioned
    Deploys:   D:\staging\bsp-design\1.0.0\
#>
[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
param(
    [Parameter(Position = 0)]
    [string] $Destination = 'C:\dev\fcuportal-code',

    [string] $FolderName = 'bsp-design',
    [switch] $Versioned,
    [switch] $SkipIllustrations,
    [switch] $SkipAbacusIcons,
    [switch] $Clean,
    [switch] $AllowDirty
)

$ErrorActionPreference = 'Stop'
$repo = Split-Path $PSScriptRoot -Parent

# ---------------------------------------------------------------- manifest ---
$rootFiles = @(
    'colors_and_type.css'
    'components.css'
    'styles.css'
    'editorial.css'
    'fluent-icon.js'
    'fluent-basic-icons.svg'
)

# assets/ ships every image (logos SVG+PNG, bokeh SVG+JPG). The asset libraries
# ship SVG only — their catalog.json / index.html / README.md stay behind.
$assetFolders = @(
    @{ Name = 'assets';             Include = @('*.svg', '*.png', '*.jpg'); Skip = $false }
    @{ Name = 'spot-illustrations'; Include = @('*.svg');                   Skip = [bool]$SkipIllustrations }
    @{ Name = 'abacus-icons';       Include = @('*.svg');                   Skip = [bool]$SkipAbacusIcons }
)

# ----------------------------------------------------------- preflight -------
$versionFile = Join-Path $repo 'VERSION'
if (-not (Test-Path $versionFile)) { throw "No VERSION file at $versionFile. Run tools/Set-Version.ps1 first." }
$version = (Get-Content $versionFile -Raw).Trim()
if (-not $version) { throw "VERSION file is empty." }

# Guard: the stamped token must agree with VERSION, or prod misreports itself.
$tokens = Get-Content (Join-Path $repo 'colors_and_type.css') -Raw
if ($tokens -match '--ds-version:\s*"([^"]*)"') {
    if ($Matches[1] -ne $version) {
        throw "Version drift: VERSION says '$version' but colors_and_type.css is stamped '$($Matches[1])'. Run tools/Set-Version.ps1 and commit."
    }
} else {
    throw "colors_and_type.css has no --ds-version token. Run tools/Set-Version.ps1."
}

# Git context — informational, and a guard against shipping uncommitted work.
$sha = 'unknown'; $branch = 'unknown'; $isDirty = $false
if (Get-Command git -ErrorAction SilentlyContinue) {
    Push-Location $repo
    try {
        $sha     = (git rev-parse --short HEAD 2>$null)
        $branch  = (git rev-parse --abbrev-ref HEAD 2>$null)
        $isDirty = [bool](git status --porcelain 2>$null)
    } finally { Pop-Location }
}
if ($isDirty) {
    if ($AllowDirty) { Write-Warning "Working tree has uncommitted changes — deploying anyway (-AllowDirty)." }
    else { throw "Working tree has uncommitted changes. Commit them, or re-run with -AllowDirty." }
}

# ----------------------------------------------------- resolve target --------
# The container must already exist. On the work machine it is the OneDrive-synced
# folder that maps to the Code library; we create bsp-design INSIDE it, never the
# container itself — auto-creating it would silently deploy into a stray local
# folder that syncs nowhere, and report success.
if (-not (Test-Path -LiteralPath $Destination -PathType Container)) {
    throw ("Destination container not found: '$Destination'`n" +
           "On the work machine this is the OneDrive-synced folder for the Code library. " +
           "On any other machine pass -Destination explicitly, e.g. -Destination D:\staging.")
}

# Don't nest bsp-design inside bsp-design if the caller already pointed at it.
$leaf = Split-Path $Destination -Leaf
$target = if ($leaf -eq $FolderName) { $Destination } else { Join-Path $Destination $FolderName }
if ($Versioned) { $target = Join-Path $target $version }

Write-Host "Target: $target" -ForegroundColor Cyan

if ((Test-Path $target) -and $Clean) {
    $existing = @(Get-ChildItem -LiteralPath $target -Force)
    $looksLikeOurs = Test-Path (Join-Path $target 'DEPLOY-INFO.txt')
    if ($existing.Count -and -not $looksLikeOurs) {
        throw "Refusing -Clean: '$target' is not empty and has no DEPLOY-INFO.txt, so it may not be a deploy target. Clear it yourself if that is intended."
    }
    if ($PSCmdlet.ShouldProcess($target, "remove $($existing.Count) existing item(s)")) {
        $existing | Remove-Item -Recurse -Force
    }
}
if (-not (Test-Path $target)) {
    if ($PSCmdlet.ShouldProcess($target, 'create folder')) {
        New-Item -ItemType Directory -Path $target -Force | Out-Null
    }
}

# ----------------------------------------------------------- copy ------------
$copied = 0
$bytes = 0

foreach ($name in $rootFiles) {
    $src = Join-Path $repo $name
    if (-not (Test-Path $src)) { Write-Warning "missing, skipped: $name"; continue }
    if ($PSCmdlet.ShouldProcess($name, 'copy')) {
        Copy-Item -LiteralPath $src -Destination (Join-Path $target $name) -Force
    }
    $copied++; $bytes += (Get-Item $src).Length
}
Write-Host ("  {0,5} root files" -f $rootFiles.Count) -ForegroundColor Green

foreach ($folder in $assetFolders) {
    if ($folder.Skip) { Write-Host ("  {0,5} {1} (skipped)" -f '-', $folder.Name) -ForegroundColor DarkGray; continue }

    $srcDir = Join-Path $repo $folder.Name
    if (-not (Test-Path $srcDir)) { Write-Warning "missing, skipped: $($folder.Name)/"; continue }

    $files  = @(Get-ChildItem -LiteralPath $srcDir -Include $folder.Include -File -Recurse -Depth 0)
    $outDir = Join-Path $target $folder.Name
    if ($PSCmdlet.ShouldProcess("$($folder.Name)/", "copy $($files.Count) file(s)")) {
        New-Item -ItemType Directory -Path $outDir -Force | Out-Null
        foreach ($f in $files) { Copy-Item -LiteralPath $f.FullName -Destination (Join-Path $outDir $f.Name) -Force }
    }
    $copied += $files.Count
    $bytes  += ($files | Measure-Object Length -Sum).Sum
    Write-Host ("  {0,5} {1}/" -f $files.Count, $folder.Name) -ForegroundColor Green
}

# ----------------------------------------------------------- stamp -----------
$info = @"
BMO SharePoint Design System
version      : $version
deployed     : $((Get-Date).ToUniversalTime().ToString('yyyy-MM-dd HH:mm:ss')) UTC
commit       : $sha$(if ($isDirty) { ' (DIRTY — uncommitted changes were deployed)' })
branch       : $branch
deployed by  : $env:USERNAME on $env:COMPUTERNAME
files        : $copied
size         : $([math]::Round($bytes / 1MB, 2)) MB
illustrations: $(if ($SkipIllustrations) { 'excluded' } else { 'included' })
abacus icons : $(if ($SkipAbacusIcons) { 'excluded' } else { 'included' })

Link order (tokens before components; editorial only on editorial pages):
  colors_and_type.css -> components.css -> editorial.css

Verify the live page is on this version, from devtools:
  getComputedStyle(document.documentElement).getPropertyValue('--ds-version')

Alpine is not part of this deployment. It lives in the shared lib/ folder next to
this one (alongside pnp2.bundle.js), a sibling of bsp-design/.
"@

if ($PSCmdlet.ShouldProcess('DEPLOY-INFO.txt', 'write')) {
    [IO.File]::WriteAllText((Join-Path $target 'DEPLOY-INFO.txt'), $info, [Text.UTF8Encoding]::new($false))
}

# ----------------------------------------------------------- report ----------
Write-Host ""
Write-Host "Deployed v$version ($sha) -> $target" -ForegroundColor Cyan
Write-Host ("$copied files, {0} MB" -f [math]::Round($bytes / 1MB, 2)) -ForegroundColor Cyan
Write-Host "Files are on disk. If this is the synced folder, OneDrive still has to upload them — check the sync icon before calling it live." -ForegroundColor DarkGray

# Alpine lives with the other script libraries in the Code library's lib/ folder,
# a SIBLING of bsp-design/ — not inside it. Check there, next to pnp2.bundle.js.
$libDir = Join-Path (Split-Path $target -Parent) 'lib'
if (-not $WhatIfPreference) {
    $alpine = @(Get-ChildItem -LiteralPath $libDir -Filter 'alpine*.js' -File -ErrorAction SilentlyContinue)
    if (-not $alpine) {
        Write-Warning "No alpine*.js found in '$libDir'. Pages using Alpine will render but silently do nothing. Alpine is not deployed by this script - it belongs in the shared lib/ folder alongside pnp2.bundle.js."
    } else {
        Write-Host ("Alpine present: " + ($alpine.Name -join ', ') + " in lib/") -ForegroundColor DarkGray
    }
}
