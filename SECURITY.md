# Security Policy

## Supported version

Security fixes are applied to the latest published release. The initial release target is validated with DeepSeek Harness `0.1.0-rc.6`.

## Reporting a vulnerability

Please use GitHub's private vulnerability reporting flow from the repository's **Security** tab. Do not include API keys, private prompts, session exports, personal files, or other sensitive data in a public issue.

Useful reports include a minimal sanitized reproduction, the DSH version, operating system, expected behavior, observed behavior, and whether any persistent state changed.

## Security model

The preset applies proposal-only instructions to candidates for tasks that may change persistent state. The root Agent remains responsible for selecting one approach, performing any authorized mutation once, and verifying the result. DeepSeek Harness permissions, sandboxing, approvals, and model-provider settings remain the final enforcement and data-processing boundaries.
