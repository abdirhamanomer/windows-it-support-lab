# Windows Network & DNS Troubleshooting — Read-only evidence collection
# This is a PERSONAL LEARNING LAB. It changes NO network or security settings.
# Output is intentionally PRIVATE and may contain device/network information.

$ErrorActionPreference = 'Continue'
$projectRoot = Split-Path -Parent $PSScriptRoot
$privatePath = Join-Path $projectRoot 'private-results'
New-Item -ItemType Directory -Path $privatePath -Force | Out-Null
$reportPath = Join-Path $privatePath 'diagnostics.txt'

$lines = New-Object System.Collections.Generic.List[string]
function Add-Section {
    param([string]$Title, [scriptblock]$Block)
    $lines.Add('')
    $lines.Add('=== ' + $Title + ' ===')
    try {
        $result = & $Block 2>&1 | Out-String -Width 150
        $lines.Add($result.TrimEnd())
    } catch {
        $lines.Add('Check unavailable: ' + $_.Exception.Message)
    }
}

$lines.Add('PRIVATE WINDOWS IT LAB REPORT — DO NOT UPLOAD TO GITHUB')
$lines.Add('Collected: ' + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))

Add-Section 'Operating system' { Get-CimInstance Win32_OperatingSystem | Select-Object Caption, Version, OSArchitecture }
Add-Section 'Network adapters' { Get-NetAdapter | Select-Object Name, Status, LinkSpeed | Format-Table -AutoSize }
Add-Section 'IP configuration (PRIVATE)' { Get-NetIPConfiguration | Format-List }
Add-Section 'DNS: example.com (expected to resolve)' { Resolve-DnsName example.com -Type A -DnsOnly }
Add-Section 'HTTPS: example.com port 443' { Test-NetConnection -ComputerName example.com -Port 443 -InformationLevel Detailed }
Add-Section 'DNS: example.invalid (expected NOT to resolve)' { Resolve-DnsName example.invalid -Type A -DnsOnly -ErrorAction Continue }
Add-Section 'Windows services' { Get-Service -Name EventLog, Dhcp, Dnscache -ErrorAction SilentlyContinue | Select-Object Name, Status, StartType | Format-Table -AutoSize }
Add-Section 'Recent System log event summaries (optional)' {
    Get-WinEvent -FilterHashtable @{LogName='System'; StartTime=(Get-Date).AddDays(-1); Level=2,3} -MaxEvents 5 -ErrorAction SilentlyContinue |
        Select-Object TimeCreated, Id, ProviderName, LevelDisplayName | Format-Table -AutoSize
}
$lines | Set-Content -Path $reportPath -Encoding UTF8
Write-Host 'Diagnostics complete. Private results saved to:' -ForegroundColor Green
Write-Host $reportPath
Write-Host 'IMPORTANT: Do NOT upload private-results or raw reports to GitHub.' -ForegroundColor Yellow
