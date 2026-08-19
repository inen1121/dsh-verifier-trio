# Contributing

Contributions that improve portability, evidence quality, failure handling, documentation, or compatibility are welcome.

Before opening a pull request:

1. Keep the preset compatible with the standard DSH capability set.
2. Preserve exactly three independent candidates and the recursion guard.
3. Preserve root-only state-changing execution.
4. Do not add model credentials, provider configuration, session data, prompts, outputs, local paths, or personal information.
5. Run `bash scripts/verify.sh` and include the sanitized result.

Use public issues for ordinary bugs and feature requests. Use GitHub private vulnerability reporting for security-sensitive findings.
