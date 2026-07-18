---
layout: default
title: 首页
---

# kouol

**一个完全由 AI 驱动开发的 HarmonyOS 教学项目。**

---

## 这是什么

kouol 不只是一个 HarmonyOS 应用 —— 它是一个**透明的开发实验**。

从第一行代码到架构设计，从踩坑记录到复盘反思，**整个过程 100% 由 AI（Claude）完成并完整记录**。我们不只是写代码，更记录 AI 在哪里做得好、在哪里翻车、如何与人类协作。

**目标：** 为其他想用 AI 做开发的人提供一份**真实、可复制**的参考。

## 你将看到什么

- 🏗️ **一个 HarmonyOS 应用从零到上线的完整过程**
- 🤖 **AI 协作的真实记录** —— 不美化、不删减，包括失败和弯路
- 📝 **可复用的协作方法论** —— 想法 → 需求 → 任务 → 执行的完整流程
- 🔍 **每个决策的来龙去脉** —— 为什么选 A 不选 B

## 项目结构

```
kouol/
├── entry/              # HarmonyOS 应用代码（ArkTS）
├── doc/
│   ├── ideas/          # 💭 想法池（I-xxx）
│   └── requirements/   # 📦 需求中心（R-xxx/）
│       └── R-xxx/
│           ├── requirement.md   # 需求文档
│           ├── technical.md     # 技术文档
│           ├── log.md           # 开发日志
│           ├── review.md        # 复盘
│           └── T-xxx.md         # 任务
└── docs/               # 🌐 你正在看的这个博客
```

## 核心原则

1. **需求是宇宙中心** —— 所有文档、任务、日志都围绕需求组织
2. **一切起点是想法** —— 想法 → 需求 → 任务 → 执行
3. **边做边记** —— 每个操作实时记录到 log.md
4. **中断可恢复** —— 打开日志就知道做到哪了

## 当前进展

访问 [需求列表](requirements.md) 查看所有需求的进度。

最新完成的需求：
- ✅ [R-001 建立项目协作机制](https://github.com/Cray-Bear/kouol/tree/main/doc/requirements/R-001) — 建立了完整的想法 → 需求 → 任务 → 日志协作体系

## 如何学习这个项目

1. **从需求开始** —— 每个需求都是一个完整的功能单元，有背景、方案、执行、复盘
2. **读开发日志** —— `log.md` 记录了每一步操作，包括踩坑和解决过程
3. **看复盘** —— `review.md` 总结了经验教训
4. **克隆仓库** —— `git clone https://github.com/Cray-Bear/kouol.git`

## 技术栈

- **平台：** HarmonyOS 6.0.2（API 22）
- **语言：** ArkTS / ArkUI
- **构建：** Hvigor / DevEco Studio
- **AI：** Claude Code（100% AI 驱动）
- **协作：** 需求中心制 + 实时日志

## 博客内容

- [需求列表](requirements.md) — 所有需求及进度
- [想法墙](ideas.md) — 所有想法的集合
- [关于](about.md) — 项目背景和 AI 协作方式

## 链接

- **GitHub 仓库：** [https://github.com/Cray-Bear/kouol](https://github.com/Cray-Bear/kouol)
- **源代码：** [doc/](https://github.com/Cray-Bear/kouol/tree/main/doc) — 完整的文档源文件

---

> *"不要相信未来的自己能记住什么，现在就写下来。"*
