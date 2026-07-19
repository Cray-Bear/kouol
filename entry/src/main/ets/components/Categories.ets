/**
 * 商品分类组件
 */

interface CategoryItem {
  id: string
  name: string
  bgColor: string
}

@Component
export struct Categories {
  private categories: CategoryItem[] = [
    { id: '1', name: '服饰', bgColor: '#EEF2FF' },
    { id: '2', name: '数码', bgColor: '#FFF7ED' },
    { id: '3', name: '家居', bgColor: '#ECFDF5' },
    { id: '4', name: '运动', bgColor: '#F5F3FF' }
  ]

  build() {
    Column() {
      Text('商品分类')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#111827')
        .margin({ bottom: 16 })

      Row() {
        ForEach(this.categories, (category: CategoryItem, index: number) => {
          Column() {
            Stack()
              .width(72)
              .height(72)
              .backgroundColor(category.bgColor)
              .borderRadius(14)

            Text(category.name)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111827')
              .margin({ top: 8 })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
    }
    .width('100%')
  }
}
