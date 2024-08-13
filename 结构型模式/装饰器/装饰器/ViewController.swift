//
//  ViewController.swift
//  装饰器
//
//  Created by wangyang on 2024/8/13.
/*
 
 https://github.com/ochococo/Design-Patterns-In-Swift/blob/master/README-CN.md#-修饰decorator
 
 修饰设计模式（Decorator Pattern），又称装饰器模式或包装器模式，是面向对象编程领域中一种用于动态地给一个对象添加一些额外的职责（即功能）的设计模式。它就增加功能来说，相比生成子类更为灵活。就扩展功能而言，装饰模式提供了一种比继承更加灵活的方式来动态地扩展一个类的功能。
 修饰设计模式的特点
 动态扩展：在不改变原类结构和继承关系的情况下，动态地为对象添加功能。
 包装对象：通过创建一个包装对象（装饰器）来包裹真实对象，增加额外功能。
 接口一致性：装饰器与真实对象有相同的接口，确保客户端能以相同的方式与两者交互。
 开闭原则：对扩展开放，对修改关闭。新的功能通过添加装饰器实现，而不是修改原类。
 灵活组合：允许通过组合多个装饰器来创建功能更为丰富的对象。
 修饰设计模式的角色
 抽象组件（Component）：定义一个接口，用于规范准备接收附加责任的对象（即被装饰对象）。
 具体组件（ConcreteComponent）：实现抽象组件接口，是装饰器要装饰的真实对象。
 装饰器（Decorator）：持有一个抽象组件的引用，并继承抽象组件的接口。它既可以使用所持有的引用调用被装饰的组件的方法，也可以增加新的功能。
 具体装饰器（ConcreteDecorator）：实现装饰器接口并给具体组件添加职责。它通常包含对具体组件的引用，以及一个或多个用于增加功能的额外方法。
 修饰设计模式的应用场景
 当需要为单个对象提供多种不同的行为或者表现形式时。
 需要向一个已经存在的类中添加功能，但又不希望修改该类的源代码或继承其子类时。
 需要组合多个对象来创建一个具有更多功能的对象时，装饰模式是一个很好的选择。
 示例
 在Java中，Java I/O Streams的实现就是一个典型的装饰模式示例。例如，可以通过不同的装饰器（如BufferedInputStream、FileInputStream等）来包装一个InputStream对象，以添加缓冲、文件读取等功能。
 总结
 修饰设计模式是一种强大的设计模式，它提供了一种灵活的方式来动态地扩展对象的功能，同时保持对象的原始类不变。通过使用修饰模式，可以在不修改现有代码的基础上，增加新的功能，从而提高代码的复用性和可维护性。
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        test()
    }

    func test() {
        let espresso = Espresso()
        let espressoWithMilk = Milk(beverage: espresso)
          
        print(espressoWithMilk.getDescription()) // 输出: Espresso, Milk
        print(espressoWithMilk.getCost())        // 输出: 2.09
    }

}

