import { HomePage } from './HomePage'

@Entry
@Component
struct Index {
  build() {
    Column() {
      HomePage()
    }
    .width('100%')
    .height('100%')
  }
}
