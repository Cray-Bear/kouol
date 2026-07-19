/**
 * Banner 轮播组件
 */

interface BannerData {
  id: string
  title: string
  subtitle: string
  bgColor: string
}

@Component
export struct Banner {
  @State currentIndex: number = 0
  private banners: BannerData[] = [
    { id: '1', title: '夏日特惠', subtitle: '精选商品低至五折', bgColor: '#4F46E5' },
    { id: '2', title: '新品上市', subtitle: '最新数码好物', bgColor: '#F97316' },
    { id: '3', title: '品牌日', subtitle: '大牌直降', bgColor: '#10B981' }
  ]

  build() {
    Stack() {
      Swiper() {
        ForEach(this.banners, (banner: BannerData, index: number) => {
          Stack() {
            Stack()
              .width('100%')
              .height('100%')
              .backgroundColor(banner.bgColor)
              .borderRadius(16)

            Column() {
              Text(banner.title)
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
                .margin({ top: 32 })

              Text(banner.subtitle)
                .fontSize(15)
                .fontColor(Color.White)
                .margin({ top: 8 })

              Button('立即抢购')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.White)
                .backgroundColor('#F97316')
                .borderRadius(19)
                .padding({ left: 20, right: 20, top: 8, bottom: 8 })
                .margin({ top: 20 })
            }
            .alignItems(HorizontalAlign.Start)
            .padding({ left: 24 })
          }
        })
      }
      .width('100%')
      .height(170)
      .borderRadius(16)
      .autoPlay(true)
      .interval(5000)
      .indicator(false)
      .onChange((index: number) => {
        this.currentIndex = index
      })

      Row() {
        ForEach(this.banners, (_: BannerData, index: number) => {
          Stack()
            .width(this.currentIndex === index ? 8 : 6)
            .height(this.currentIndex === index ? 8 : 6)
            .backgroundColor(this.currentIndex === index ? Color.White : 'rgba(255,255,255,0.5)')
            .borderRadius(this.currentIndex === index ? 4 : 3)
            .margin({ left: index > 0 ? 6 : 0 })
        })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)
      .alignItems(VerticalAlign.Bottom)
      .padding({ bottom: 16 })
    }
    .width('100%')
    .height(170)
  }
}
