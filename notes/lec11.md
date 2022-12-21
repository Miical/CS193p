## 错误处理

**不处理错误**

```swift
// try? if err return nil
if let imageData = try? Data(contentsOf: url) { ... }
try? someFunc()

// try! if err, crashes
try! data.write(to: url)

// rethrows
func foo() throws {
  try somethingThatThrows()
}
```

**处理错误**

```swift
do {
  try functionThatThrows()
} catch let err {
  // ...
}
```



## 永久存储

- 在文件系统中(FileManager)
- 在SQL数据库中（CoreData 提供了OOP访问，可以直接调用SQL）
- iCloud
- CloudKit

**文件系统**

只允许在应用程序自己的沙盒中创建

沙盒中的内容

- 应用程序目录
- 文档目录
- 应用程序支持目录
- 缓存目录
- 其他目录

FileManager.default

```swfit
let manager = FileManager.default
let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
```

![image-20221221140609013](lec11.assets/image-20221221140609013.png)

![image-20221221140735808](lec11.assets/image-20221221140735808.png)

Codable	

![image-20221221142709235](lec11.assets/image-20221221142709235.png)

