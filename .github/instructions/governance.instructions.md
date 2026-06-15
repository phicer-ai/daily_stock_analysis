---
applyTo: "README.md,docs/**,AGENTS.md,CLAUDE.md,.github/**,.claude/skills/**,.agents/skills/**,scripts/**,docker/**"
---

# Governance Instructions

- Keep commands, file paths, workflow names, config keys, release paths, and directory references aligned with the executable repository state.
- `AGENTS.md` is the canonical AI collaboration document; if its meaning changes, sync `CLAUDE.md`, `.github/copilot-instructions.md`, `.github/instructions/*.instructions.md`, `.claude/skills/`, and the `.agents/skills/` mirror as needed.
- Root `SKILL.md` and `docs/openclaw-skill-integration.md` describe product or external integration behavior, not repository governance.
- Repository collaboration skills are versioned in `.claude/skills/` and mirrored to `.agents/skills/`; both must treat `AGENTS.md` as the single source of truth.
- Explain which pipeline, release path, deployment path, review automation, or governance asset is affected and what the rollback path is.
- Keep `README.md` limited to homepage-level content such as positioning, high-level capabilities, quick start, main entrypoints, and sponsorship/cooperation; put detailed behavior, configuration, troubleshooting, field contracts, and edge cases in `docs/*.md`.
- Avoid widening permissions, secret exposure, or destructive automation without a clearly documented need.
- Preserve the repository's opt-in auto-tag behavior (`#patch`, `#minor`, `#major`) unless the change explicitly updates release policy.
- When creating, reviewing, or suggesting PRs, prefer PR titles in `<type>: <change summary>` form and omit tool/agent source prefixes such as `[codex]`, `codex`, `autocode`, or `copilot`; treat this as non-blocking guidance, not a review hard blocker.
- When addressing review feedback, handle the full business contract described by the reviewer: list the original issues, explain root cause, inspect runtime/API/Web/CLI/diagnostics/workflow/docs/tests paths with the same semantics, add regression coverage or state the validation gap, and keep the PR body synchronized with the current head.
- If only one language version of a document is updated, explain why the counterpart was not synchronized.
