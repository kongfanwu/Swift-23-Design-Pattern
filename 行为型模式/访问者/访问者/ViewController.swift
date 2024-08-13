//
//  ViewController.swift
//  访问者
//
//  Created by wangyang on 2024/8/12.
/*
 访问者设计模式（Visitor Design Pattern）是一种将数据操作与数据结构分离的设计模式。它允许在不修改数据结构的前提下增加新的操作。这种设计模式特别适用于那些数据结构相对稳定，但其操作算法经常变动的系统。通过使用访问者模式，你可以将针对数据结构中的元素的操作封装在一个独立的访问者类中，而不是将这些操作定义在数据结构的类中。
 访问者设计模式的主要角色
 访问者（Visitor）：定义了一个作用于某对象结构中的各元素的操作。它使得可以在不改变各元素的类的前提下定义作用于这些元素的新操作。
 具体访问者（Concrete Visitor）：实现了每个由访问者接口声明的操作。具体访问者含有相关的逻辑，用于在元素上执行这些操作。
 元素（Element）：定义了一个接受操作（accept）的接口，这个接口以一个访问者为参数。
 具体元素（Concrete Element）：实现了 Element 接口，并存储或表示接受访问者访问的数据。
 对象结构（Object Structure）：能枚举它的元素，可以提供一个高层的接口以允许访问者访问它的元素。可以是一个复合对象或是一个简单的集合。
 访问者设计模式的优点
 增加新的操作很容易：如果需要给数据结构中的元素添加新的操作，只需要增加一个新的访问者类即可，无需修改数据结构的类。
 将有关的行为集中到一个访问者对象中：有利于将相关的操作集中起来，便于维护和管理。
 灵活性：可以很容易地增加新的元素类，只要这些类实现了 Element 接口即可。
 访问者设计模式的缺点
 增加新的元素类变得困难：每增加一个新的元素类，都需要修改所有访问者类的代码，以添加对新元素类的支持。
 破坏封装：访问者需要访问并调用每一个元素对象的内部状态和方法，这可能会破坏元素对象的封装性。
 使用场景
 当一个对象结构包含很多类对象，它们有不同的接口，而你想对这些对象实施一些依赖于其具体类的操作。
 需要对一个对象结构中的对象进行很多不同的并且不相关的操作，而你想避免让这些操作“污染”这些对象的类。
 当对象结构中的对象经常发生变化，但经常需要在这些对象上执行一些相同的操作时。
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 调用演示函数
        demonstrateVisitorPattern()
    }


}
//当然可以，下面是一个更加简单且带有详细注释的Swift示例，展示了访问者设计模式的基本用法。在这个示例中，我们将定义两种类型的元素（ElementA 和 ElementB）和一个访问者（Visitor），用于对这些元素执行不同的操作。

// 访问者协议，定义了访问元素时需要实现的方法
protocol Visitor {
    // 访问ElementA类型元素的方法
    func visit(elementA: ElementA)
    // 访问ElementB类型元素的方法
    func visit(elementB: ElementB)
}
  
// 元素协议，要求实现它的类必须提供一个accept方法，用于接受访问者
protocol Element {
    // 接受访问者，并调用其对应的visit方法
    func accept(visitor: Visitor)
}
  
// ElementA的具体实现
class ElementA: Element {
    var data: String = "这是ElementA的数据"
  
    // 实现accept方法，调用访问者的visit(elementA:)方法
    func accept(visitor: Visitor) {
        visitor.visit(elementA: self)
    }
}
  
// ElementB的具体实现
class ElementB: Element {
    var data: String = "这是ElementB的数据"
  
    // 实现accept方法，调用访问者的visit(elementB:)方法
    func accept(visitor: Visitor) {
        visitor.visit(elementB: self)
    }
}
  
// 具体的访问者实现
class ConcreteVisitor: Visitor {
    // 实现对ElementA的访问
    func visit(elementA: ElementA) {
        print("访问了ElementA，数据为：\(elementA.data)")
    }
  
    // 实现对ElementB的访问
    func visit(elementB: ElementB) {
        print("访问了ElementB，数据为：\(elementB.data)")
    }
}
  
// 演示访问者模式的使用
func demonstrateVisitorPattern() {
    // 创建ElementA和ElementB的实例
    let elementA = ElementA()
    let elementB = ElementB()
  
    // 创建访问者的实例
    let visitor = ConcreteVisitor()
  
    // 使用访问者访问ElementA
    elementA.accept(visitor: visitor)
  
    // 使用访问者访问ElementB
    elementB.accept(visitor: visitor)
    
//    在这个示例中，Element 协议定义了一个 accept 方法，该方法接受一个遵循 Visitor 协议的访问者对象。ElementA 和 ElementB 类实现了 Element 协议，并在它们的 accept 方法中调用了访问者的相应 visit 方法。
//    Visitor 协议定义了两种 visit 方法，分别用于访问 ElementA 和 ElementB 类型的元素。ConcreteVisitor 类实现了 Visitor 协议，并为每种类型的元素提供了具体的访问逻辑。
//    最后，demonstrateVisitorPattern 函数展示了如何使用这些类和协议来演示访问者设计模式。它创建了 ElementA 和 ElementB 的实例，以及一个 ConcreteVisitor 的实例，并使用访问者来访问这两种类型的元素。
}
  

