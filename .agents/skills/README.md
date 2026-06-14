# Repository Agent Skills

本目录存放仓库级协作 skills，属于版本库资产。

- 规则真源：仓库根目录 `AGENTS.md`
- 兼容入口：根目录 `CLAUDE.md`（应为指向 `AGENTS.md` 的软链接）
- Claude 兼容入口：`.claude/skills/`
- 通用 agent 兼容镜像：`.agents/skills/`
- 两个目录中的 skill 需要与 `AGENTS.md` 保持一致，并保持同义同步
- `.claude/reviews/` 属于本地分析产物，不作为规则真源

如果未来需要兼容其他 agent 目录（如 `.github/skills/`），应先明确单一真源，再通过脚本或镜像同步，而不是手工长期维护多份同义内容。
