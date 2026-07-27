# Security Policy

## Supported Versions

| Version | Supported |
|---------|-----------|
| 1.x     | ✅ Yes    |

## Reporting a Vulnerability

If you discover a security issue (e.g., unsafe `sudo` usage in scripts, hardcoded credentials, or a path traversal in `deploy.sh`), **please do NOT open a public issue.**

Instead:
1. Open a **private** GitHub Security Advisory on this repository.
2. Or email the maintainer directly via GitHub profile.

Include:
- A description of the vulnerability
- Steps to reproduce
- Potential impact

You will receive a response within 72 hours. Confirmed vulnerabilities will be patched and disclosed publicly after a fix is available.

## Scope

This repository contains shell scripts and configuration files that run with **user-level permissions only**. The only scripts that require `sudo` are:
- `sddm/setup_sddm.sh` — installs SDDM theme to `/usr/share/sddm/themes/`

No scripts in this repository store passwords, tokens, or private keys.
