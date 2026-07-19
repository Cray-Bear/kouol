/**
 * Mock 数据
 *
 * 用于开发阶段，后续替换为真实 API 数据
 */

export interface Product {
  id: string
  name: string
  price: number
  image: Resource | string
}

export const products: Product[] = [
  { id: '1', name: 'Nike Air Max', price: 929, image: '' },
  { id: '2', name: 'Galaxy Buds', price: 639, image: '' },
  { id: '3', name: '经典 T 恤', price: 199, image: '' },
  { id: '4', name: '智能手表', price: 1299, image: '' }
]
