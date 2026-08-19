# dsh-verifier-trio

A daily-use, safety-first Best-of-3 verification preset for [DeepSeek Harness](https://github.com/deepseek-ai/deepseek-harness).

For substantive tasks, the preset generates three independent candidate proposals in parallel, then keeps the root Agent responsible for evidence review, final synthesis, and any state-changing action. Simple, low-risk requests continue to use the normal single-answer path.

## Why this exists

`dsh-verifier-trio` is inspired by the multi-candidate generation and verification idea in [LLM-as-a-Verifier](https://github.com/llm-as-a-verifier/llm-as-a-verifier). It adapts that idea into a compact DeepSeek Harness preset designed for everyday research, writing, comparison, coding, debugging, and file-oriented work.

This is an independent community project and is not affiliated with DeepSeek or the LLM-as-a-Verifier authors.

## What it does

```text
substantive task
      │
      ├── candidate 1 ─┐
      ├── candidate 2 ─┼─ root Agent evidence review ─ final answer
      └── candidate 3 ─┘                         └─ one selected execution
```

- Gates simple requests so they do not pay the cost of three candidates.
- Gives all candidates the same task bundle and current model route.
- Prevents recursive candidate spawning with `<VERIFIER_LEAF/>`.
- Requires structured evidence, risks, completed checks, and remaining checks.
- Uses hard-failure rules, scoring, and pairwise comparison at the root Agent.
- Keeps state-changing work under the root Agent so the selected approach runs once.
- Uses bounded fallback behavior if some candidates fail.

## Compatibility

Validated against DeepSeek Harness `0.1.0-rc.6` on macOS. The repository verifier checks the portable preset structure and the JavaScript workflow body.

## Install

Clone the repository, then copy the preset directory into your DSH user-preset root:

```bash
git clone https://github.com/inen1121/dsh-verifier-trio.git
cd dsh-verifier-trio

DSH_PRESET_ROOT="${DSH_PRESET_ROOT:-$HOME/.dsh/.agent-presets}"
mkdir -p "$DSH_PRESET_ROOT"
cp -R preset/verifier-trio "$DSH_PRESET_ROOT/verifier-trio"
```

Restart DeepSeek Harness, open the Agent preset selector, and choose **三路验证模式** (`verifier-trio`).

## Update

Pull the new version, move the installed preset to a dated backup, and copy the replacement:

```bash
git pull --ff-only

DSH_PRESET_ROOT="${DSH_PRESET_ROOT:-$HOME/.dsh/.agent-presets}"
backup_path="$DSH_PRESET_ROOT/verifier-trio.backup-$(date +%Y%m%d-%H%M%S)"
mv "$DSH_PRESET_ROOT/verifier-trio" "$backup_path"
cp -R preset/verifier-trio "$DSH_PRESET_ROOT/verifier-trio"
```

Restart DSH after updating.

## Disable or uninstall

Moving the preset outside the active preset root is recoverable and avoids deleting it:

```bash
DSH_PRESET_ROOT="${DSH_PRESET_ROOT:-$HOME/.dsh/.agent-presets}"
mv "$DSH_PRESET_ROOT/verifier-trio" "$DSH_PRESET_ROOT/verifier-trio.disabled"
```

Restart DSH. Move the directory back to re-enable it.

## Verify this checkout

```bash
bash scripts/verify.sh
```

The verifier checks required files, YAML parsing, DSH-style workflow syntax, Best-of-3 structure, attribution, and common privacy leaks.

## Safety and privacy

Candidate tasks receive a proposal-only policy whenever the user request could change files, repositories, dependencies, messages, or external services. The root Agent reviews the proposals and owns the single selected execution. Your existing DSH permissions and provider configuration remain the final runtime boundary.

The preset contains no telemetry, API credentials, provider configuration, session history, cached prompts, or user content. Model requests continue to follow the provider and privacy settings of your DeepSeek Harness installation. See [PRIVACY.md](PRIVACY.md) and [SECURITY.md](SECURITY.md).

## 中文说明

这是一个面向日常使用的 DeepSeek Harness 三路验证 preset：复杂任务并行生成三个独立候选，由根 Agent 根据证据比较、整合，并且只执行一次最终选定的修改；问候、简单解释和机械转换仍直接回答。

项目受到 [LLM-as-a-Verifier](https://github.com/llm-as-a-verifier/llm-as-a-verifier) 的多候选验证思想启发，重点放在日常可用性、受控成本和单次安全执行。

## License

[MIT](LICENSE)
