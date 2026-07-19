# R-004 · 主页开发 — 技术方案

> **版本：** 1.0 | **日期：** 2026-07-19 | **作者：** 🏗️ Architect
> **基于：** 三方讨论结论

---

## 架构概览

```
┌─────────────────────────────────────┐
│  HomePage.ets（主页容器）            │
│  ┌─────────────────────────────┐    │
│  │  Header（问候 + 头像）       │    │
│  │  SearchBar（搜索栏）         │    │
│  │  Banner（Swiper 轮播）       │    │
│  │  Categories（商品分类）      │    │
│  │  ProductGrid（精选好物）     │    │
│  └─────────────────────────────┘    │
│  ┌─────────────────────────────┐    │
│  │  BottomNavigation（底部导航）│    │
│  └─────────────────────────────┘    │
└─────────────────────────────────────┘
```

---

## 项目结构

```
entry/src/main/ets/
├── pages/
│   ├── Index.ets              # 主入口（已有，加载 HomePage）
│   ── HomePage.ets           # 主页（新建）
├── components/
│   ├── BottomNavigation.ets   # 底部导航组件（新建，可复用）
│   ── ProductCard.ets        # 商品卡片组件（新建，可复用）
├── models/
│   └── Product.ets            # 商品数据模型（新建）
├── data/
│   └── MockData.ets           # Mock 数据（新建）
└── entryability/
    └── EntryAbility.ets       # 已有，保持不变
```

---

## 核心组件设计

### 1. HomePage.ets（主页容器）

```typescript
@Entry
@Component
struct HomePage {
  @State currentTab: number = 0  // 当前选中的 Tab 索引

  build() {
    Column() {
      // 主内容区（可滚动）
      Scroll() {
        Column() {
          HeaderSection()      // 问候区
          SearchBar()          // 搜索栏
          BannerSection()      // Banner 轮播
          CategoriesSection()  // 商品分类
          ProductsSection()    // 精选好物
        }
        .padding({ left: 20, right: 20 })
      }
      .layoutWeight(1)  // 占据剩余空间

      // 底部导航（固定）
      BottomNavigation({
        currentIndex: this.currentTab,
        onTabChange: (index: number) => {
          this.currentTab = index
        }
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
  }
}
```

### 2. BottomNavigation.ets（底部导航）

```typescript
@Component
struct BottomNavigation {
  @Prop currentIndex: number = 0
  @Event onTabChange: (index: number) => void

  private tabs: TabItem[] = [
    { name: '首页', icon: 'home' },
    { name: '搜索', icon: 'search' },
    { name: '购物车', icon: 'shopping-cart' },
    { name: '我的', icon: 'user' },
  ]

  build() {
    Row() {
      ForEach(this.tabs, (tab: TabItem, index: number) => {
        Column() {
          // SVG 图标
          Text(tab.name)
            .fontSize(11)
            .fontColor(index === this.currentIndex ? '#4F46E5' : '#9CA3AF')
        }
        .layoutWeight(1)
        .height(64)
        .justifyContent(FlexAlign.Center)
        .onClick(() => this.onTabChange(index))
      })
    }
    .width('100%')
    .height(64)
    .backgroundColor(Color.White)
    .border({ width: { top: 1 }, color: '#E5E7EB' })
  }
}

interface TabItem {
  name: string
  icon: string
}
```

### 3. ProductCard.ets（商品卡片）

```typescript
@Component
struct ProductCard {
  @Prop product: Product

  build() {
    Column() {
      // 商品图片
      Image(this.product.image)
        .width(136)
        .height(110)
        .borderRadius(10)
        .objectFit(ImageFit.Cover)

      // 商品名称
      Text(this.product.name)
        .fontSize(14)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#111827')
        .margin({ top: 12 })
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      // 价格
      Text(`¥${this.product.price}`)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#4F46E5')
        .margin({ top: 4 })
    }
    .width(160)
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(14)
  }
}
```

### 4. Product.ets（数据模型）

```typescript
export interface Product {
  id: string
  name: string
  price: number
  image: Resource | string
}

export interface Banner {
  id: string
  title: string
  subtitle: string
  image: Resource | string
}

export interface Category {
  id: string
  name: string
  icon: string
  bgColor: string
}
```

### 5. MockData.ets（Mock 数据）

```typescript
import { Product, Banner, Category } from '../models/Product'

export const products: Product[] = [
  { id: '1', name: 'Nike Air Max', price: 929, image: $r('app.media.product_nike') },
  { id: '2', name: 'Galaxy Buds', price: 639, image: $r('app.media.product_buds') },
  { id: '3', name: '经典 T 恤', price: 199, image: $r('app.media.product_tshirt') },
  { id: '4', name: '智能手表', price: 1299, image: $r('app.media.product_watch') },
]

export const banners: Banner[] = [
  { id: '1', title: '夏日特惠', subtitle: '精选商品低至五折', image: $r('app.media.banner_summer') },
  { id: '2', title: '新品上市', subtitle: '最新数码好物', image: $r('app.media.banner_new') },
  { id: '3', title: '品牌日', subtitle: '大牌直降', image: $r('app.media.banner_brand') },
]

export const categories: Category[] = [
  { id: '1', name: '服饰', icon: 'shirt', bgColor: '#EEF2FF' },
  { id: '2', name: '数码', icon: 'smartphone', bgColor: '#FFF7ED' },
  { id: '3', name: '家居', icon: 'home', bgColor: '#ECFDF5' },
  { id: '4', name: '运动', icon: 'dumbbell', bgColor: '#F5F3FF' },
]
```

---

## 路由配置

### main_pages.json

```json
{
  "src": [
    "pages/Index",
    "pages/HomePage"
  ]
}
```

### Index.ets（主入口）

```typescript
@Entry
@Component
struct Index {
  build() {
    HomePage()
  }
}
```

---

## SVG 图标方案

### 方案：内嵌 SVG 字符串

```typescript
// 在组件中直接用 SVG 字符串
const homeIcon = `<svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" 
  viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
  <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/>
</svg>`

// 使用 Image 组件加载
Image(homeIcon)
  .width(22)
  .height(22)
  .fillColor(currentIndex === 0 ? '#4F46E5' : '#9CA3AF')
```

**注意：** ArkUI 的 `Image` 组件支持 SVG 字符串，但需要测试 `fillColor` 是否生效。如果不生效，备选方案是用 `drawingImage` 或位图图标。

---

## 开发顺序

| 步骤 | 任务 | 说明 |
|------|------|------|
| 1 | 搭建页面框架 | Index.ets + HomePage.ets 基础结构 |
| 2 | 实现底部导航 | BottomNavigation.ets 组件 |
| 3 | 实现 Header + SearchBar | 静态 UI |
| 4 | 实现 Banner 轮播 | Swiper 组件 |
| 5 | 实现商品分类 | 4 个彩色方块 + 图标 |
| 6 | 实现商品 Grid | ProductCard.ets + Grid 布局 |
| 7 | 集成 Mock 数据 | 替换静态数据 |
| 8 | 联调测试 | 功能验证 + 视觉对比 |

---

## 资源需求

### 图片资源

需要以下图片放入 `resources/base/media/`：

| 文件名 | 用途 | 来源 |
|--------|------|------|
| `banner_summer.png` | Banner 1 | Figma 设计稿导出 |
| `banner_new.png` | Banner 2 | Figma 设计稿导出 |
| `banner_brand.png` | Banner 3 | Figma 设计稿导出 |
| `product_nike.png` | Nike 商品图 | Figma 设计稿导出 |
| `product_buds.png` | Galaxy Buds 商品图 | Figma 设计稿导出 |
| `product_tshirt.png` | T 恤商品图 | 占位图 |
| `product_watch.png` | 手表商品图 | 占位图 |
| `avatar.png` | 用户头像 | Figma 设计稿导出 |

### SVG 图标

| 图标 | 用途 | Lucide 名称 |
|------|------|------------|
| 首页 | 底部导航 Tab 1 | `home` |
| 搜索 | 底部导航 Tab 2 + 搜索栏 | `search` |
| 购物车 | 底部导航 Tab 3 | `shopping-cart` |
| 我的 | 底部导航 Tab 4 | `user` |
| 服饰 | 分类图标 1 | `shirt` |
| 数码 | 分类图标 2 | `smartphone` |
| 家居 | 分类图标 3 | `home` |
| 运动 | 分类图标 4 | `dumbbell` |
| 通知 | 头像旁边（如有） | `bell` |

---

## 技术风险

| 风险 | 等级 | 对策 |
|------|------|------|
| SVG 图标渲染 | 中 | 先测试一个图标，确认方案；备选：用 PNG 图标 |
| Swiper 自定义指示器 | 低 | 手动用 Row + Circle 实现 |
| 图片资源管理 | 低 | 先用占位图，后续替换 |
| Grid 布局适配 | 低 | 固定 2 列，卡片宽度固定 |

---

## 验收技术清单

- [ ] 页面在模拟器上正常运行
- [ ] 底部导航 4 个 Tab 正确显示
- [ ] Banner 轮播正常工作（自动 + 手动）
- [ ] 商品 Grid 2 列布局正确
- [ ] 所有文字为中文，无英文占位符
- [ ] 颜色使用语义 token（Primary #4F46E5, Accent #F97316）
- [ ] 代码有注释，关键逻辑有说明
