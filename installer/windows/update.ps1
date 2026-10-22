$ErrorActionPreference = "Stop"
$Owner = "amiraliamarloo93"
$Repository = "Parsian-Python"
$ApiUrl = "https://api.github.com/repos/$Owner/$Repository/releases/latest"

Write-Host "Checking for a Parsian-Python update..."
try {
    $release = Invoke-RestMethod -Uri $ApiUrl -Headers @{ "Accept" = "application/vnd.github+json"; "User-Agent" = "Parsian-Python-Updater" }
} catch {
    throw "Could not read the latest release. Details: $($_.Exception.Message)"
}

$asset = $release.assets | Where-Object { $_.name -match '^parsian_python-.*\.whl$' } | Select-Object -First 1
if (-not $asset) {
    throw "No installable wheel was found in the latest release."
}

$pythonLauncher = Get-Command py -ErrorAction SilentlyContinue
if ($pythonLauncher) {
    & py -3 -m pip install --user --upgrade $asset.browser_download_url
} else {
    $python = Get-Command python -ErrorAction SilentlyContinue
    if (-not $python) { throw "Python 3.10 or newer is required." }
    & python -m pip install --user --upgrade $asset.browser_download_url
}
if ($LASTEXITCODE -ne 0) { throw "Update failed. Check the Python and pip installation." }
Write-Host "Parsian-Python update completed." -ForegroundColor Green
