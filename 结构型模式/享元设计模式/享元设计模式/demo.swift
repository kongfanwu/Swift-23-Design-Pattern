//
//  demo.swift
//  享元设计模式
//
//  Created by wangyang on 2024/8/13.
//

import Foundation
//在Swift中，享元设计模式（Flyweight Pattern）的实现会涉及到创建共享的对象（称为“享元”），这些对象通常包含不会改变的内部状态（内蕴状态），并可能依赖于外部状态。以下是一个简单的Swift示例，展示了如何实现享元模式。
//假设我们有一个简单的场景，我们需要表示多种颜色，并且这些颜色对象将被频繁创建和销毁，但它们的内部状态（即颜色代码）是有限的。我们可以通过使用享元模式来优化这种情况。
//定义享元接口
//在Swift中，我们可以使用协议（Protocol）来定义享元接口。但是，由于Swift的类型系统允许我们直接通过类来实现共享逻辑，所以有时候我们不需要显式定义一个接口。不过，为了示例的清晰性，我们可以定义一个协议。
protocol ColorFlyweight {
    var colorCode: String { get }
    func display(position: String)
}
//实现具体享元
//然后，我们创建一个具体的享元类，它实现了ColorFlyweight协议，并存储了颜色代码作为内蕴状态。
class ConcreteColor: ColorFlyweight {
    let colorCode: String
  
    init(colorCode: String) {
        self.colorCode = colorCode
    }
  
    func display(position: String) {
        print("Displaying color \(colorCode) at position \(position)")
    }
}
//享元工厂
//接下来，我们创建一个享元工厂，用于管理和存储已经创建的享元对象，以便重用它们。
class ColorFactory {
    private var flyweights: [String: ColorFlyweight] = [:]
  
    func getColor(colorCode: String) -> ColorFlyweight {
        if let flyweight = flyweights[colorCode] {
            return flyweight
        } else {
            let newFlyweight = ConcreteColor(colorCode: colorCode)
            flyweights[colorCode] = newFlyweight
            return newFlyweight
        }
    }
}
