# R-004 讨论记录

| # | 日期 | 类型 | 参与方 | 结论 |
|---|------|------|--------|------|
| 1 | 2026-07-19 | 三方讨论 | 🎯 Strategist · 🎨 Designer · 🏗️ Architect | 技术方案确认，见下方 |

---

## 2026-07-19 — R-004 主页开发三方讨论

**类型：** 三方讨论
**发起：** 🎯 Strategist
**诉求：** 讨论主页 p001 的技术实现方案

### 背景

- Figma 已有 p001 设计稿（375×812）
- 目标：用 ArkUI/ArkTS 还原设计，走通治理流程
- 页面结构：状态栏 + 问候区 + 搜索栏 + Banner + 商品分类 + 精选好物 Grid + 底部导航

---

###  Strategist 发言

**需求目标和验收标准已明确（见 requirement.md）：**
- 主页在模拟器上正常运行
- 视觉还原 Figma 设计稿
- 商品 Grid 展示正确
- Banner 可轮播
- 底部导航正确显示
- 治理流程完整记录

**关键约束：**
1. **教学项目** → 代码可读性比性能更重要，每个关键组件都要有注释
2. **Mock 数据** → 暂不接入后端，用本地 mock 数据
3. **基础架构** → 路由和底部导航组件要可复用，为后续页面做准备

**问题：**
- 底部导航组件的复用方式？每个 Tab 页是独立页面还是条件渲染？
- Banner 轮播用哪种实现方式？

---

### 🎨 Designer 发言

**设计还原要点：**
1. **整体风格** — 干净的电商首页，Indigo 主色 + Orange 强调色
2. **状态栏** — 9:41 + 电池图标，44px 高
3. **问候区** — "你好，Sarah" Bold 22px + 头像（42px 圆形）
4. **搜索栏** — 48px 高，圆角 12px，灰色占位文字
5. **Banner** — 170px 高，圆角 16px，图片背景 + 半透明遮罩 + 白色标题 + Orange CTA 按钮
6. **商品分类** — 4 个彩色圆角方块，每个 72×72px + 图标 + 标签
7. **精选好物** — 2 列 Grid，每个卡片 160×200px，圆角 14px
8. **底部导航** — 64px 高，4 个 Tab，当前选中项 Indigo 色

**设计挑战：**
- **Banner 轮播** — Figma 是静态设计，轮播需要指示器（小圆点）
- **分类图标** — 4 个分类各有不同底色（indigo-tint / orange-tint / green-tint / violet-tint）
- **底部导航** — 4 个 Tab 的图标和选中状态

**建议：**
- Banner 轮播用 3 张图 + 底部指示器（3 个小圆点）
- 分类图标用 Lucide SVG，与 Figma 设计保持一致
- 底部导航组件封装为 `BottomNavigation.ets`，通过 props 控制选中项

---

### 🏗️ Architect 发言

**技术方案：**

#### 1. 项目结构

```
entry/src/main/ets/
── pages/
│   ├── Index.ets          # 主入口，加载 HomePage
│   └── HomePage.ets       # 主页
├── components/
│   ├── BottomNavigation.ets  # 底部导航（可复用）
│   └── ProductCard.ets       # 商品卡片（可复用）
├── models/
│   ── Product.ets          # 商品数据模型
├── data/
│   └── MockData.ets         # Mock 数据
└── entryability/
    └── EntryAbility.ets     # 已有，保持不变
```

#### 2. 路由方案

- **底部导航**：用 `@State currentIndex` 控制选中项，4 个 Tab 对应 4 个页面组件
- **页面跳转**：用 `router.pushUrl()` 跳转到商品详情页（p002，P1 实现）
- **路由注册**：在 `main_pages.json` 中注册所有页面

#### 3. 底部导航组件

```typescript
// BottomNavigation.ets
@Component
struct BottomNavigation {
  @Prop currentIndex: number = 0
  @Event onTabChange: (index: number) => void

  private tabs = [
    { name: '首页', icon: 'home' },
    { name: '搜索', icon: 'search' },
    { name: '购物车', icon: 'shopping-cart' },
    { name: '我的', icon: 'user' },
  ]

  build() {
    Row() {
      ForEach(this.tabs, (tab, index) => {
        Column() {
          // 图标（SVG）
          // 文字
        }
        .onClick(() => this.onTabChange(index))
      })
    }
    .width('100%')
    .height(64)
    .backgroundColor(Color.White)
  }
}
```

#### 4. Banner 轮播

- 使用 ArkUI 的 `Swiper` 组件
- 3 张 Banner 图片 + 自动轮播（5 秒间隔）
- 底部指示器（小圆点，当前页高亮）

#### 5. 商品 Grid

- 使用 `Grid` + `GridItem` 组件
- 2 列布局，每个卡片 160×200px
- 卡片内容：图片（110×110）+ 名称 + 价格

#### 6. 数据模型

```typescript
// Product.ets
export interface Product {
  id: string
  name: string
  price: number
  image: string  // 先用资源路径，后续可替换为网络 URL
}
```

#### 7. Mock 数据

```typescript
// MockData.ets
export const products: Product[] = [
  { id: '1', name: 'Nike Air Max', price: 929, image: '...' },
  { id: '2', name: 'Galaxy Buds', price: 639, image: '...' },
  // 更多商品...
]

export const banners = [
  { id: '1', title: '夏日特惠', subtitle: '精选商品低至五折', image: '...' },
  // 更多 Banner...
]
```

#### 8. 资源管理

- 商品图片和 Banner 图片先放在 `resources/base/media/` 目录
- 分类图标用 Lucide SVG，放在 `resources/base/media/` 或代码内嵌

#### 9. 关键技术点

| 技术点 | 方案 | 说明 |
|--------|------|------|
| 路由 | `router.pushUrl()` | ArkUI 标准路由 |
| 底部导航 | 自定义组件 + `@Prop`/`@Event` | 可复用 |
| Banner 轮播 | `Swiper` 组件 | 内置组件，支持自动轮播 |
| 商品 Grid | `Grid` + `GridItem` | 2 列布局 |
| 状态管理 | `@State` + `@Prop` | 局部状态，暂不需要全局 |
| SVG 图标 | `createNodeFromSvg()` | Lucide 图标 |

#### 10. 风险和建议

| 风险 | 等级 | 对策 |
|------|------|------|
| SVG 图标在 ArkUI 中的渲染 | 中 | 先测试一个图标，确认方案可行 |
| Swiper 组件的自定义指示器 | 低 | 用 Row + Circle 手动实现 |
| 图片资源管理 | 低 | 先用占位图，后续替换为真实图片 |

**建议：**
1. **先搭框架** — 先实现页面结构和底部导航，再填充内容
2. **先静态后动态** — 先实现静态 UI，再加轮播和交互
3. **先 mock 后真实** — 先用 mock 数据，后续接入 API

---

### 结论

- ✅ **技术方案确认**：按 Architect 的方案执行
- ✅ **组件复用**：`BottomNavigation.ets` 和 `ProductCard.ets` 封装为可复用组件
- ✅ **Mock 数据**：用本地 mock 数据，暂不接入后端
- ✅ **开发顺序**：框架 → 静态 UI → 动态交互 → 测试
- ⬜ **待确认**：SVG 图标在 ArkUI 中的具体实现方式（Developer 实施时验证）

**状态：** 已达成共识

---

### 下一步

1. 🏗️ Architect 完成 `technical.md`
2.  Strategist 拆解任务（T-xxx）
3. 💻 Developer 按方案实施
