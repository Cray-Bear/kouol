# 协作流程指南 (Collaboration Guide)

> **各 Agent 如何在日常工作中协作。** 实操导向，不是理论。
> 设计者：🔍 Auditor | 使用者：所有 Agent

---

## 一、协作全景

```
💭 策 · 想法
   🎯 Strategist → 想法池 (I-xxx)
   👤 用户 → 选择哪些值得做
      ↓
📝 议 · 设计
   🎯 Strategist → 需求文档 (requirement.md) + 任务拆解 (T-xxx)
   🎨 Designer → 设计确认 / 设计稿
   🏗️ Architect → 技术方案 (technical.md)
   🎯🎨🏗️ → 三方讨论 → discussion.md
      ↓
🔨 行 · 实施
   💻 Developer → 编码 + 本地验证 + 部署 + 线上验证 + log.md
      ↓
🧪 审 · 验证
   🧪 Tester → 功能测试 (test.md)
   📝 Reviewer → 代码审查 (review.md)
   💻 Developer → 修复（如有）
   🎯 Strategist → 验收（基于验收标准）
      ↓
📦 发布
   💻 Developer → 发布记录 (release.md)
      ↓
🔍 督 · 审计
   🔍 Auditor → 审计报告 + 记分板
   📝 Reviewer → 复盘 (review.md)
```

---

## 二、交接协议 (Handoff Protocol)

### 2.1 什么是交接？

当一个 Agent 完成工作，需要把成果传给下一个 Agent 时，就是一次交接。

### 2.2 交接清单

每次交接必须满足：

| 检查项 | 说明 |
|--------|------|
| ✅ 产出文件存在 | 要求的文档已创建 |
| ✅ 状态已更新 | 任务/需求状态正确 |
| ✅ 日志已记录 | log.md / discussion.md 已更新 |
| ✅ 下游已知 | 下游 Agent 已被告知 |
| ✅ 问题已标注 | 遗留问题已说明 |

### 2.3 交接矩阵

| 从 → 到 | 交接内容 | 交接方式 |
|---------|---------|---------|
| 🎯 → 🎯 | I-xxx → requirement.md | 用户确认后，Strategist 产出需求 |
| 🎯 → 🎨 | requirement.md（初稿） | Strategist 完成后，Designer 读取 |
| 🎨 → 🏗️ | 设计确认 / 设计稿 | Designer 确认后，Architect 开始方案 |
| 🏗️ → 💻 | technical.md（技术方案） | 三方讨论后，Developer 读取 |
| 💻 → 🧪 | 代码 + 部署验证通过 | Developer 部署后，Tester 开始测试 |
| 💻 → 📝 | 代码 + log.md | Developer 提交后，Reviewer 开始审查 |
| 🧪 → 💻 | test.md（测试报告） | 有 Bug 时，Developer 读取并修复 |
| 📝 → 💻 | review.md（复盘报告） | 有改进建议时，Developer 读取 |
| 💻 → 🎯 | 修复后的代码 | Developer 修复后，Strategist 验收 |
| 🎯 → 💻 | 验收通过 | Strategist 确认后，Developer 写 release.md |
| 全员 → 🔍 | 所有文档 | Auditor 读取全部文档进行审计 |
| 🔍 → 🎯 | 审计报告 | Auditor 反馈系统性问题，触发新想法 |

---

## 三、关键协作场景

### 3.1 三方讨论

**触发：** 需求进入"议"阶段

**参与者：** 🎯 Strategist + 🎨 Designer + 🏗️ Architect

**流程：**
```
1. 🎯 Strategist 主持，说明需求目标和验收标准
2. 🎨 Designer 从视觉/体验角度提建议
3. 🏗️ Architect 从技术角度提方案
4. 三方讨论，达成共识
5. 任意一方记录到 discussion.md
6. 如有分歧 → 记录各方立场 → 提交用户裁决
```

**讨论记录：** 按 `doc/discussion-format.md` 格式

### 3.2 提请复议

**触发：** Developer / Reviewer 发现方案有问题

**流程：**
```
1. 💻 Developer 或 📝 Reviewer 发现问题
2. 写复议请求（格式见 Developer Skill）
3. 🏗️ Architect 评估方案是否确实有缺陷
4. 如需修改 → Architect 更新 technical.md
5. 记录到 discussion.md
```

### 3.3 Bug 争议

**触发：** Tester 说有 Bug，Developer 说不是

**流程：**
```
1. 🧪 Tester 记录 Bug + 复现步骤
2. 💻 Developer 评估：是 Bug 还是设计如此？
3. 如不一致 → 🎯 Strategist 仲裁（基于验收标准）
4. 记录到 discussion.md
```

### 3.4 设计评审

**触发：** 新页面创建 / 设计系统变更

**流程：**
```
1. 🎨 Designer 完成设计
2. 🏗️ Architect 评估技术可行性
3. 🎯 Strategist 评估用户体验
4. 如有问题 → 讨论 → 修改 → 再评审
5. 记录到 discussion.md
```

---

## 四、沟通格式

### 4.1 讨论记录格式

所有观点交换必须记录到 `R-xxx/discussion.md`：

```markdown
## YYYY-MM-DD HH:MM — {主题}

**类型：** 三方讨论 / 复议 / 反馈 / 澄清
**参与方：** {角色 1} · {角色 2}

### 背景
{讨论什么问题}

### 各方发言
**🏗️ Architect：** {立场和理由}
**🎨 Designer：** {立场和理由}

### 结论
- [ ] {达成的共识}
- 状态：已达成共识 / 存在分歧 / 待用户裁决
```

### 4.2 提请复议格式

```markdown
## 复议请求

**需求：** R-xxx
**任务：** T-yyy
**问题：** {具体描述}
**建议：** {你觉得可以怎么调整}
```

### 4.3 单方通知（不需要记录）

```
"我完成了 T-001" → 不记录
"收到" → 不记录
"这个可以" → 不记录
```

**判断标准：** 有"观点交换"就记录，只有"信息传递"不用。

---

## 五、各角色工作检查清单

### 🎯 Strategist 工作检查

- [ ] 扫描了项目现状？（log.md、review.md、已有需求）
- [ ] 用了第一性原理分析？（至少 3 个 FP 工具）
- [ ] 想法写入了 `doc/ideas/I-xxx.md`？
- [ ] 给出了优先级建议？
- [ ] 更新了 `doc/ideas/README.md` 索引？
- [ ] 需求文档写了 what + why？
- [ ] 验收标准可量化、可验证？
- [ ] 范围边界明确了（包含什么、不包含什么）？
- [ ] 任务拆到了原子级别？
- [ ] 提交了设计确认？
- [ ] 讨论了有没有记录到 discussion.md？

### 🎨 Designer 工作检查

- [ ] 读了 design-constitution.md？
- [ ] 翻了 design-log.md 的风格备忘？
- [ ] 用了 `get_metadata` 查看 Figma 现状？
- [ ] 每个元素都 `appendChild` 到 frame？
- [ ] 底部区域 y+h ≤ 812？
- [ ] 截图验证通过？
- [ ] 写入了 design-log.md？

### 🏗️ Architect 工作检查

- [ ] 读了 requirement.md？
- [ ] 评估了技术可行性？
- [ ] 写了 technical.md（含架构、选型、步骤、风险）？
- [ ] 从项目公理推导了方案？
- [ ] 三方讨论有记录？

### 💻 Developer 工作检查

- [ ] 读了 technical.md？
- [ ] 读了 requirement.md（验收标准）？
- [ ] 代码符合 coding-standards.md？
- [ ] log.md 实时记录？
- [ ] 自测通过了？
- [ ] 提交格式正确？
- [ ] 博客变更本地验证了？（jekyll serve）
- [ ] 部署后 curl 验证关键 URL 返回 200？
- [ ] 通知设计验收视觉效果？
- [ ] 通知测试验收内容正确性？

### 🧪 Tester 工作检查

- [ ] 读了验收标准？
- [ ] 写了测试用例？
- [ ] 执行了测试？
- [ ] 设计还原度检查了？
- [ ] 测试报告写好了？
- [ ] Bug 有复现步骤 + 截图？

### 📝 Reviewer 工作检查

- [ ] 读了 technical.md（了解方案意图）？
- [ ] 审查了代码质量？
- [ ] 检查了 ArkUI 最佳实践？
- [ ] 记录了踩坑？
- [ ] 给了具体、可执行的改进建议？
- [ ] review.md 写好了？

### 🔍 Auditor 工作检查

- [ ] 读了所有相关文档？
- [ ] 对照审计清单逐项检查？
- [ ] 审计报告写好了？
- [ ] 记分板更新了？
- [ ] 改进了模板/流程（如果发现问题）？

---

## 六、影响范围决定流程重量

> **核心原则：修改如果只能影响你自己，就直接修。**

### 三级影响判断

| 影响范围 | 判断标准 | 流程 | 示例 |
|---------|---------|------|------|
| **只影响自己** | 下游还没动这个产出 | 直接改，告知即可 | Designer 巡检发现新页面间距不对，直接修 |
| **影响下游但下游还没动** | 产出已交给下游，但下游还没开始 | 和战略者沟通后改 | Architect 发现方案有优化空间，Developer 还没开始编码 |
| **影响已动的下游** | 下游已经在讨论/开发/已上线 | 提 Idea 走全流程 | 页面已上线，发现视觉问题 → I-xxx → R-xxx |

### 各角色的"自己的范围"

| Agent | 可以直接改的范围 | 需要沟通的范围 | 需要走流程的范围 |
|-------|----------------|--------------|----------------|
| 🎯 Strategist | 想法池中的 I-xxx | 未进入议的 R-xxx 初稿 | 已批准的 R-xxx |
| 🎨 Designer | 未交给下游的设计稿 | 已交给 Architect/Developer 但未动工 | 已开发或已上线的页面 |
| 🏗️ Architect | 未交给 Developer 的技术方案 | Developer 还没开始编码的方案 | Developer 已经在编码的方案 |
| 💻 Developer | 自己负责的代码实现 | 不影响接口/架构的重构 | 影响其他模块的变更 |
| 🧪 Tester | 测试用例的措辞/格式 | 验收标准的理解（需和 Strategist 对齐） | 验收标准本身的修改 |

### 判断流程图

```
发现问题/优化点
   ↓
下游动了吗？
   ├─ 没动 → 影响范围只在自己？
   │         ├─ 是 → 直接改，log.md/discussion.md 记录
   │         └─ 否 → 和战略者沟通后改
   └─ 动了 → 提 Idea，走完整流程
```

### 通用规则

1. **直接改也要记录** — 在 discussion.md 或 log.md 里说明改了什么、为什么
2. **不确定就升级** — 拿不准影响范围时，走更重的流程，不冒险
3. **其他 Agent 同理** — 这个原则适用于所有角色，不只是设计师

### 兜底规则（Auditor 补充）

| 情况 | 处理 |
|------|------|
| 不确定影响范围 | 假设影响范围大，走更重流程 |
| "下游动了"的判定 | 下游在 discussion.md / log.md 中有相关记录 |
| "直接改"的事后追溯 | Auditor 抽查 design-log.md 变更记录 |

---

## 七、升级与降级规则

### 6.1 自主权等级

| 等级 | 条件 | 工作方式 |
|------|------|---------|
| 🟢 自由 | 连续 3 次无重大失误 | 可跳过部分讨论；方案无需逐条审批 |
| 🟡 正常 | 默认等级 | 按标准流程走 |
| 🔴 受限 | 连续 2 次重大失误 | 增加审查环节；代码必须经过额外 review |

### 6.2 触发条件

| 条件 | 建议 |
|------|------|
| 连续 3 次 ⭐⭐⭐⭐⭐ | 升级至 🟢 自由 |
| 单次重大失误 | 写专项复盘 |
| 连续 2 次 ⭐⭐ 或以下 | 降级至 🔴 受限 |
| 同类问题踩坑 3 次 | 更新该 Agent 的 Skill 文件 |

---

## 七、文档速查

| 文档 | 用途 | 维护者 |
|------|------|--------|
| `doc/governance.md` | 治理手册（六权模型） | 🔍 Auditor |
| `doc/lifecycle.md` | 需求全生命周期 | 🔍 Auditor |
| `doc/coding-standards.md` | 编码规范 | 🔍 Auditor |
| `doc/testing-workflow.md` | 测试开发流程 | 🔍 Auditor |
| `doc/design-constitution.md` | 设计宪法 | 🎨 Designer |
| `doc/design-rules.md` | 设计规则速查 | 🎨 Designer |
| `doc/discussion-format.md` | 讨论记录格式 | 🔍 Auditor |
| `doc/scorecard.md` | 记分板 | 🔍 Auditor |
| `doc/ideas/I-xxx.md` | 想法 | 🎯 Strategist |
| `doc/requirements/R-xxx/` | 需求目录 | 🎯 Strategist |

---

> **本指南是活文档。** 随着协作实践的积累，持续优化。
> 核心目标：让每个人知道什么时候该做什么、怎么做、做完交给谁。
