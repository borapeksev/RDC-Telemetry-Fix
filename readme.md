# Remote Desktop Client (MSI) Profile Bloat Fix

## Problem
Since early 2025 we’ve observed profile corruption issues on Windows 10 and 11 endpoints caused by the **MSI-based Remote Desktop client**.  
Affected users experienced:
- Logon to temporary profiles
- Errors in Event Viewer (`User Profile Service` 1502, 1508, 1511, 1515, etc.)
- `ntuser.dat` files bloating up to **1–2 GB**