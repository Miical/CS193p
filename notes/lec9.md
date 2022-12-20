## 可识别对象合集

```swift
extension Collection where Element: Identifiable {
  func index(matching element: Element) -> Self.Index? {
    firstIndex(where: { $0.id == element.id })
  }
}

extension RangeReplaceableCollection where Element: Indetifiable {
  mutating func remove(_ element: Element) {
    if let index = index(matching: element) {
      if let index = index(matching: element) {
        remove(at: index)
      }
    }
  }
}


```

## Color, UIColor, CGColor

- Color 颜色说明、ShapeStyle、视图
- 用于颜色操作, 转换Color(uiColor: )
- 绘图系统中基本颜色表示



## Image 和 UIImage

UIImage实际存储了图像

## Drag and Drop

NSItemProvider

## 多线程

讲闭包放在不同的队列中执行

队列有优先级，最重要的队列是主队列  

API: GCD(Grand Central Dispatch)

- 创建队列
  - ![image-20221220171421222](lec9.assets/image-20221220171421222.png)
- 将闭包放入队列
  - ![image-20221220171900474](lec9.assets/image-20221220171900474.png)
- 嵌套
  - ![image-20221220172218349](lec9.assets/image-20221220172218349.png)

