$ErrorActionPreference = "Stop"
$Owner = "amiraliamarloo93"
$Repository = "Parsian-Python"
$ApiUrl = "https://api.github.com/repos/$Owner/$Repository/releases/latest"

Write-Host "Parsian-Python installer (experimental)" -ForegroundColor Cyan
Write-Host "Checking the latest public release..."

try {
    $release = Invoke-RestMethod -Uri $ApiUrl -Headers @{ "Accept" = "application/vnd.github+json"; "User-Agent" = "Parsian-Python-Installer" }
} catch {
    throw "Could not read the latest release. A public release may not have been published yet. Details: $($_.Exception.Message)"
}

$asset = $release.assets | Where-Object { $_.name -match '^parsian_python-.*\.whl$' } | Select-Object -First 1
if (-not $asset) {
    throw "The latest public release does not contain a Parsian-Python wheel yet. Check https://github.com/$Owner/$Repository/releases"
}

$pythonLauncher = Get-Command py -ErrorAction SilentlyContinue
if ($pythonLauncher) {
    & py -3 --version
    if ($LASTEXITCODE -ne 0) { throw "Python 3 was not found. Install Python 3.10 or newer first." }
    & py -3 -m pip install --user $asset.browser_download_url
} else {
    $python = Get-Command python -ErrorAction SilentlyContinue
    if (-not $python) { throw "Python 3.10 or newer is required. Install Python first." }
    & python --version
    if ($LASTEXITCODE -ne 0) { throw "Could not run Python." }
    & python -m pip install --user $asset.browser_download_url
}
if ($LASTEXITCODE -ne 0) { throw "pip installation failed." }
Write-Host "Parsian-Python installation completed." -ForegroundColor Green
Write-Host "Try: parsian path\to\program.pyfa"
