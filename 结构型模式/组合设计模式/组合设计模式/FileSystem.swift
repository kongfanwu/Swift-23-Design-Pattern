//
//  FileSystem.swift
//  组合设计模式
//
//  Created by wangyang on 2024/8/12.
//

import Foundation
//当然，下面是一个使用Swift编写的组合设计模式（Composite Pattern）的简单示例。在这个例子中，我们将创建一个简单的文件系统结构，其中包含文件和文件夹。文件夹可以包含其他文件夹或文件，而文件则不包含任何子项。
//首先，我们定义一个FileSystemItem协议，它将作为所有文件和文件夹的基类接口。然后，我们创建File类（叶子节点）和Folder类（容器节点），它们都遵循FileSystemItem协议。
// FileSystemItem 协议定义了文件系统中所有项目的共同行为
protocol FileSystemItem {
    var name: String { get }
    func printStructure(indent: String)
}

// 解决这个问题的方法是，你需要在协议定义中不使用默认参数，而是在协议扩展中提供一个默认实现。这样，遵循协议的类型可以选择使用这个默认实现，也可以在扩展中提供自己的实现。
extension FileSystemItem {
    func printStructure(indent: String = "") {
    }
}
  
// File 类代表文件系统中的文件（叶子节点）
class File: FileSystemItem {
    var name: String
      
    init(name: String) {
        self.name = name
    }
      
    func printStructure(indent: String = "") {
        print(indent + "- \(name)")
    }
}
  
// Folder 类代表文件系统中的文件夹（容器节点），它可以包含其他 FileSystemItem
class Folder: FileSystemItem {
    var name: String
    var items: [FileSystemItem] = []
      
    init(name: String) {
        self.name = name
    }
      
    // 添加项目到文件夹
    func addItem(_ item: FileSystemItem) {
        items.append(item)
    }
      
    // 打印文件夹及其所有子项的结构
    func printStructure(indent: String = "") {
        print(indent + "+ \(name)")
        for item in items {
            item.printStructure(indent: indent + "  ")
        }
    }
}
  



//在这个例子中，FileSystemItem协议定义了一个name属性和一个printStructure方法，用于打印文件系统的结构。File类是一个简单的叶子节点，实现了FileSystemItem协议，并提供了printStructure方法的具体实现。Folder类是一个容器节点，它同样实现了FileSystemItem协议，并添加了items数组来存储其子项。Folder类还重写了printStructure方法以递归地打印其所有子项的结构。
//最后，我们使用Folder和File类创建了一个简单的文件系统结构，并调用了printStructure方法来打印其结构。输出显示了文件夹和文件的层次关系。
