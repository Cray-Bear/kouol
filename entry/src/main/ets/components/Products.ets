/**
 * 精选好物 Grid 组件
 */
import { ProductCard, Product } from './ProductCard'
import { products } from '../data/MockData'

@Component
export struct Products {
  build() {
    Column() {
      Text('精选好物')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#111827')
        .margin({ bottom: 16 })

      Grid() {
        ForEach(products, (product: Product, index: number) => {
          GridItem() {
            ProductCard({ product: product })
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .rowsGap(12)
      .columnsGap(12)
      .height(products.length / 2 * 200 + (products.length / 2 - 1) * 12)
    }
    .width('100%')
  }
}
