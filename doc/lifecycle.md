# 需求全生命周期

> 从想法到上线的完整流程，展示各 Agent 在什么时间做什么事。

---

## 甘特图

```mermaid
gantt
    title 需求全生命周期 · Agent 参与时间线
    dateFormat YYYY-MM-DD
    axisFormat %m/%d

    section 💭 策 · 想法
    a0 战略者: 想法生产           ,a0,2026-07-20,1d
    a1 战略者: 第一性原理分析     ,a1,after a0,1d

    section 📝 议 · 设计
    a2 PM: 需求文档              ,a2,after a1,1d
    a3 Designer: 设计确认        ,a3,after a2,1d
    a4 Architect: 技术方案       ,a4,after a1,2d
    a5 三方讨论                  ,a5,after a4,1d
    a6 PM: 任务拆解              ,a6,after a5,1d

    section 🔨 行 · 实施
    b1 Developer: 编码实施       ,b1,after a6,3d
    b2 Developer: 开发日志       ,b2,after a6,3d

    section 🧪 审 · 验证
    c1 Tester: 功能验证          ,c1,after b1,2d
    c2 Reviewer: 代码审查        ,c2,after b1,2d
    c3 Developer: 修复            ,c3,after c1,1d
    c4 PM: 验收                  ,c4,after c3,1d

    section 📦 发布
    d1 Developer: 发布记录       ,d1,after c4,1d

    section 🔍 督 · 审计
    d2 Auditor: 审计报告         ,d2,after d1,2d
```

---

## Agent 参与矩阵

| Agent | 权 | 💭策 | 📝议 | 🔨行 | 🧪审 | 📦发布 | 🔍督 | 合计 |
|-------|-----|:----:|:----:|:----:|:----:|:-----:|:----:|------|
| 🎯 Strategist | 策 | ★★★★★ | — | — | — | — | ★ | 20% |
| 📋 PM | 议 | ★ | ★★★★★ | — | ★ | — | ★ | 24% |
| 🎨 Designer | 议 | — | ★★★★ | — | — | — | — | 16% |
| 🏗️ Architect | 议 | ★ | ★★★★★ | ★ | ★ | — | ★ | 32% |
| 💻 Developer | 行 | — | — | ★★★★★ | ★★ | ★ | — | 32% |
| 🧪 Tester | 审 | — | — | — | ★★★★★ | — | ★ | 24% |
| 📝 Reviewer | 审 | — | — | — | ★★★★ | — | ★ | 20% |
| 🔍 Auditor | 督 | — | — | — | — | — | ★★★★★ | 20% |
| 👤 **用户** | **裁决** | **★★★** | **★★★** | **—** | **—** | **—** | **★★★** | **36%** |

> ★ 数量 = 参与密度，不是重要性。"—" = 该阶段无直接参与。
> 用户在全链路都有裁决权，尤其在策（选方向）和督（看审计报告）阶段介入最深。

---

## 流转关系

```
💭 I-xxx (想法)
   ↓ 🎯 战略者 · 隐含假设 + 公理化推导 + 三洽检验
📝 requirement.md (初稿)
   ↓ 📋 PM 定义验收标准
   ↓ 🎨 Designer 设计确认 ← 不可跳过
   ↓ 🏗️ Architect 技术方案
   ↓ 📋🎨🏗️ 三方讨论 → discussion.md ← 用户审阅
   ↓ 📋 PM 任务拆解
🔨 T-xxx → log.md 实时记录 + discussion.md 讨论留痕
   ↓ 💻 Developer 编码
   ↓ 🧪 Tester 验证 + 📝 Reviewer 审查（并行）
   ↓ 📋 PM 验收
📦 release.md
   ↓ 🔍 Auditor 审计 → scorecard.md
✔️ R-xxx (完成) → review.md (复盘)
```

---

## 阶段说明

### 💭 策 · 想法阶段

| 步骤 | 执行者 | 产出 | 说明 |
|------|--------|------|------|
| 想法生产 | 🎯 Strategist | `doc/ideas/I-xxx.md` | 从项目现状/审计反馈/用户表达中提炼 |
| 第一性原理分析 | 🎯 Strategist | I-xxx 中的 FP 分析 | 重大想法必填：隐含假设 + 公理推导 + 三洽检验 |
| 用户裁决 | 👤 用户 | 决定哪些想法值得做 | — |

### 📝 议 · 设计阶段

| 步骤 | 执行者 | 产出 | 说明 |
|------|--------|------|------|
| 需求文档 | 📋 PM | `R-xxx/requirement.md` | what + why + 验收标准 |
| 设计确认 | 🎨 Designer | 设计稿 / "无需设计"说明 | **不可跳过** |
| 技术方案 | 🏗️ Architect | `R-xxx/technical.md` | how + 架构 + 风险 |
| 三方讨论 | 📋🎨🏗️ | `R-xxx/discussion.md` | 用户审阅所有发言 |
| 任务拆解 | 📋 PM | `R-xxx/T-xxx.md` × N | 原子任务 + 验收标准 |

### 🔨 行 · 实施阶段

| 步骤 | 执行者 | 产出 | 说明 |
|------|--------|------|------|
| 编码实施 | 💻 Developer | 代码变更 | 按 technical.md 实施 |
| 开发日志 | 💻 Developer | `R-xxx/log.md` | 实时记录，newest first |

### 🧪 审 · 验证阶段

| 步骤 | 执行者 | 产出 | 说明 |
|------|--------|------|------|
| 功能验证 | 🧪 Tester | `R-xxx/test.md` | 逐条对照验收标准 |
| 代码审查 | 📝 Reviewer | `R-xxx/review.md` | 代码质量 + 最佳实践 |
| 修复 | 💻 Developer | 代码变更 | 如有 Bug / 审查意见 |
| 验收 | 📋 PM | 验收结论 | 确认所有标准通过 |

### 📦 发布阶段

| 步骤 | 执行者 | 产出 | 说明 |
|------|--------|------|------|
| 发布记录 | 💻 Developer | `R-xxx/release.md` | 变更记录 |

### 🔍 督 · 审计阶段

| 步骤 | 执行者 | 产出 | 说明 |
|------|--------|------|------|
| 审计报告 | 🔍 Auditor | 审计报告 + 记分板更新 | 独立于议/行/审 |
| 复盘 | 📋 PM | `R-xxx/review.md` | 踩坑 + 改进建议 |
| 反馈闭环 | 🔍 Auditor → 🎯 Strategist | 系统性问题 → 新想法 | 治理循环闭合 |

---

## 文档产出清单

每个需求完成后，`R-xxx/` 目录应包含：

| 文件 | 产出者 | 必须 |
|------|--------|------|
| `README.md` | 📋 PM | ✅ |
| `requirement.md` | 📋 PM | ✅ |
| `technical.md` | 🏗️ Architect | ✅ |
| `discussion.md` | 📋🎨🏗️💻 | ✅ 有讨论就必须有 |
| `test.md` | 🧪 Tester | ✅ |
| `review.md` | 📝 Reviewer | ✅ |
| `release.md` | 💻 Developer | ✅ |
| `log.md` | 💻 Developer | ✅ |
| `T-xxx.md` × N | 📋 PM | ✅ |
| `assets/` | 🎨 Designer | 按需 |

---

> 此文档是治理体系的一部分。完整治理手册见 `doc/governance.md`。
