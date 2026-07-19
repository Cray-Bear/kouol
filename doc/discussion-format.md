# 讨论记录格式

> **所有 Agent 之间的讨论必须留痕，供用户审阅。**

---

## 文件位置

每个需求目录下 `discussion.md`，newest first。

```
doc/requirements/R-xxx/discussion.md
```

## 记录时机

以下情况**必须记录**：

| 类型 | 触发 | 示例 |
|------|------|------|
| 三方讨论 | Architect + Designer + PM 讨论方案 | 组件选型、交互方式、验收标准 |
| 复议请求 | Developer/Reviewer 发现方案问题 | 技术不可行、需求有歧义 |
| 跨角色反馈 | Tester → Developer, Reviewer → Developer | Bug 争议、改进建议分歧 |
| 需求澄清 | PM ↔ 用户 ↔ Architect | 验收标准不明确、范围边界模糊 |
| 设计评审 | Designer ↔ Architect | 视觉方案 vs 技术约束 |

## 记录格式

```markdown
## YYYY-MM-DD HH:MM — {一句话主题}

**类型：** 三方讨论 / 复议 / 反馈 / 澄清 / 设计评审
**参与方：** {角色 1} · {角色 2} · {角色 3}

### 背景
{讨论什么问题？为什么需要讨论？}

### 各方发言

**🏗️ Architect：**
{立场和理由}

**🎨 Designer：**
{立场和理由}

**📋 PM：**
{立场和理由}

### 结论
- [ ] {达成的共识 / 决议}
- [ ] {后续行动项}
- 状态：{已达成共识 / 存在分歧 / 待用户裁决}
```

### 参与方灵活适配

不是每次讨论都有三方。按实际参与方记录：

- 两方讨论：只记录两个角色
- Developer 提请复议：Developer + Architect（+ PM 如果涉及需求）
- Tester 反馈 Bug：Tester + Developer
- 设计评审：Designer + Architect

### 多方发言示例（复议）

```markdown
## 2026-07-19 15:00 — T-003 登录接口方案复议

**类型：** 复议
**参与方：** 💻 Developer · 🏗️ Architect

### 背景
Developer 在实现 T-003 时发现 ArkUI 的 router 模块不支持传参跳转

### 各方发言

**💻 Developer：**
ArkTS 的 router.pushUrl 不支持直接传递对象参数，方案中"跳转详情页并传入商品数据"需要调整。建议改用 AppStorage 传递。

**🏗️ Architect：**
同意。AppStorage 适合这种跨页面数据传递。更新 technical.md 第 3 节。

### 结论
- [x] 改用 AppStorage 传递商品数据
- [x] Architect 更新 technical.md
- 状态：已达成共识
```

## 索引

discussion.md 顶部维护一个讨论索引：

```markdown
# R-{xxx} 讨论记录

| # | 日期 | 类型 | 参与方 | 结论 |
|---|------|------|--------|------|
| 1 | 07-19 | 三方讨论 | Arch + Des + PM | 采用方案 A |
| 2 | 07-19 | 复议 | Dev + Arch | 改用 AppStorage |
```

## 豁免

以下情况**不需要**记录：
- 快速确认（"这个可以" / "收到"）
- 纯格式修正（改个错别字）
- 单方通知（"我完成了 T-001"）

**判断标准：** 如果有"观点交换"就需要记录；如果只是"信息传递"就不用。

---

> **用户会审阅所有讨论记录。**
> 写清楚谁说了什么、为什么这样说、最后结论是什么。
> 透明是协作的基础。
