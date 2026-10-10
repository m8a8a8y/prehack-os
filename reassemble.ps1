<# Verify both release parts and reconstruct the unchanged PreHackOSbv8.iso. #>
[CmdletBinding()]
param(
    [string]$Directory = $PSScriptRoot,
    [switch]$VerifyOnly
)

$ErrorActionPreference = 'Stop'
$isoName = 'PreHackOSbv8.iso'
$isoSize = [long]3570057216
$isoHash = 'dbd04756ddd02e9cf76b6779d3681be5ad34cfdec4f358ab460a40c260b689f8'
$parts = @(
    @{ Name = 'PreHackOSbv8.iso.part01'; Size = [long]1800000000; Hash = 'bc6d392f7aa397dd2fc4ab1c36645d44c9e8f5f94fbc8c25f488c0c674a43005' },
    @{ Name = 'PreHackOSbv8.iso.part02'; Size = [long]1770057216; Hash = '7894528d6909a900358821b0275ecf391d1b2adfc0d08c9767169baac4020824' }
)
$resolvedDirectory = (Resolve-Path -LiteralPath $Directory).Path
$outputPath = Join-Path $resolvedDirectory $isoName
if ((Test-Path -LiteralPath $outputPath) -and -not $VerifyOnly) {
    throw "Refusing to overwrite existing file: $outputPath"
}
foreach ($part in $parts) {
    $partPath = Join-Path $resolvedDirectory $part.Name
    if ((Get-Item -LiteralPath $partPath).Length -ne $part.Size) {
        throw "Incorrect size: $($part.Name). Download this part again."
    }
    if ((Get-FileHash -LiteralPath $partPath -Algorithm SHA256).Hash.ToLowerInvariant() -ne $part.Hash) {
        throw "Checksum mismatch: $($part.Name). Download this part again."
    }
    Write-Output "Verified $($part.Name)"
}
if ($VerifyOnly) {
    Write-Output 'Both ISO parts are valid.'
    return
}
$created = $false
$outputStream = $null
try {
    $outputStream = [IO.File]::Open($outputPath, [IO.FileMode]::CreateNew, [IO.FileAccess]::Write, [IO.FileShare]::None)
    $created = $true
    foreach ($part in $parts) {
        $inputStream = [IO.File]::OpenRead((Join-Path $resolvedDirectory $part.Name))
        try { $inputStream.CopyTo($outputStream, 8388608) }
        finally { $inputStream.Dispose() }
    }
    $outputStream.Dispose()
    $outputStream = $null
    if ((Get-Item -LiteralPath $outputPath).Length -ne $isoSize) {
        throw 'Reconstructed ISO has an incorrect size.'
    }
    if ((Get-FileHash -LiteralPath $outputPath -Algorithm SHA256).Hash.ToLowerInvariant() -ne $isoHash) {
        throw 'The reconstructed image does not match the original ISO.'
    }
} catch {
    if ($null -ne $outputStream) { $outputStream.Dispose(); $outputStream = $null }
    if ($created) { Remove-Item -LiteralPath $outputPath -Force }
    throw
} finally {
    if ($null -ne $outputStream) { $outputStream.Dispose() }
}
Write-Output "Created and verified $outputPath"
Write-Output "SHA-256: $isoHash"
