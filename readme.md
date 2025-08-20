# Remote Desktop Client (MSI) Profile Bloat Fix

## Problem
Since early 2025 we’ve observed profile corruption issues on Windows 10 and 11 endpoints caused by the **MSI-based Remote Desktop client**.  
Affected users experienced:
- Logon to temporary profiles
- `ntuser.dat` files bloating up to **1–2 GB**
## Recommendation

Since the Remote Desktop Client telemetry can cause user profiles to bloat daily, it is **highly recommended to create a scheduled task** to run this script automatically every day. This ensures that ntuser.dat size stays under control and prevents profile corruption from reoccurring.

