# kouol

**一个完全由 AI 驱动开发的 HarmonyOS 教学项目。**

从第一行代码到架构设计，从踩坑记录到复盘反思，**整个过程 100% 由 AI（Claude）完成并完整记录**。

---

## 🎯 这是什么

kouol 不只是一个 HarmonyOS 应用 —— 它是一个**透明的开发实验**。

我们不只是写代码，更记录 AI 在哪里做得好、在哪里翻车、如何与人类协作。目标是：为其他想用 AI 做开发的人提供一份**真实、可复制**的参考。

## ✨ 你将看到什么

- 🏗️ **一个 HarmonyOS 应用从零到上线的完整过程**
- 🤖 **AI 协作的真实记录** —— 不美化、不删减，包括失败和弯路
- 📝 **可复用的协作方法论** —— 想法 → 需求 → 任务 → 执行
- 🔍 **每个决策的来龙去脉** —— 为什么选 A 不选 B

## 🌐 博客

访问在线博客查看完整的项目记录：

👉 **[https://cray-bear.github.io/kouol/](https://cray-bear.github.io/kouol/)**

## 📁 项目结构

```
kouol/
├── entry/              # HarmonyOS 应用代码（ArkTS）
├── doc/
│   ├── ideas/          # 💭 想法池（I-xxx）
│   └── requirements/   # 📦 需求中心（R-xxx/）
│       └── R-xxx/
│           ├── README.md        # 需求主页
│           ├── requirement.md   # 需求文档 (what & why)
│           ├── technical.md     # 技术文档 (how)
│           ├── log.md           # 开发日志（实时记录）
│           ├── review.md        # 复盘文档
│           ├── T-xxx.md         # 任务文档
│           └── assets/          # 资源文件
├── docs/               # 🌐 博客源文件（GitHub Pages）
└── CLAUDE.md           # 📋 项目约定（AI 必读）
```

## 🧭 核心原则

1. **需求是宇宙中心** —— 所有文档、任务、日志都围绕需求组织
2. **一切起点是想法** —— 想法 → 需求 → 任务 → 执行
3. **边做边记** —— 每个操作实时记录到 log.md
4. **中断可恢复** —— 打开日志就知道做到哪了

## 🚀 快速开始

### 克隆仓库

```bash
git clone https://github.com/Cray-Bear/kouol.git
cd kouol
```

### 阅读文档

1. **从需求开始** — 查看 [`doc/requirements/`](doc/requirements/) 了解项目进展
2. **读开发日志** — 每个需求目录下的 `log.md` 记录了每一步操作
3. **看复盘** — `review.md` 总结了经验教训
4. **理解约定** — [`CLAUDE.md`](CLAUDE.md) 包含所有项目约定

### 构建应用

需要 DevEco Studio 环境：

```powershell
hvigorw assembleHap --mode module -p module=entry@default -p product=default
```

详见 [CLAUDE.md](CLAUDE.md) 中的构建说明。

## 🤝 AI 协作方式

### 使用的工具

- **Claude Code** — 主要的 AI 开发工具
- **DevEco Studio** — HarmonyOS 官方 IDE
- **Git + GitHub** — 版本控制

### 协作原则

1. **人类决策，AI 执行** — 关键决策由人类做出，AI 负责实现
2. **实时记录** — 每个操作都记录到 log.md，不做事后总结
3. **需求驱动** — 所有工作围绕需求展开
4. **透明复盘** — 每次完成后写复盘，包括 AI 的错误和改进方向

## 📊 当前进展

### ✔️ R-001 · 建立项目协作机制

- **完成：** 2026-07-19
- **内容：** 建立了完整的想法 → 需求 → 任务 → 日志协作体系
- **文档：** [需求文档](doc/requirements/R-001/requirement.md) · [开发日志](doc/requirements/R-001/log.md)

更多需求见 [需求列表](doc/requirements/README.md)。

## 📚 技术栈

| 层面 | 技术 |
|------|------|
| 平台 | HarmonyOS 6.0.2（API 22） |
| 语言 | ArkTS / ArkUI |
| 构建 | Hvigor / DevEco Studio |
| AI | Claude Code（100% AI 驱动） |
| 协作 | 需求中心制 + 实时日志 |
| 博客 | GitHub Pages + Jekyll |

## 💡 如何学习这个项目

### 作为学习者

1. 从需求开始 — 每个需求都是一个完整的功能单元
2. 读开发日志 — `log.md` 记录了每一步操作，包括踩坑
3. 看复盘 — `review.md` 总结了经验教训
4. 克隆仓库 — 自己运行、修改、实验

### 作为 AI 开发者

1. 参考协作机制 — 我们的想法 → 需求 → 任务 → 日志流程可以复用
2. 阅读 CLAUDE.md — 项目约定，可以作为你自己项目的起点
3. 关注 AI 错误 — log.md 中 AI 翻车的部分最有价值

### 作为 HarmonyOS 开发者

1. 参考 ArkTS 实践 — 真实项目的代码组织
2. 了解开发体验 — 从零到一的开发过程
3. 复用组件 — 随着项目进展，会产出可复用的组件

## 🔗 链接

- **博客：** [https://cray-bear.github.io/kouol/](https://cray-bear.github.io/kouol/)
- **GitHub：** [https://github.com/Cray-Bear/kouol](https://github.com/Cray-Bear/kouol)
- **文档源文件：** [doc/](doc/)
- **项目约定：** [CLAUDE.md](CLAUDE.md)

---

> *"不要相信未来的自己能记住什么，现在就写下来。"*
