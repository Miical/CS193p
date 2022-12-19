```swift
var shuffle: some view {
  Button("Shuffle") {
    withAnimation {
      game.shuffle()bb 
    }
	}
}
```

**翻转牌**

```swift
rotation3DEffect(Angle.degrees(isFaceUP ? 0 : 180), axis: (0, 1, 0))
```

```swift
struct Cardify: AnimatableModifier {
  var animatableData: Double {
    
  }
}
```

**卡片出现/消失**

```swift
CardView().transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity))
```

 **使容器先出现**

使用@State记录是否出现

**发牌**

```swift
.matchedGeometryEffect(id: card.id, in: dealingNamespace )
```

