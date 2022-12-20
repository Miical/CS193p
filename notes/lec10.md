## 手势

让视图响应手势；

```swft
myView.gesture(theGesture).onEnded {
	
}
```

离散手势、非离散手势



**处理非离散手势**

```swift
@GesureState var myGestrueState: MyGestureStateType = <starting value>
```

手势结束后，会回到初始值

![image-20221220195325040](lec10.assets/image-20221220195325040.png)