# R-002 技术文档

## 方案概述

使用 GitHub Pages + Jekyll 搭建博客，放在 `docs/` 目录，GitHub 自动部署。

## 目录结构

```
docs/                          # 博客源文件
├── _config.yml                # Jekyll 配置
├── index.md                   # 首页
├── requirements.md            # 需求列表页
├── ideas.md                   # 想法墙
└── about.md                   # 关于页
```

## 配置说明

### _config.yml

```yaml
title: kouol
description: 一个完全由 AI 驱动开发的 HarmonyOS 教学项目
baseurl: "/kouol"
url: "https://cray-bear.github.io"
theme: jekyll-theme-minimal
```

### 主题

使用 GitHub Pages 内置的 `jekyll-theme-minimal`，极简风格，适合教学项目。

### 内容策略

博客页面**手动维护**，不是自动生成：
- 从 `doc/requirements/` 中选取关键信息
- 博客页面链接到 GitHub 源文件
- 保持博客简洁，详细内容在仓库中

## 部署流程

1. 推送代码到 `main` 分支
2. GitHub 自动构建 Jekyll 站点
3. 部署到 `https://cray-bear.github.io/kouol/`

**需要在 GitHub 仓库设置中启用 Pages：**
- Settings → Pages
- Source: Deploy from a branch
- Branch: `main` / `docs` folder

## 链接策略

博客中的链接指向：
- **GitHub 源文件** — 详细内容（如 log.md、review.md）
- **博客内部页面** — 导航（如需求列表、想法墙）

## 后续扩展

- 可以添加 `_posts/` 目录写独立博客文章
- 可以自定义 CSS 进一步调整样式
- 可以添加评论系统（如 Disqus）
