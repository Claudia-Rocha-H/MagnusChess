param(
    [string]$QtPrefix = ""
)

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $PSScriptRoot

if ([string]::IsNullOrWhiteSpace($QtPrefix)) {
    $qtVersions = Get-ChildItem "C:\Qt" -Directory -ErrorAction SilentlyContinue |
        Sort-Object Name -Descending

    foreach ($version in $qtVersions) {
        $candidate = Join-Path $version.FullName "msvc2022_64"
        if (Test-Path $candidate) {
            $QtPrefix = $candidate
            break
        }
    }
}

if ([string]::IsNullOrWhiteSpace($QtPrefix) -or -not (Test-Path $QtPrefix)) {
    throw "Qt MSVC kit not found. Pass -QtPrefix with a valid path, for example C:\Qt\6.11.0\msvc2022_64"
}

$devShell = "C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\Common7\Tools\Launch-VsDevShell.ps1"
if (Test-Path $devShell) {
    & $devShell -Arch amd64 -HostArch amd64 | Out-Null
}

$qtPrefixCmake = $QtPrefix.Replace("\\", "/")
$qtBin = Join-Path $QtPrefix "bin"
$windeployqt = Join-Path $qtBin "windeployqt.exe"
$exePath = Join-Path $repoRoot "build\MagnusChess.exe"

if (-not (Test-Path $windeployqt)) {
    throw "windeployqt was not found at $windeployqt"
}

Push-Location $repoRoot
try {
    cmake -S . -B build -DMAGNUSCHESS_BUILD_UI=ON "-DCMAKE_PREFIX_PATH=$qtPrefixCmake"
    cmake --build build

    $env:Path = "$qtBin;$env:Path"
    & $windeployqt --qmldir ".\src\ui\qml" $exePath | Out-Null
    & $exePath
}
finally {
    Pop-Location
}
