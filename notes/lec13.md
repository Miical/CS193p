# Publisher

```swift
Publisher<Output, Failure> 
```

订阅一个Publisher

```swift
cancellable = 	myPublisher.sink(
    receiveCompletion: { result in ... }.
  receiveValue: { thingThePublisherPublishes in ... }
)
```

View也可以订阅

```swift
.onReceive(publisher) {}
```



 ## 持久化

Cloud Kit

 Core Data