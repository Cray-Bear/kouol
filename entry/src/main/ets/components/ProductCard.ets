/**
 * 商品卡片组件 - 可复用
 */

export interface Product {
  id: string
  name: string
  price: number
  image: Resource | string
}

@Component
export struct ProductCard {
  @Prop product: Product

  build() {
    Column() {
      Stack()
        .width(136)
        .height(110)
        .backgroundColor('#F3F4F6')
        .borderRadius(10)

      Text(this.product.name)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#111827')
        .margin({ top: 12 })
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width(136)

      Text(`¥${this.product.price}`)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#4F46E5')
        .margin({ top: 4 })
    }
    .width(160)
    .height(200)
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(14)
  }
}
