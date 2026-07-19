/**
 * Header 组件 - 问候语 + 头像
 */
@Component
export struct Header {
  private greeting: string = '你好，Sarah'

  build() {
    Row() {
      Text(this.greeting)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111827')

      Blank()

      // 头像占位
      Stack() {
        Stack()
          .width(42)
          .height(42)
          .backgroundColor('#EEF2FF')
          .borderRadius(21)
      }
    }
    .width('100%')
    .height(52)
    .alignItems(VerticalAlign.Center)
  }
}
