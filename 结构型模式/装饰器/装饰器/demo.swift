//
//  demo.swift
//  装饰器
//
//  Created by wangyang on 2024/8/13.
//

import Foundation
//当然，我可以为你展示一个使用Swift实现的修饰设计模式（Decorator Pattern）的简单示例。在这个例子中，我们将创建一个简单的咖啡订单系统，其中可以通过不同的装饰器来增加咖啡的额外功能（比如加奶泡、加糖浆等）。
//首先，我们定义一个Beverage协议，它是所有饮品的基类接口：
protocol Beverage {
    var description: String { get }
    var cost: Double { get }
}
//然后，我们创建一个具体的饮品类Espresso，它实现了Beverage协议：
class Espresso: Beverage {
    var description = "Espresso"
    var cost: Double = 1.99
      
    func getDescription() -> String {
        return description
    }
      
    func getCost() -> Double {
        return cost
    }
}
//接下来，我们定义一个装饰器基类CondimentDecorator，它也实现了Beverage协议，并持有一个Beverage类型的引用，以便能够包装其他饮品：
class CondimentDecorator: Beverage {
    var beverage: Beverage
      
    init(beverage: Beverage) {
        self.beverage = beverage
    }
      
    var description: String {
        return beverage.description
    }
      
    var cost: Double {
        return beverage.cost
    }
    
    func getDescription() -> String {
        return self.description
    }
    
    func getCost() -> Double {
        return self.cost
    }
}
//现在，我们可以创建具体的装饰器类了，比如Milk（加奶泡）：
class Milk: CondimentDecorator {
    override init(beverage: Beverage) {
        super.init(beverage: beverage)
    }
    
    override var description: String {
        return beverage.description + ", Milk"
    }
      
    override var cost: Double {
        return super.cost + 0.10
    }
      
    override func getDescription() -> String {
        return self.description
    }
    
    override func getCost() -> Double {
        return self.cost
    }
}
