/**
 * 主页 - R-004 P0 主页开发
 *
 * 页面结构：
 * - Header（问候 + 头像）
 * - SearchBar（搜索栏）
 * - Banner（轮播）
 * - Categories（商品分类）
 * - Products（精选好物 Grid）
 * - BottomNavigation（底部导航）
 */
import { BottomNavigation } from '../components/BottomNavigation'
import { Header } from '../components/Header'
import { SearchBar } from '../components/SearchBar'
import { Banner } from '../components/Banner'
import { Categories } from '../components/Categories'
import { Products } from '../components/Products'

@Entry
@Component
export struct HomePage {
  @State currentTab: number = 0

  build() {
    Column() {
      // 主内容区（可滚动）
      Scroll() {
        Column() {
          // T-003 Header + 搜索栏
          Header()

          SearchBar()
            .margin({ top: 12 })

          // T-004 Banner 轮播
          Banner()
            .margin({ top: 16 })

          // T-005 商品分类
          Categories()
            .margin({ top: 24 })

          // T-006 精选好物 Grid
          Products()
            .margin({ top: 24 })
        }
        .width('100%')
        .padding({ left: 20, right: 20 })
      }
      .layoutWeight(1)
      .backgroundColor('#F9FAFB')

      // T-002 底部导航
      BottomNavigation({
        currentIndex: this.currentTab,
        onTabChange: (index: number) => {
          this.currentTab = index
        }
      })
    }
    .width('100%')
    .height('100%')
  }
}
