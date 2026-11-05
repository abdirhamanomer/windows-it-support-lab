# Hands-on commands: Windows support ticket INC-001

**Use Windows PowerShell** on Windows 10 or 11. You do NOT need administrator access for the required checks. Run commands one by one and record the actual results; never invent output.

## 1. Check basic network configuration (read-only)
```powershell
Get-NetAdapter | Select-Object Name, Status, LinkSpeed
Get-NetIPConfiguration
ipconfig /all
```
Check whether your active adapter is connected and has an IP address/default gateway. **Do not publish the raw output of `ipconfig /all`; it contains identifying network information.** Write a safe summary instead.

## 2. Test known-good DNS resolution
```powershell
nslookup example.com
Resolve-DnsName example.com -Type A -DnsOnly
```
Expected on a functioning DNS setup: one or more addresses for `example.com`. Addresses change and must not be assumed. If this fails, note the result and investigate your own connectivity before concluding anything else.

## 3. Check the HTTPS port (not just ping)
```powershell
Test-NetConnection -ComputerName example.com -Port 443
```
Find `TcpTestSucceeded`. `True` suggests a TCP connection to HTTPS port 443 was possible; it does NOT prove full webpage functionality or application-layer success. `False` can occur for multiple reasons and is not proof of a DNS issue.

## 4. Reproduce the simulated URL failure (safe)
Open `https://example.invalid` in your browser. It is designed not to be a valid public hostname.
```powershell
nslookup example.invalid
Resolve-DnsName example.invalid -Type A -DnsOnly
```
Expected: name lookup fails or returns an NXDOMAIN/nonexistent-name style response. An error is the **expected observation** for this test.

## 5. Inspect services (read-only)
```powershell
Get-Service -Name EventLog, Dhcp, Dnscache -ErrorAction SilentlyContinue |
  Select-Object Name, Status, StartType
```
Note which services are running or stopped. A stopped service alone is NOT necessarily the cause of the simulated URL issue, and some systems restrict access to service properties.

## 6. Check Event Viewer (optional)
Press Win+R, type `eventvwr.msc`, press Enter. Open **Windows Logs > System**. Note the date, event source, and Event ID of any relevant recent warning/error. Avoid copying unrelated private log messages. A system may have unrelated events; do not claim they caused a DNS issue without evidence.

Optional PowerShell event summary:
```powershell
Get-WinEvent -FilterHashtable @{LogName='System'; StartTime=(Get-Date).AddDays(-1); Level=2,3} -MaxEvents 5 -ErrorAction SilentlyContinue |
  Select-Object TimeCreated, Id, ProviderName, LevelDisplayName
```
No events or access denied is not a project failure. Skip this section if needed.

## 7. Write a conclusion and support ticket
Compare the working-domain DNS and HTTPS checks with the deliberately invalid domain.
- If `example.com` resolves and port 443 connects, but `example.invalid` does not resolve: explain that the **supplied hostname is invalid** in this simulated ticket; advise confirming the correct URL.
- If both domains fail: the experiment did **not** isolate the root cause. Investigate the connection and resolver in a new ticket rather than falsely claiming a typo.
- If `example.com` resolves but HTTPS connection fails: name resolution alone is insufficient; further HTTPS/network troubleshooting is required.

Fill out `docs/support-ticket.md` with your **actual** findings.

## 8. Evidence screenshots
Press `Win+Shift+S`, select only the relevant part of the PowerShell window, and save each image under `evidence/`. Avoid capturing usernames, computer names, IP addresses, MAC addresses, SSIDs, unrelated applications or notifications. Leave your private diagnostic report unshared.

## 9. Optional script
Open PowerShell in your project folder, then run:
```powershell
.\scripts\diagnose.ps1
```
If execution is blocked by your computer's policy, **do not change security policies for this project**. Just complete the manual commands above.

The script saves a text report under `private-results/`, which is excluded by `.gitignore`. The report can contain sensitive host/network details; do not upload it manually.
