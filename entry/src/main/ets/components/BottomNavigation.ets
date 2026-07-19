/**
 * 底部导航组件 - 可复用
 */

interface TabItem {
  name: string
  icon: string
}

@Component
export struct BottomNavigation {
  @Prop currentIndex: number = 0
  onTabChange?: (index: number) => void

  private tabs: TabItem[] = [
    { name: '首页', icon: 'home' },
    { name: '搜索', icon: 'search' },
    { name: '购物车', icon: 'shopping-cart' },
    { name: '我的', icon: 'user' }
  ]

  build() {
    Row() {
      ForEach(this.tabs, (tab: TabItem, index: number) => {
        Column() {
          // 图标占位（后续替换为 SVG）
          Text('')
            .fontSize(22)
            .fontColor(this.currentIndex === index ? '#4F46E5' : '#9CA3AF')
            .margin({ bottom: 4 })

          // 文字标签
          Text(tab.name)
            .fontSize(11)
            .fontWeight(this.currentIndex === index ? FontWeight.Medium : FontWeight.Regular)
            .fontColor(this.currentIndex === index ? '#4F46E5' : '#9CA3AF')
        }
        .layoutWeight(1)
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          if (this.onTabChange) {
            this.onTabChange(index)
          }
        })
      })
    }
    .width('100%')
    .height(64)
    .backgroundColor(Color.White)
    .border({ width: { top: 1 }, color: '#E5E7EB' })
  }
}
