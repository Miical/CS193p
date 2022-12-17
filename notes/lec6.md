## Shape

可以创建自己的形状

 ```swift
 func fill<S>(_ whatToFillWith: S) -> some View where S: ShapeStyle
 ```

Shape实现了body，但需要去实现func path

```swift
func path(in rect: CGRect) -> Path {
  return a Path
}
```

Path有绘图功能

 