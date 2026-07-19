/**
 * 搜索栏组件
 */
@Component
export struct SearchBar {
  @State searchText: string = ''
  private placeholder: string = '搜索商品'

  build() {
    Row() {
      Text('🔍')
        .fontSize(18)
        .margin({ right: 8 })

      TextInput({ placeholder: this.placeholder, text: this.searchText })
        .layoutWeight(1)
        .fontSize(15)
        .fontColor('#111827')
        .placeholderColor('#9CA3AF')
        .backgroundColor(Color.Transparent)
        .onChange((value: string) => {
          this.searchText = value
        })
    }
    .width('100%')
    .height(48)
    .padding({ left: 16, right: 16 })
    .backgroundColor(Color.White)
    .borderRadius(12)
  }
}
