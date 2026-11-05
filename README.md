# Windows Network Connectivity & DNS Troubleshooting Lab

> **Status: IN PROGRESS — replace placeholders with your real test results before publishing.**
>
> This is a **simulated support ticket** performed on a personal Windows test machine. It does not represent production work or a real employer incident.

## Project summary

I investigated a simulated Windows support request: "A user cannot open the website `https://example.invalid`." I tested the device's network configuration, DNS resolution, and HTTPS connectivity against a known-good site (`example.com`) to narrow down the cause without modifying network settings.

## Environment
- OS: [Windows edition and version]
- Shell: Windows PowerShell [version]
- Network: [Wi-Fi/Ethernet — do not publish local IP or SSID]
- Tools: `ipconfig`, `nslookup`, `Resolve-DnsName`, `Test-NetConnection`, `Get-Service`, Event Viewer

## Support ticket INC-001
- **User complaint:** Unable to access `https://example.invalid` (deliberately non-existent training hostname)
- **Impact:** Browser cannot resolve the requested hostname.
- **Steps taken:**
  1. Checked network-adapter status and IP configuration.
  2. Verified whether `example.com` resolves correctly.
  3. Tested whether TCP port 443 on `example.com` is reachable.
  4. Compared results with `example.invalid`, which is reserved for invalid names.
  5. Checked Windows services and recent System event summaries for general context.
- **Findings:** [WRITE what your actual outputs showed]
- **Root cause of simulated case:** [WRITE only after testing; if normal connectivity worked, describe the invalid hostname accurately]
- **Resolution / advice:** [WRITE what you would tell the user, e.g., verify the requested URL with their application owner]
- **Retest:** [WRITE what you retested and its outcome]

## Evidence
> Upload ONLY screenshots that you checked and redacted to remove usernames, public/private IP addresses, Wi-Fi SSIDs, MAC addresses, computer name, tokens, or other personal data.

- `evidence/01-dns-working.png` — [add after running test]
- `evidence/02-dns-invalid.png` — [add after running test]
- `evidence/03-https-test.png` — [add after running test]
- `evidence/04-services-or-eventviewer.png` — [optional]

## Commands
See [`docs/commands.md`](docs/commands.md) for step-by-step checks.

Optional reusable, **read-only** PowerShell diagnostic script: [`scripts/diagnose.ps1`](scripts/diagnose.ps1). It saves a private local report which should NOT be uploaded.

## Skills demonstrated
- Windows PowerShell and basic system troubleshooting
- DNS vs TCP/HTTPS connectivity diagnosis
- Basic Windows service and Event Log inspection
- Structured support-ticket documentation
- Clear, privacy-conscious reporting

## Safety and limitations
No network settings, firewall rules, services, or user accounts are changed by the documented commands or script. `example.invalid` is a purposely nonexistent domain: this exercise demonstrates a troubleshooting method, not a real DNS outage. A failed ping alone does not prove a site is down. Public networks can also restrict outbound connections.

## References
- Microsoft `ipconfig`: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/ipconfig
- Microsoft `Test-NetConnection`: https://learn.microsoft.com/en-us/powershell/module/nettcpip/test-netconnection
- Microsoft `Resolve-DnsName`: https://learn.microsoft.com/en-us/powershell/module/dnsclient/resolve-dnsname
