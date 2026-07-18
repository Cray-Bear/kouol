# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目定位

**kouol 是一个纯 AI 驱动的教学项目。** 全部开发过程由 AI（主要是 Claude）完成，目标是记录 AI 开发的真实过程 —— 包括做了什么、怎么做的、踩了哪些坑、AI 哪里做对了、哪里翻车了。

这个项目的产出**不只是代码本身**，更是 `doc/dev-log/` 下的完整开发日志，供其他想用 AI 做开发的人参考。

## 开发日志约定（必须遵守）

**每次开发会话结束前，AI 必须主动生成或追加当天的日志。** 不写日志 = 这次开发不算完成。

日志规范：
- **位置：** `doc/dev-log/YYYY-MM-DD.md`（一天多篇用 `-02`、`-03` 后缀）
- **模板：** 见 [`doc/dev-log/TEMPLATE.md`](doc/dev-log/TEMPLATE.md)
- **索引：** 新日志写完要更新 [`doc/dev-log/README.md`](doc/dev-log/README.md) 的表格
- **重点内容：**
  1. **踩坑** —— 现象、排查过程、根因、解决方案、给未来 AI 的提示
  2. **AI 协作经验** —— 什么 prompt 有效、AI 在哪里翻车、哪些任务适合 / 不适合 AI
- **不要写成：** 代码搬运、流水账、空洞的成功汇报
- **要写成：** 让未来读到这篇日志的人（或 AI）能避开同样的坑

**日志完成后，单独提交一次：** `git commit -m "docs: add dev log YYYY-MM-DD"`。

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
