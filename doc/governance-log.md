# 治理日志

> 记录治理模型的变更和里程碑事件。

---

## 2026-07-19 — 七权协作模型建立

### 背景
- 项目从"单 Agent 做所有事"进化到"多 Agent 分工协作"
- 用户明确提出：三权分离 → 七权协作 → 奖惩机制 → 完全自动化

### 演进过程
1. **三权分离**：议（设计）→ 行（实施）→ 审（验证）
2. **增加战略者**：用户指出"没有想法需求池会枯竭"
3. **增加监督和奖惩**：用户指出"需要能监督到各个 agent"
4. **最终形态**：策 → 议 → 行 → 审 → 督 + 用户裁决 + 记分板反馈

### 创建的文件
- `doc/governance.md` — 治理手册（完整版）
- `doc/scorecard.md` — 记分板模板
- `~/.claude/skills/kouol-strategist/SKILL.md`
- `~/.claude/skills/kouol-architect/SKILL.md`
- `~/.claude/skills/kouol-pm/SKILL.md`
- `~/.claude/skills/kouol-developer/SKILL.md`
- `~/.claude/skills/kouol-tester/SKILL.md`
- `~/.claude/skills/kouol-reviewer/SKILL.md`
- `~/.claude/skills/kouol-auditor/SKILL.md`

### 更新的文档
- `AGENTS.md` — 添加治理结构章节
- `CLAUDE.md` — 添加治理模型引用

### 核心决策
- **奖惩本质**：不是"骂一顿"或"发奖金"——是改变 Agent 的 Skill 文件（"基因编辑"）
- **审计独立性**：Auditor 不参与议/行/审的任何环节，只做事后审查
- **规则极简**：教学项目，不超过 5 条核心规则

### 下一步
- [ ] 在实际需求中演练治理流程
- [ ] 根据实践反馈迭代治理手册
- [ ] 首次审计和记分

---

> 下一个需求完成时，由 🔍 Auditor 执行首次审计并更新记分板。
