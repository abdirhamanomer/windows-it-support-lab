# IT Support Incident Report — INC-001

**Type:** Simulated training incident — not a real employer ticket  
**Environment:** Personal Windows workstation (version: **[ADD VERSION]**)  
**Issue:** Website cannot be reached  
**Status:** **[Resolved for simulated case, if invalid-domain failure confirmed / In progress]**

## Scenario

A simulated user reports that `https://example.invalid` cannot be accessed. The objective is to check whether the issue reflects a general connectivity outage or an invalid hostname.

## Troubleshooting tests and findings

| Test | Command | Actual observation | Interpretation |
|---|---|---|---|
| Windows services | `Get-Service -Name Dhcp, Dnscache, EventLog -ErrorAction SilentlyContinue` | DHCP Client, DNS Client, Windows Event Log: all `Running` | Services were running when checked; this alone does not guarantee all network functions work. |
| Valid DNS lookup | `nslookup example.com` | DNS returned both IPv4 and IPv6 addresses. | The system successfully resolved the test hostname. |
| Invalid DNS lookup | `nslookup example.invalid` | **[INSERT THE EXACT FAILURE FROM YOUR CORRECTED SCREENSHOT]** | The `.invalid` suffix is deliberately reserved for invalid names. |
| HTTPS TCP connection | `Test-NetConnection -ComputerName example.com -Port 443` | `TcpTestSucceeded : True` via Wi-Fi | A TCP connection to the destination on port 443 succeeded. This is not a full test of the web application. |
| Network adapter and IP settings | `Get-NetAdapter` and `ipconfig` | **[FILL IN IF TESTED; OTHERWISE WRITE NOT RECORDED]** | **[FILL IN / NOT ASSESSED]** |
| Event Viewer | Windows Logs → System | **[FILL IN IF INSPECTED; OTHERWISE WRITE NOT INSPECTED]** | Unrelated system events should not be assumed to explain this incident. |

## Diagnosis

A valid hostname resolved successfully and a TCP connection to `example.com` on port 443 succeeded. If the corrected screenshot confirms that `example.invalid` failed to resolve, the results support an incorrect/nonexistent website address as the cause of the **simulated** request. They do not demonstrate a general DNS or internet outage.

## Recommended resolution and verification

Ask the simulated user to verify the exact URL with the person or organization that provided it, then retry a known-valid website. No firewall, DNS, or service settings needed to be changed for this controlled test. Record the corrected invalid-domain result above before marking the case resolved.

## Evidence

- `../evidence/01-dns-working.png` — valid DNS resolution
- `../evidence/02-dns-invalid.png` — complete failure message (confirm and redact)
- `../evidence/03-https-test.png` — successful TCP port 443 test
- `../evidence/04-services-or-eventviewer.png` — Windows services running

## Skills demonstrated

Windows PowerShell, Windows services, `nslookup`, DNS fundamentals, TCP connectivity testing, evidence collection, and technical incident documentation.
