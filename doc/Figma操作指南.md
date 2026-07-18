# Figma + Claude Code 协作指南

## 一、让 Claude 读取 Figma 文件

### 前提条件
- Figma 账户已连接到 Claude Code 的 MCP 插件
- 当前连接账户：beartimer@gmail.com（熊战）
- 计划：Starter（MCP 调用限制约 200 次/天）

### 方式 1：文件导入自己的账户（推荐）
1. 打开别人的 Figma 文件链接
2. 右上角点 **Duplicate**（或 File → Save as duplicate）
3. 选择保存到自己的 Drafts 或项目
4. 把新文件链接发给 Claude

### 方式 2：添加编辑者权限
1. 打开文件，右上角点 **Share**
2. 输入 `beartimer@gmail.com`
3. 权限设为 **can edit**
4. 把链接发给 Claude

### 为什么需要编辑权限
- Figma MCP 工具（get_metadata、get_screenshot、use_figma）都需要编辑权限
- 只有查看权限的话所有工具调用都会报错

## 二、Figma MCP 常用操作

### 查看文件结构
- `get_metadata(fileKey)` — 列出所有页面和节点结构
- `get_screenshot(fileKey, nodeId)` — 截图某个节点
- `get_design_context(fileKey, nodeId)` — 获取设计上下文（代码参考 + 截图 + 元数据）

### 生成/修改设计
- `use_figma(fileKey, code)` — 执行 Figma Plugin API 代码
- `create_new_file(fileName, planKey)` — 创建新文件

### 关键规则
- **fileKey** 从 URL 提取：`figma.com/design/:fileKey/:fileName` → fileKey 就是 `:fileKey` 部分
- **nodeId** 从 URL 提取：`?node-id=993-1920` → `993:1920`
- 颜色用 0-1 范围：`{r: 0.5, g: 0.3, b: 0.1}`
- opacity 放在 paint 层级：`{type:'SOLID', color:{r,g,b}, opacity:0.5}`，不是放在 color 对象里
- auto-layout 属性：`primaryAxisAlignItems`（对齐），`counterAxisAlignItems`（交叉轴对齐），`primaryAxisSizingMode`（FIXED/AUTO）
- `layoutPositioning = 'ABSOLUTE'` 只能在父节点有 layoutMode 时使用
- 每次 use_figma 最多 10 个逻辑操作，分步执行
- 必须用 `return` 返回值，不能用 `console.log`

## 三、当前项目状态

### 文件
- **E-Commerce App UI**：`https://www.figma.com/design/uZNsVLF1bXBdxxeOOjRgUA`
  - 已生成：Home Screen（11:2）、Product Detail（12:2）
  - 待生成：Cart Screen、Profile Screen

### 页面结构
```
📱 App Screens
  ├── Home Screen (375x812, x=0)
  ├── Product Detail (375x812, x=420)
  ── (待添加) Cart, Profile
🎨 Components
  └── (空)
```

### 设计规范
- 主色：#4F46E5（indigo）
- 强调色：#F97316（orange）
- 背景：#F9FAFB
- 字体：Inter（Regular / Medium / Semi Bold / Bold）
- 屏幕尺寸：375x812（圆角 32）
- 底部导航栏：悬浮胶囊样式，圆角 20

## 四、从 Figma 生成 ArkUI 代码的流程

1. 用 `get_design_context` 获取某个节点的完整设计信息
2. 提取：尺寸、颜色、间距、字体、圆角、阴影等参数
3. 用 `get_screenshot` 获取视觉参考
4. 根据设计参数编写 ArkUI 代码
5. 在 DevEco Studio 中验证效果

## 五、常见问题

| 问题 | 原因 | 解决 |
|------|------|------|
| "don't have edit access" | 没有编辑权限 | Duplicate 文件或添加编辑者 |
| "MCP tool call limit" | Starter 计划限制 | 等 1 小时重置，或升级计划 |
| "opacity in color" | opacity 放错位置 | 移到 paint 对象层级 |
| "layoutPositioning ABSOLUTE" | 父节点没有 layoutMode | 先给父节点设 layoutMode，或用绝对坐标 |
| "primaryAxisSizingMode SPACE_BETWEEN" | 属性名写错 | 应该用 primaryAxisAlignItems |
| "counterAxisSizingMode CENTER" | 属性名写错 | CENTER 是 AlignItems 的值，不是 SizingMode |
