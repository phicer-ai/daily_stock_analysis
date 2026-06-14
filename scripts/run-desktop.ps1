$ErrorActionPreference = 'Stop'

$jsPackageManager = if ([string]::IsNullOrWhiteSpace($env:DSA_JS_PACKAGE_MANAGER)) { 'npm' } else { $env:DSA_JS_PACKAGE_MANAGER }
if (($jsPackageManager -ne 'npm') -and ($jsPackageManager -ne 'pnpm')) {
  throw "Unsupported DSA_JS_PACKAGE_MANAGER: $jsPackageManager. Use npm or pnpm."
}

Write-Host 'Building React UI (static assets)...'
Push-Location 'apps\dsa-web'
if (!(Test-Path 'node_modules')) {
  & $jsPackageManager install
  if ($LASTEXITCODE -ne 0) {
    throw "Frontend dependency installation failed with $jsPackageManager."
  }
}
& $jsPackageManager run build
if ($LASTEXITCODE -ne 0) {
  throw "Frontend build failed with $jsPackageManager."
}
Pop-Location

Write-Host 'Starting Electron desktop (dev mode)...'
Push-Location 'apps\dsa-desktop'
if (!(Test-Path 'node_modules')) {
  & $jsPackageManager install
  if ($LASTEXITCODE -ne 0) {
    throw "Desktop dependency installation failed with $jsPackageManager."
  }
}
& $jsPackageManager run dev
if ($LASTEXITCODE -ne 0) {
  throw "Desktop dev command failed with $jsPackageManager."
}
Pop-Location
