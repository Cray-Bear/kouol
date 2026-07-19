# 编码规范 (Coding Standards)

> **kouol 项目的编码规范。** 从实践中提炼，所有代码必须遵守。
> 修改本规范需经 🔍 Auditor 审批。

---

## 一、基础约定

### 1.1 语言与框架

| 项目 | 约定 |
|------|------|
| 语言 | ArkTS (`.ets` 文件) |
| UI 模型 | ArkUI 声明式 |
| API 级别 | 22 (HarmonyOS 6.0.2) |
| 构建工具 | Hvigor |
| 项目模型 | Stage 模型 |
| Bundle 名称 | `com.fty1.kouol` |

### 1.2 Kit 导入

```typescript
// 使用框架 Kit，不用完整路径
import { router } from '@kit.ArkUI'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { ability } from '@kit.AbilityKit'
```

### 1.3 日志

```typescript
// 统一使用 hilog
// domain: 0x0000, tag: 'testTag'
hilog.info(0x0000, 'testTag', '用户登录成功: %{public}s', username)
```

---

## 二、命名规范

### 2.1 文件命名

| 类型 | 命名规则 | 示例 |
|------|---------|------|
| 页面 | PascalCase | `LoginPage.ets`, `HomePage.ets` |
| 组件 | PascalCase | `ProductCard.ets`, `SearchBar.ets` |
| 工具 | camelCase | `stringUtils.ets`, `apiClient.ets` |
| 模型 | PascalCase | `User.ets`, `Product.ets` |
| 常量 | camelCase + `Constants` | `appConstants.ets` |

### 2.2 代码命名

| 类型 | 命名规则 | 示例 |
|------|---------|------|
| 组件/struct | PascalCase | `struct LoginPage` |
| 变量 | camelCase | `username`, `isLoading` |
| 常量 | UPPER_SNAKE_CASE | `MAX_RETRY_COUNT` |
| 函数 | camelCase | `handleSubmit()`, `fetchData()` |
| 枚举 | PascalCase + PascalCase 值 | `enum Status { Active, Inactive }` |
| 接口 | PascalCase + `I` 前缀（可选） | `interface IUserConfig` |

### 2.3 命名原则

```
✅ 好：
- userName          → 表达意图
- isLoading         → 布尔值用 is/has/can 前缀
- handleSubmit      → 动词+名词
- MAX_RETRY_COUNT   → 常量一看就知道是固定的

❌ 坏：
- data              → 什么数据？
- temp              → 临时的还是不临时的？
- flag              → 什么标志？
- handleData        → 处理什么数据？怎么处理的？
```

> **费曼检验：命名 ≠ 理解。** 变量名要表达意图，不是实现细节。
> 如果别人只看变量名就能理解代码在做什么，命名就成功了。

---

## 三、组件规范

### 3.1 页面结构

```typescript
// 标准页面结构
struct LoginPage {
  // 1. 状态声明
  @State username: string = ''
  @State password: string = ''
  @State isLoading: boolean = false

  // 2. 生命周期
  aboutToAppear() {
    // 页面初始化
  }

  // 3. 构建 UI
  build() {
    Column() {
      // 页面内容
    }
    .width('100%')
    .height('100%')
  }

  // 4. 私有方法
  private async handleSubmit() {
    // 处理逻辑
  }
}
```

### 3.2 属性链式调用

```typescript
// ✅ 每行一个属性，便于阅读和 diff
TextInput({ placeholder: '用户名' })
  .width('100%')
  .height(48)
  .fontSize(16)
  .onChange((value: string) => {
    this.username = value
  })

// ❌ 多个属性挤在一行
TextInput({ placeholder: '用户名' }).width('100%').height(48).fontSize(16)
```

### 3.3 组件拆分原则

```
公理：组件职责单一 → 一个组件只做一件事

拆分信号：
- 组件超过 100 行 → 考虑拆分
- 组件有两种用途 → 必须拆分
- 组件内有独立的状态逻辑 → 应该拆分

✅ 好的拆分：
LoginPage
├── LoginForm          → 表单布局和交互
│   ├── InputField     → 单个输入框（可复用）
│   └── SubmitButton   → 提交按钮
└── LoginHeader        → 页面标题和描述

❌ 坏的做法：
LoginPage → 一个 300 行的 build() 方法
```

### 3.4 列表性能

```typescript
// ✅ 大数据量使用 LazyForEach
LazyForEach(this.dataSource, (item: Product) => {
  ProductCard({ product: item })
}, (item: Product) => item.id)  // keyGenerator 必须

// ❌ 数据量大时用 ForEach（全量渲染）
ForEach(this.products, (item: Product) => {
  ProductCard({ product: item })
})
```

---

## 四、状态管理

### 4.1 状态装饰器选择

| 装饰器 | 用途 | 场景 |
|--------|------|------|
| `@State` | 组件自身状态 | 组件内部数据 |
| `@Prop` | 父 → 子单向传递 | 子组件只读父组件数据 |
| `@Link` | 父 ↔ 子双向绑定 | 子组件需要修改父组件数据 |
| `@Provide/@Consume` | 跨层级传递 | 避免逐层传递 |
| `@StorageLink` | 全局状态 | AppStorage 绑定 |

### 4.2 状态管理公理

```
公理 1：声明式 → UI 是状态的函数，不是手动操作的 DOM
公理 2：最小状态 → 能从已有状态推导的，就不另存一份
公理 3：阶段模型 → @State/@Prop/@Link 够用就不引入更复杂的方案

推导：
- "要不要缓存这个数据？" → 公理 2：能从 API 推导就不存
- "状态太复杂了" → 公理 2：拆成多个 @State 或提取为派生状态
- "UI 没更新？" → 公理 1：检查状态是否真的变了
```

### 4.3 状态管理反模式

```typescript
// ❌ 存派生状态
@State items: Item[] = []
@State itemCount: number = 0  // ← 可以从 items.length 推导，不该存

// ✅ 直接计算
Text(`${this.items.length} 件商品`)
```

---

## 五、资源引用

### 5.1 必须使用 $r() 引用

```typescript
// ✅ 使用资源引用
.width($r('app.float.card_width'))
.fontSize($r('app.font.body'))
.backgroundColor($r('app.color.primary'))

// ❌ 硬编码
.width(335)
.fontSize(16)
.backgroundColor('#4F46E5')
```

### 5.2 资源类型

| 引用方式 | 用途 | 示例 |
|---------|------|------|
| `$r('app.float.xxx')` | 浮点数 | 尺寸、间距 |
| `$r('app.string.xxx')` | 字符串 | 文案 |
| `$r('app.color.xxx')` | 颜色 | 色彩 |
| `$r('app.media.xxx')` | 媒体 | 图片 |
| `$r('app.profile.xxx')` | 配置 | JSON 配置 |

---

## 六、提交规范

### 6.1 Commit Message 格式

```
<type>(<scope>): <subject>

type: feat | fix | docs | style | refactor | test | chore
scope: R-xxx (需求编号)
subject: 一句话描述变更
```

### 6.2 示例

```
feat(R-001): 实现登录页面
fix(R-001): 修复密码验证逻辑
docs(R-001): update log
refactor(R-001): 提取登录表单组件
test(R-001): 添加登录功能单元测试
docs: add I-003
```

---

## 七、代码质量清单

每次提交前自检：

### 功能正确性
- [ ] 功能符合验收标准
- [ ] 边界条件已处理（空值、超长、异常输入）
- [ ] 错误处理完整（网络失败、数据异常）

### 代码质量
- [ ] 命名清晰，表达意图
- [ ] 函数职责单一（不超过 50 行）
- [ ] 无重复代码（DRY）
- [ ] 无硬编码（使用资源引用）

### ArkUI 特性
- [ ] 状态管理正确（@State/@Prop/@Link）
- [ ] 列表使用 LazyForEach（大数据量）
- [ ] 组件嵌套 ≤ 3 层
- [ ] 属性链式调用，每行一个

### 安全
- [ ] 无硬编码密码/密钥
- [ ] 用户输入有验证
- [ ] 网络请求使用 HTTPS

---

## 八、常见陷阱

| 陷阱 | 说明 | 正确做法 |
|------|------|---------|
| ArkTS 不支持 union type | 某些场景不支持 TS union type | 用 interface 或 enum 替代 |
| 组件生命周期不同 | 与 React 有差异 | 查阅 HarmonyOS 文档 |
| .height 只读 | Rectangle 的 height 不能直接赋值 | 使用 `.resize(w, h)` |
| ForEach 性能问题 | 大数据量时全量渲染 | 使用 `LazyForEach` |
| 权限声明遗漏 | 网络请求需要声明权限 | `ohos.permission.INTERNET` |
| 状态不更新 | UI 没响应状态变化 | 检查是否真的修改了 @State 变量 |

---

## 九、代码审查标准

Reviewer 审查时关注：

| 维度 | 检查点 |
|------|--------|
| 可读性 | 命名、注释、函数长度 |
| 可维护性 | 组件拆分、状态管理、DRY |
| 性能 | LazyForEach、避免深层嵌套 |
| 安全 | 输入验证、敏感数据 |
| 一致性 | 与已有代码风格一致 |

---

> **本规范是活文档。** 随着项目演进，会持续更新。
> 修改需经 🔍 Auditor 审批，确保变更服务于协作效率。
