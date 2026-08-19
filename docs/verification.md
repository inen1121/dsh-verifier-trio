# Verification record

## Release target

- Preset: `verifier-trio`
- DeepSeek Harness: `0.1.0-rc.6`
- Host used for local validation: macOS

## Static validation

- Required release files: passed
- YAML parse: passed for `preset.yml` and `agent.cordis.yml`
- DSH-style JavaScript workflow-body syntax: passed
- Best-of-3 structural assertions: passed
- Local-path and credential-pattern scan: passed for the three preset source files
- Live DSH preset discovery: passed

## Private Best-of-3 acceptance

The no-side-effect acceptance run completed with the following structural evidence:

- `three-way-verifier` skill calls: 1
- `verifier-trio-generation` workflow calls: 1
- Workflow starts / completed ends: 1 / 1
- Candidate agent starts / completed ends: 3 / 3
- Root turn completed: 1
- Shell, filesystem, editor, browser or web tool calls: 0

The workflow script used `[1, 2, 3]`, `parallel`, and the `<VERIFIER_LEAF/>` recursion guard. Prompts, candidate responses, hidden reasoning, session identifiers, provider information, local paths, and account/token data are intentionally excluded from this record.
