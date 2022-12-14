# 使用SwiftUI开始

 

**目录结构**

- `Assets.xcassets` 图像、声音和视频
- `Info.plist` 应用程序设置。可以去项目设置中编辑
- swift文件 
  - `MemorizeApp.swift` 主函数在此文件中。有`@main`标识
  - `ContentView.swift` 实现本程序的界面
    - 底部的有一段glue code用于与预览器连接
    - `import SwiftUI` 提供UI
    - `struct`不仅可以内置变量、还可以具有函数。（面向对象）`:View` 表示这个结构的行为是一个View，可以使用View的所有功能

**什么是View**

View是屏幕上的一个矩形区域，可以进行输入输入。

实现View必须要有这个变量

```swift
var body: some View {}
// 使用var声明变量
// body - 变量名称
// :some View - 变量类型 eg:
//		var i: Int
//		var s: Str
// 多个view将被组合成一个View（组合
```

swift是函数式编程语言，函数无处不在

```swift
var body: some View {
  Text("Hello world")
}
// `{ }`是一个函数，有返回值返回值就是一个Text
// 等价于
{
  return Text("Hello world")
}
```

`some View`给编译器的提示，实际会是某个View例如Text

```swift
Text("Hello, world!").padding(.all)
// padding又返回了一个View行为的东西
```

带标签的函数：

```swift
RoundedRectangle(cornerRadius: 25.0)
```



**ZStack**

组合器，允许列出多个视图打包

```swift
return ZStack(content: {
  RoundedRectangle(cornerRadius: 25.0)
  Text("Hello, world!").padding(.all)
})
```

在ZStack上应用的Modifier会传递给内部的所有东西。内部的优先级更高



如果传递一个函数，如果是最后一个参数之一，就可以直接省略标签并在括号中取出。

```swift
ZStack(alignment: .center, content: {})
ZStack(alignment: .center) {}
```

