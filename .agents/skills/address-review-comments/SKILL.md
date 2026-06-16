---
name: address-review-comments
description: Use when handling GitHub PR review feedback in this repository and checking the full business contract before applying fixes.
---

# Address Review Comments

处理 GitHub PR review 反馈时，先收敛 reviewer 指出的完整业务契约，再做最小相关修复，避免只在评论行追加补丁。

**Repository**: https://github.com/ZhuLinsen/daily_stock_analysis/pulls

## Usage

```text
/address-review-comments <pr_number>
```

## Instructions

处理时使用简洁中文，优先遵循仓库根目录 `AGENTS.md`，尤其是 `8.1 Review 反馈处理与补丁堆叠禁止`。

### Step 1: 拉取 review 反馈和当前 PR 状态

```bash
gh pr view <pr_number> --repo ZhuLinsen/daily_stock_analysis --comments
gh pr checks <pr_number> --repo ZhuLinsen/daily_stock_analysis
gh pr diff <pr_number> --repo ZhuLinsen/daily_stock_analysis
```

如有失败 CI，优先查看失败日志：

```bash
gh run view <run_id> --log-failed
```

不要默认执行 `gh pr checkout`、`git pull`、`git push` 或远端状态修改操作。

### Step 2: 逐条还原 reviewer 原问题

先列出每条需要处理的 review 反馈：

- reviewer 指出的原问题是什么
- 指向的文件、行号或用户可见路径是什么
- reviewer 给出的反例或失败场景是什么
- 该问题是否仍然存在，是否已有后续提交覆盖

不要只记录“要改哪几行”；必须描述业务语义和契约问题。

### Step 3: 分析根因和同语义影响面

对每条成立的问题，检查同一业务语义涉及的所有路径，例如：

- runtime / 主流程
- API / Schema / Web / Desktop
- CLI / diagnostics / workflow
- docs / tests / PR body
- fallback / 通知 / 报告结构

说明根因时，优先描述契约为什么漂移，而不是只描述代码位置。

### Step 4: 修复完整契约

- 只做与 review 反馈直接相关的最小改动
- 优先复用现有模块、配置入口、脚本和测试
- 不用 broad fallback、静默降级、`return False/None/[]` 掩盖不清晰的契约
- 不只修复当前失败测试或评论行，要同步修复同语义入口
- 如果涉及用户可见行为、配置语义、CLI/API、部署、通知、报告结构，要同步更新相关文档、`docs/CHANGELOG.md`、`.env.example`

### Step 5: 补齐验证和 PR 描述

按 `AGENTS.md` 的验证矩阵执行最接近的检查，至少覆盖 reviewer 指出的反例或说明无法覆盖的原因。

如果需要更新 PR body，先整理建议内容；只有在用户明确确认后，才执行 `gh pr edit` 或发布评论。PR body 应保持以下内容与当前 head 一致：

- scope
- verification commands and results
- compatibility and risk
- rollback plan
- visual evidence（仅报告格式、报告渲染效果或 Web UI 变化需要）

### Step 6: 生成或更新处理记录

将处理记录保存到 `.claude/reviews/prs/pr-<number>-review-fixes.md`。

## Output Document Format

```markdown
# PR #<number> Review Feedback Handling

**Date**: YYYY-MM-DD
**Status**: Pending Review

## Reviewer Issues

- 原问题：
- reviewer 反例：
- 是否成立：

## Root Cause And Contract Scope

- 根因：
- 同语义影响路径：

## Changes Made

- 文件与改动点：

## Validation

- 已执行：
- 未执行：
- reviewer 反例覆盖情况：

## PR Body Sync

- 是否需要更新：
- 建议内容或已确认执行的命令：

## Risks And Rollback

- 风险点：
- 回滚方式：
```

## Allowed Auto-Actions (No Confirmation Needed)

- 拉取 PR 元数据、diff、评论和 CI 状态
- 阅读相关代码、模板、工作流与文档
- 应用与 review 反馈直接相关的最小本地修复
- 运行非破坏性的本地验证
- 生成本地处理记录

## Actions Requiring Confirmation

执行以下动作前，先询问用户：

1. 切换或创建分支
2. `git commit`
3. `git push`
4. 发布 PR 评论或回复 review comment
5. Resolve / unresolve review thread
6. `gh pr edit` 更新 PR body
7. Approve PR、Request changes、Merge PR 或关闭 PR
