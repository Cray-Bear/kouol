---
layout: default
title: 需求列表
---

# 需求列表

> 需求是宇宙中心。所有文档、任务、日志都围绕需求组织。

## 状态说明

- 📝 初稿 — 基于合并的想法提炼
- 📋 已批准 — 确认，待执行
- 🚧 执行中 — 至少有一个任务在做
- ✔️ 已完成 — 全部任务完成
- ❌ 已废弃 — 废弃

---

## 已完成的需求

### ✔️ R-001 · 建立项目协作机制

- **优先级：** P0
- **创建：** 2026-07-18
- **完成：** 2026-07-19
- **来源想法：** I-001

**需求目标：** 建立一套以需求为中心的协作文档体系

**文档：**
- [需求文档](https://github.com/Cray-Bear/kouol/blob/main/doc/requirements/R-001/requirement.md)
- [开发日志](https://github.com/Cray-Bear/kouol/blob/main/doc/requirements/R-001/log.md)
- [复盘文档](https://github.com/Cray-Bear/kouol/blob/main/doc/requirements/R-001/review.md)

**任务：**
- ✅ T-001 初始化 Git 仓库并推送 GitHub
- ✅ T-002 设计协作机制（文档结构、编号、流转）
- ✅ T-003 建立项目文档体系
- ✅ T-004 将协作机制写入 CLAUDE.md

**关键成果：**
- 建立了完整的想法 → 需求 → 任务 → 日志协作体系
- 编号系统：I-xxx（想法）、R-xxx（需求）、T-xxx（任务）
- log.md 实时记录每个操作，中断后可恢复
- 所有约定写入 CLAUDE.md，每次 AI 会话自动遵守

**经验教训：**
- 设计需要用户反馈驱动，不要试图一次到位
- 日志跟着需求走，不是独立存在
- 每次操作实时记录，不做事后总结

---

## 执行中的需求

*（暂无）*

## 待启动的需求

*（暂无）*

---

## 如何阅读需求文档

每个需求 `R-xxx` 都是一个目录，包含：

| 文件 | 内容 | 何时读 |
|------|------|--------|
| `README.md` | 需求主页（状态、来源、索引） | 概览 |
| `requirement.md` | 需求文档（what & why） | 了解背景和目标 |
| `technical.md` | 技术文档（how） | 了解实现方案 |
| `log.md` | 开发日志（newest first） | 了解执行过程 |
| `review.md` | 复盘文档 | 了解经验教训 |
| `T-xxx.md` | 任务文档 | 了解具体任务 |

完整的源文件在 [GitHub](https://github.com/Cray-Bear/kouol/tree/main/doc/requirements)。
