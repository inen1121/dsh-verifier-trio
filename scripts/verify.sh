#!/usr/bin/env bash
set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd -P)
cd "$repo_root"

for required_command in rg ruby node; do
  if ! command -v "$required_command" >/dev/null 2>&1; then
    printf 'FAIL: required command not found: %s\n' "$required_command" >&2
    exit 1
  fi
done

required_files=(
  '.gitignore'
  'CONTRIBUTING.md'
  'LICENSE'
  'PRIVACY.md'
  'README.md'
  'SECURITY.md'
  'docs/verification.md'
  'preset/verifier-trio/agent.cordis.yml'
  'preset/verifier-trio/preset.yml'
  'preset/verifier-trio/skills/three-way-verifier/SKILL.md'
  'scripts/verify.sh'
)

for required_file in "${required_files[@]}"; do
  if [ ! -f "$required_file" ]; then
    printf 'FAIL: required file missing: %s\n' "$required_file" >&2
    exit 1
  fi
done

ruby -e 'require "yaml"; ARGV.each { |f| YAML.load_file(f) }' \
  'preset/verifier-trio/preset.yml' \
  'preset/verifier-trio/agent.cordis.yml'

skill_file='preset/verifier-trio/skills/three-way-verifier/SKILL.md'
verify_tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/dsh-verifier-trio-verify.XXXXXX")
trap 'rm -rf "$verify_tmp_dir"' EXIT HUP INT TERM

{
  printf '%s\n' 'async function __dshWorkflow() {'
  sed -n '/^~~~js$/,/^~~~$/p' "$skill_file" | sed '1d;$d'
  printf '%s\n' '}'
} > "$verify_tmp_dir/workflow.mjs"

node --check "$verify_tmp_dir/workflow.mjs"

for required_marker in \
  '[1, 2, 3]' \
  'parallel(' \
  'agent(makePrompt(candidateId)' \
  '<VERIFIER_LEAF/>' \
  'additionalProperties: false' \
  'verifier-trio-generation'; do
  if ! rg -F -q "$required_marker" "$skill_file"; then
    printf 'FAIL: workflow marker missing: %s\n' "$required_marker" >&2
    exit 1
  fi
done

privacy_pattern='(/Users/[^/[:space:]]+|/home/[^/[:space:]]+|C:\\Users\\[^\\[:space:]]+|session-[0-9a-f]{8}|BEGIN [A-Z ]*PRIVATE KEY|[[:alnum:]_.+-]+@(gmail\.com|book\.local)|((api[_-]?key|access[_-]?token|password|passwd|secret)[[:space:]]*[:=][[:space:]]*[^[:space:]]{8,}))'
if rg -n -i "$privacy_pattern" 'preset/verifier-trio'; then
  printf 'FAIL: privacy-sensitive pattern found in preset files\n' >&2
  exit 1
fi

if ! rg -F -q 'LLM-as-a-Verifier' README.md; then
  printf 'FAIL: inspiration attribution missing from README\n' >&2
  exit 1
fi

if ! rg -F -q 'PROPOSAL_ONLY_READ_ONLY' "$skill_file"; then
  printf 'FAIL: proposal-only execution policy missing\n' >&2
  exit 1
fi

printf '%s\n' 'PASS: dsh-verifier-trio release verification'
