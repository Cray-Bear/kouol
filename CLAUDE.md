# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目定位

**kouol 是一个纯 AI 驱动的教学项目。** 全部开发过程由 AI（主要是 Claude）完成，目标是记录 AI 开发的真实过程 —— 包括做了什么、怎么做的、踩了哪些坑、AI 哪里做对了、哪里翻车了。

产出**不只是代码本身**，更是完整的协作文档体系，供其他想用 AI 做开发的人参考。

---

## 协作机制（必须遵守）

### 核心理念

- **需求是宇宙中心** —— 所有文档、任务、日志都围绕需求组织
- **一切起点是想法** —— 想法 → 需求 → 任务 → 执行
- **边做边记** —— 每个操作实时记录到需求的日志里
- **中断可恢复** —— 打开 log.md 就知道做到哪了

### 文档结构

```
doc/
├── ideas/                       # I-xxx 想法（全局连续编号）
│   ├── README.md                # 想法索引
│   └── I-001.md
│
└── requirements/                # R-xxx 需求（目录，全局连续编号）
    ├── README.md                # 需求总索引（按优先级/状态）
    └── R-001/                   # 一个需求 = 一个目录
        ├── README.md            # 需求主页（状态、来源想法、文档/任务索引）
        ├── requirement.md       # 需求文档 (what & why)
        ├── technical.md         # 技术文档 (how)
        ├── test.md              # 测试文档
        ├── release.md           # 发布文档
        ├── review.md            # 复盘文档
        ├── log.md               # ⭐ 开发日志（newest first）
        ├── T-001.md             # 任务（编号全局连续）
        ├── T-002.md
        └── assets/              # 资源（截图、设计稿）
```

项目级文档（架构总览、编码规范等）放在 `doc/` 根目录。

### 编号规则

| 类型 | 格式 | 示例 | 范围 | 存放位置 |
|------|------|------|------|---------|
| 想法 | `I-{3位}` | `I-001` | 全局连续 | `doc/ideas/I-001.md` |
| 需求 | `R-{3位}` | `R-001` | 全局连续 | `doc/requirements/R-001/`（目录） |
| 任务 | `T-{3位}` | `T-001` | 全局连续 | 放在对应 `R-xxx/` 内 |

需求目录内的文档不单独编号（R-xxx 本身就是标识符），文件名用类型名。

### 状态模型

**想法状态：** 新建 → 已合并(→R-xxx) / 已废弃

**需求状态：** 初稿 → 已批准 → 执行中 → 已完成 / 已废弃

**任务状态：** 待办 → 执行中 → 待 review → 已完成 / 已废弃 / 阻塞

**需求优先级：**
- `P0` 本周必做
- `P1` 高（本月）
- `P2` 中（季度内）
- `P3` 低（someday）

### 流转

```
💭 I-xxx (新建)
   ↓ 合并提炼（一个或多个想法 → 一个需求）
📝 R-xxx/requirement.md (初稿)
   ↓ 确认
📋 R-xxx (已批准) ─── 写 technical.md（技术方案）
   ↓ 拆解              ─── 写 test.md（测试计划）
🔨 T-xxx (待办) ← 在 R-xxx/ 内
   ↓ 执行（log.md 实时记录，链接 T-xxx）
✔️ T-xxx (完成)
   ↓ 发布
📦 release.md (发布记录)
   ↓ 全部任务完成
✔️ R-xxx (完成)
   ↓ 复盘
📝 review.md (复盘总结)
```

### 开发日志约定（log.md）

**日志跟着需求走，不是独立存在。** 每个需求目录必须有 `log.md`。

**格式：newest first** —— 打开文件第一眼看到当前状态和下一步。

```markdown
# R-001 开发日志

> **当前状态：** 🚧 执行中 | **进度：** 3/5 任务完成
> **下一步：** T-003 接入 AES 加密

---

## 2026-07-18 14:30 — T-002 完成：设计用户模型
- 创建了 `src/models/User.ets`
- 遇到问题：ArkTS 不支持 xxx，改用 yyy
- ✅ T-002 完成

## 2026-07-18 14:00 — T-001 完成：搭建登录页面
- 创建 `pages/Login.ets`
- ✅ T-001 完成
```

**写入时机：** 以下任一情况发生，立即追加到 log.md 顶部：
- 执行了命令（成功或失败）
- 创建 / 修改 / 删除了文件
- 遇到错误并排查
- 做了重要决策
- 会话开始 / 结束

**会话恢复：** 每次开始工作时，先读相关需求的 `log.md` 顶部，接上进度。

### AI 工作流

| 用户说 | AI 做 |
|--------|--------|
| "我有个想法：..." | 创建 `doc/ideas/I-xxx.md` |
| "这些想法可以做" | 创建 `doc/requirements/R-xxx/`，合并想法，起草 requirement.md |
| "开始做 R-xxx" | 拆解为 T-xxx，放入 R-xxx/，创建 technical.md 和 test.md |
| 执行任务 | 更新任务状态，**log.md 实时记录每个操作** |
| 任务完成 | 更新状态，log.md 标记完成 |
| 需求全部完成 | 更新 R-xxx 状态，写 release.md 和 review.md |

### 链接关系

- `I-xxx.md` → "已合并到 R-yyy"
- `R-xxx/README.md` → "来源想法：I-001, I-002"；"包含任务：T-001, T-002"
- `R-xxx/T-yyy.md` → "所属需求：R-xxx"
- `R-xxx/log.md` → 每条记录关联 T-xxx
- `requirements/README.md` → 所有需求的总索引

### Git 提交约定

- 需求相关变更 commit message 带上编号：`feat(R-001): 实现登录页面`
- 日志更新：`docs(R-001): update log`
- 新建想法：`docs: add I-003`
- 新建需求：`docs: add R-002`

### 价值判断

**翻车的记录 > 成功的记录。** 失败的排查过程、AI 犯的错、走弯路的决策 —— 这些最有价值。诚实记录，不要美化。

## 项目概述

HarmonyOS 手机应用，目标 API 22（HarmonyOS 6.0.2），Stage 模型。Bundle 名称：`com.fty1.kouol`。使用 DevEco Studio / Hvigor 构建。当前为脚手架模板——单 `entry` 模块，包含 Hello World 页面。

## 构建与运行

所有命令在项目根目录执行，需要 DevEco Studio SDK 在 PATH 中（或使用 DevEco Studio 内置终端）。

```powershell
# 构建 debug HAP
hvigorw assembleHap --mode module -p module=entry@default -p product=default

# 构建 release HAP
hvigorw assembleHap --mode module -p module=entry@default -p product=default -p buildMode=release

# 运行设备端测试（需连接设备/模拟器）
hvigorw test --mode module -p module=entry@default -p product=default

# 运行本地单元测试
hvigorw test --mode module -p module=entry@default -p product=default -p testType=local

# 清理构建产物
hvigorw clean
```

日常开发主要使用 DevEco Studio 的 Run/Debug 功能——点击 Run 按钮或按 Shift+F10。

### 一键构建部署脚本

```powershell
.\build-and-deploy.ps1            # 仅构建
.\build-and-deploy.ps1 -Deploy    # 构建 + 安装到设备 + 启动应用
```

脚本自动注入 hdc / ohpm / node 到 PATH，无需手动配置环境变量。

> **编码要求：** `.ps1` 文件必须保存为 **UTF-8 BOM + CRLF** 换行。PowerShell 5.1 在中文 Windows 上默认用 GBK 读取脚本，UTF-8 无 BOM 会导致中文注释破坏后续变量赋值。通过 Write 工具创建/编辑 `.ps1` 后，需用 PowerShell 转换编码：
> ```powershell
> $c = Get-Content "xxx.ps1" -Raw -Encoding UTF8
> $c = $c -replace "`r`n","`n" -replace "`n","`r`n"
> [System.IO.File]::WriteAllText("xxx.ps1", $c, [System.Text.UTF8Encoding]::new($true))
> ```

## 代码检查

```powershell
hvigorw lint --mode module -p module=entry@default
```

`code-linter.json5` 配置：
- 规则集：`@performance/recommended` + `@typescript-eslint/recommended`
- **安全规则（error 级别）：** 禁止不安全的 AES、hash、DH、DSA、ECDSA、RSA 加密/签名/密钥、3DES
- 作用于 `**/*.ets` 文件；排除 test、mock、build、oh_modules 目录

## 架构

### 模块：`entry`（HAP — 入口模块）

**Ability：**
- `EntryAbility`（`entry/src/main/ets/entryability/EntryAbility.ets`）— UIAbility，应用主入口。颜色模式设为 `COLOR_MODE_NOT_SET`（跟随系统），窗口创建时加载 `pages/Index`。
- `EntryBackupAbility`（`entry/src/main/ets/entrybackupability/EntryBackupAbility.ets`）— BackupExtensionAbility，处理备份/恢复。在 `module.json5` 中配置，元数据引用 `backup_config.json`。

**页面路由：** 配置文件位于 `entry/src/main/resources/base/profile/main_pages.json`，当前仅有 `pages/Index`。

**资源：** `base/` 为默认资源，`dark/` 为深色模式覆盖（目前仅有 `start_window_background` 颜色）。

### 测试结构

| 目录 | 类型 | 框架 |
|------|------|------|
| `entry/src/test/` | 本地单元测试（无需设备） | `@ohos/hypium` |
| `entry/src/ohosTest/` | 设备端测试（需连接设备） | `@ohos/hypium` + `@ohos/hamock` |
| `entry/src/mock/` | Mock 配置 | `@ohos/hamock` |

每个测试目录下的 `List.test.ets` 为测试入口，导入并注册测试套件。

## 关键约定

- **语言：** ArkTS（`.ets` 文件），ArkUI 声明式组件模型
- **Kit 导入：** `@kit.AbilityKit`、`@kit.PerformanceAnalysisKit`、`@kit.ArkUI`、`@kit.CoreFileKit`
- **日志：** 使用 `hilog`，domain `0x0000`，tag `'testTag'`（模板项目全局约定）
- **资源引用：** `$r('app.float.xxx')`、`$string:xxx`、`$media:xxx`、`$color:xxx`、`$profile:xxx`
- **签名配置：** `build-profile.json5` 中 signingConfigs 为空数组——release 构建前需在 DevEco Studio 中配置
- **代码混淆：** release 构建启用属性、顶层、文件名、导出混淆（`entry/obfuscation-rules.txt`）
- **`local.properties`：** DevEco Studio 自动生成，请勿手动修改或提交
