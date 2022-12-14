# 学习更多的SwiftUI



## 放置多个方块

使用HStack进行堆叠

```swift
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 3)
                Text("Hello, world!")
            }
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 3)
                Text("Hello, world!")
            }
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 3)
                Text("Hello, world!")
            }
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 3)
                Text("Hello, world!")
            }
        }
        .padding(.horizontal)
        .foregroundColor(.red)
    }
```

但这种方式需要大量的重复代码

需要创建一个新的View， CardView

```swift
struct CardView: view {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 3)
            Text("Hello, world!")
        }
    }
}
```

代码可以修改为

```swift
struct ContentView: View {
    var body: some View {
        HStack {
            CardView()
            CardView()
            CardView()
            CardView()
        }
        .padding(.horizontal)
        .foregroundColor(.red)
    }
}
```

如果需要修改预览图，在底部的预览图接口中可以进行修改

```swift
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
```

## 解决填充问题

深色模式下，卡片内部透明导致不美观，因此需要对卡片内部进行填充。

无法同时使用`.stork` 和`.fill`，因此需要重新创建一个填充类型的`RoundedRectangle`

```swift
struct CardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill()
                .foregroundColor(.white)
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 3)
            Text("🚗")
                .font(.largeTitle)
        }
    }
}
```

## 正反面翻转

使用if-else语句

```swift
struct CardView: View {
    var isFaceUp: Bool = true
    // var isFaceUp: Bool { return true }
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 20)
                    .fill()
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 3)
                Text("🚗")
                    .font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 20)
                    .fill()
            }
        }
    }
}
```

创建时可以指定值

```swift
CardView(isFaceUp: true)
```

使用局部变量

常量时使用let

可以不用写类型，swift会自动推测

```swift
struct CardView: View {
    var isFaceUp: Bool = true
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: 3)
                Text("🚗").font(.largeTitle)
            } else {
                shape.fill()
            }
        }
    }
}
```



## 响应触控事件

使用`.onTapGesture`

```swift
ZStack{}.onTapGesture {
	 isFaceUP = !isFaceUP
}
```

上述操作时不可行的，因为视图被创建后便不可被更改

把变量改为“指针“类型

```swift
@State var isFaceUp: Bool = true
```

但以后很少使用！

只用于临时的状态



## 指定不同的图标

（按住option并点击可以查看文档）

设置一个变量来定义内容

```swift
var content: String
```

创建时使用一个数组

```swift
// var emojis: Array<String> = ["", "", "", ""]
// var emojis: [String] = ["", "", "", ""]
var emojis = ["", "", "", ""]
```

(swift是强类型)

使用`ForEach`创建

```swift
ForEach(emojis, content: { emoji in
  CardView(content: emoji)
})
```

！为函数创建参数

```swift
{ emoji in CardView(content: emoji)}
```

还是无法运行，因为缺少标识符，字符串类型没有唯一的id，只能通过把字符串作为id，但这需要保证互不相同

```swift
ForEach(emojis, id: \.self) { emoji in
  CardView(content: emoji)
})
```



## 	添加或减少卡片

数组切片 

```swift
emojis[0..<6] // 不包含6
emojis[0...6] // 包含6
```

设置卡片数量的变量

```swift
@State var emojiCount = 6
```

### 添加按钮

使用VStack竖向划分

```swift
VStack {
  HStack {
    
  }
   HStack{
    Button(action: {
      emojiCount += 1
    }, label: {
      VStack {
        Text("Add")
        Text("Card")
      }
    })
    Spacer()
    Button(action: {
      emojiCount -= 1
    }, label: {
      VStack {
        Text("Remove")
        Text("Card")
      }
    })
   }
}
```

创建变量以简化代码

```swift
HStack{
  remove
  Spacer()
  add
}
```

添加图像

```swift
Image(systemName: "plus.circle")
```


## 网格排列

```swift
LazyVGrid(columns: [GridItem(.fixed(200)), GridItem(), GridItem(), GridItem()])
```

设置卡片比例

```swift
CardView().aspectRatio(2/3, contentMode: .fit)
```

滚动视图`ScrollView`

```swift
ScrollView {
  LazyVGird()
}
```

自适应一行内数量

```]]
[GridItem(.adaptive(minimum: 65))]
```

