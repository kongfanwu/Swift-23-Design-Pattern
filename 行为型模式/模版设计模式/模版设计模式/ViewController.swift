//
//  ViewController.swift
//  模版设计模式
//
//  Created by wangyang on 2024/8/12.
/*
 模板方法设计模式（Template Method Pattern）是一种行为型设计模式，它定义了一个操作（模板方法）的算法骨架，而将一些步骤延迟到子类中实现。这样可以在不改变算法结构的情况下，重新定义算法的某些特定步骤。以下是模板方法设计模式的详细解释：
 定义
 模板方法模式在超类中定义了一个算法的框架，允许子类在不修改结构的情况下重写算法的特定步骤。它将算法的固定部分与可变部分分离，使得可变部分可以在子类中实现，而固定部分则在超类中实现。
 组成
 模板方法模式主要由以下几个部分组成：
 抽象类（Abstract Class）：
 定义了一个或多个抽象方法，这些方法在子类中被实现。
 定义了一个模板方法，该方法中包含了算法的基本框架，并调用了在子类中被实现的抽象方法。
 还可以包含一些基本方法（即已经在抽象类中实现的方法），这些方法可以直接在模板方法中被调用。
 具体子类（Concrete Classes）：
 继承自抽象类。
 实现抽象类中定义的抽象方法，即算法的特定步骤。
 特性
 封装性：将算法的不变部分封装在抽象类中，将可变部分延迟到子类中实现，从而提高了代码的封装性。
 扩展性：通过增加新的子类来实现新的算法步骤，可以轻松地对算法进行扩展，而不需要修改原有代码。
 复用性：抽象类中的基本方法可以被所有子类共享，避免了代码的重复。
 优缺点
 优点
 封装不变部分，扩展可变部分：使得子类可以在不改变算法结构的情况下，重新定义算法的某些特定步骤。
 提高代码复用性：通过继承机制，子类可以复用抽象类中的代码。
 提高代码可维护性：由于算法结构在抽象类中定义，因此当算法需要修改时，只需要修改抽象类中的代码，而不需要修改各个子类的代码。
 缺点
 类数量增加：由于每个算法步骤都需要一个子类来实现，因此在算法步骤较多时，类的数量可能会急剧增加。
 系统复杂性提高：随着类的数量的增加，系统的复杂性也会相应提高。
 灵活性降低：由于算法结构在抽象类中定义，因此当需要修改算法结构时，可能需要修改抽象类中的代码，这可能会影响到所有子类。
 应用场景
 模板方法模式适用于以下场景：
 多个子类共有的方法：如果多个子类有共同的算法逻辑，但某些步骤需要根据子类的不同而有所变化，可以使用模板方法模式。
 复杂的算法：如果算法中某些步骤的实现比较复杂，或者这些步骤的实现可能会根据需求的不同而有所变化，可以将这些步骤定义为抽象方法，由子类来实现。
 框架设计：在框架设计中，可以使用模板方法模式来定义一些通用的算法框架，由框架的使用者（即子类）来实现具体的算法步骤。
 示例
 以发送短信为例，可以定义一个发送短信的模板方法，该方法中包含了发送短信的基本流程（如检查用户是否已发送过短信、生成验证码、发送短信到用户手机、保存验证码等），而将发送短信到用户手机的具体实现（即选择哪个短信服务商来发送短信）延迟到子类中实现。这样，当需要增加新的短信服务商时，只需要新增一个子类来实现发送短信的具体步骤即可，而不需要修改原有的代码。
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 使用示例
        let latteMaker = LatteMaker()
        latteMaker.prepareCoffee()
          
        let americanoMaker = AmericanoMaker()
        americanoMaker.prepareCoffee()
/*
 在这个示例中，CoffeeMaker类定义了一个制作咖啡的模板方法prepareCoffee，它按照固定的顺序调用了几个抽象方法。LatteMaker和AmericanoMaker类分别实现了这些抽象方法，以提供具体的冲泡逻辑。这样，当调用prepareCoffee方法时，就会按照模板方法定义的流程来制作不同类型的咖啡。
 请注意，虽然在这个示例中我使用了fatalError来模拟抽象方法，但在实际项目中，你可能更倾向于使用协议和类的组合来更明确地表达哪些方法是必须被实现的。然而，对于简单的示例或学习目的，这种方法是足够的。
 */
    }


}
/*
 在Swift中，实现模板方法设计模式的一个简单示例可以涉及定义一个抽象基类（或协议，但在这个场景下使用类更直观），该类中包含一个模板方法，该方法定义了一个算法的框架，并调用了在子类中需要被实现的抽象方法。以下是一个简单的示例，模拟了一个咖啡制作的过程，其中不同的咖啡类型（如拿铁、美式）有不同的冲泡方式，但基本的制作流程（如准备杯子、冲泡、加奶泡等）是相似的。
 首先，我们定义一个抽象基类CoffeeMaker，它包含了一个模板方法prepareCoffee，以及几个抽象方法（在这个例子中，我们使用Swift的fatalError来模拟抽象方法，因为Swift没有内置的抽象类概念，但你可以通过协议加类的方式来实现类似的效果，或者简单地使用assert(false)来标记未实现的方法）：
 */
class CoffeeMaker {
    // 模板方法，定义了制作咖啡的流程
    func prepareCoffee() {
        prepareCup()
        brew()
        if needsMilkFoam() {
            addMilkFoam()
        }
        serve()
    }
  
    // 抽象方法，准备杯子
    func prepareCup() {
        fatalError("prepareCup must be implemented by subclass")
    }
  
    // 抽象方法，冲泡咖啡
    func brew() {
        fatalError("brew must be implemented by subclass")
    }
  
    // 抽象方法，判断是否需要加奶泡
    func needsMilkFoam() -> Bool {
        fatalError("needsMilkFoam must be implemented by subclass")
    }
  
    // 抽象方法，加奶泡
    func addMilkFoam() {
        fatalError("addMilkFoam must be implemented by subclass")
    }
  
    // 抽象方法，服务咖啡
    func serve() {
        print("Serving coffee...")
    }
}
  
// 拿铁咖啡制作器
class LatteMaker: CoffeeMaker {
    override func prepareCup() {
        print("Preparing a large cup...")
    }
  
    override func brew() {
        print("Brewing espresso...")
    }
  
    override func needsMilkFoam() -> Bool {
        return true
    }
  
    override func addMilkFoam() {
        print("Adding milk foam...")
    }
}
  
// 美式咖啡制作器
class AmericanoMaker: CoffeeMaker {
    override func prepareCup() {
        print("Preparing a medium cup...")
    }
  
    override func brew() {
        print("Brewing drip coffee...")
    }
  
    override func needsMilkFoam() -> Bool {
        return false
    }
  
    // 对于美式咖啡，我们不需要重写addMilkFoam，因为默认实现（fatalError）在这里是合适的
}
  
