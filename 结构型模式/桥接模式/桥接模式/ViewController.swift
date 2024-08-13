//
//  ViewController.swift
//  桥接模式
//
//  Created by wangyang on 2024/8/12.
/*
 桥接设计模式（Bridge Pattern），也称为桥梁模式、接口模式或者柄体模式，是GoF（四人帮）提出的23种设计模式中的一种结构型设计模式。其核心思想是将类的抽象部分与它的实现部分分离，使它们可以独立地变化。这种分离方式提高了系统的灵活性和可扩展性，使得在不修改原有代码的情况下，可以通过增加新的实现类来扩展系统的功能。
 桥接模式的定义与用途
 定义：桥接模式用于把抽象化与实现化解耦，使得二者可以独立变化。它通过提供抽象化和实现化之间的桥接结构，来实现二者的解耦。
 用途：在软件开发中，经常会遇到抽象和实现紧密耦合的情况，这限制了系统的灵活性和可扩展性。桥接模式通过将它们分离，提高了系统的灵活性。
 桥接模式的角色组成
 桥接模式主要包含以下几种角色：
 抽象化（Abstraction）角色：定义了一个抽象类，它持有一个对实现化（Implementor）角色的引用。抽象类中的方法需要实现化角色来实现。
 扩展抽象化（Refined Abstraction）角色：是抽象化角色的子类，它实现了抽象类中的部分或全部方法，并通过组合关系调用实现化角色中的方法。
 实现化（Implementor）角色：定义了一个实现化角色的接口，这个接口为抽象化角色提供一个公共的接口，以便抽象化角色可以访问实现化角色的方法。
 具体实现化（Concrete Implementor）角色：实现了实现化角色接口的具体类，提供了实现化接口的具体实现。
 桥接模式的优点
 分离抽象部分及具体实现部分：提高了系统的扩展性。
 符合开闭原则：可以在不修改原有代码的情况下，通过增加新的实现类来扩展系统的功能。
 符合合成复用原则：通过组合关系而不是继承关系来实现，减少了类之间的耦合。
 桥接模式的应用场景
 当一个类存在两个独立变化的维度，且这两个维度都需要进行扩展时。
 当一个系统不希望使用继承或因为多层次继承导致系统类的个数急剧增加时。
 当一个系统需要在构件的抽象化角色和具体化角色之间增加更多的灵活性时。
 示例
 假设我们有一个图形接口，它有不同的实现方式（如圆形和矩形），并且每种图形都有多种绘制方式（如实线和虚线）。我们可以使用桥接模式来设计这个系统，将图形的类型（抽象化角色）和绘制方式（实现化角色）分离，使得它们可以独立变化。
 结论
 桥接模式是一种非常有用的设计模式，它通过将抽象部分与实现部分分离，提高了系统的灵活性和可扩展性。在软件设计中，当遇到需要从两个或多个维度进行扩展的情况时，可以考虑使用桥接模式来解决问题。
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 使用示例
        let textView = TableViewMessageView()
        let displayer = MessageDisplayer(messageView: textView)
        displayer.showMessage(message: TextMessage(content: "Hello, World!"))
          
        let collectionView = CollectionViewMessageView()
        displayer.messageView = collectionView
        displayer.showMessage(message: ImageMessage(content: "http://example.com/image.jpg"))

        /*
         在这个例子中，MessageDisplayer是桥接结构的持有者，它接收一个MessageView类型的引用，这个引用可以指向任何遵循了MessageView协议的具体实现。这样，MessageDisplayer就能够与不同类型的消息视图解耦，并且可以在不修改MessageDisplayer代码的情况下，通过传递不同的视图实例来展示不同类型的消息。
         这就是桥接设计模式在Swift中的一个简单示例。希望这能帮助你理解桥接模式的工作原理和如何在Swift中实现它。
         */
    }


}

/*
 在Swift中，桥接设计模式的一个简单示例可以围绕不同的数据表示（如文本和图像）以及它们的不同展示方式（如列表和网格）来构建。不过，为了简化，我们可以创建一个更具体的例子，比如一个“消息”系统，其中消息可以有不同的类型（文本、图片等），并且这些消息可以通过不同的视图（如表格视图和集合视图）展示。
 在这个例子中，我们将定义抽象的消息（Message）和消息的具体实现（如TextMessage和ImageMessage），以及一个展示这些消息的抽象视图（MessageView）和具体视图（如TableViewMessageView和CollectionViewMessageView）。
 首先，我们定义消息接口和具体消息类：
 */
// 消息接口
protocol Message {
    var content: String { get }
}
  
// 文本消息
class TextMessage: Message {
    var content: String
    init(content: String) {
        self.content = content
    }
}
  
// 图片消息（假设我们有一个URL来代表图片）
class ImageMessage: Message {
    var content: String // 这里用URL的字符串表示
    init(content: String) {
        self.content = content
    }
}
//接下来，我们定义视图接口和具体视图类。这些视图类将负责展示消息：
// 消息视图接口
protocol MessageView {
    func display(message: Message)
}
  
// 表格视图消息展示
class TableViewMessageView: MessageView {
    func display(message: Message) {
        print("在表格视图中展示消息: \(message.content)")
    }
}
  
// 集合视图消息展示
class CollectionViewMessageView: MessageView {
    func display(message: Message) {
        print("在集合视图中展示消息: \(message.content)")
    }
}
// 现在，我们可以创建一个使用这些类的场景，比如一个消息展示器，它可以接受不同类型的消息和不同的视图来展示这些消息：
class MessageDisplayer {
    var messageView: MessageView
  
    init(messageView: MessageView) {
        self.messageView = messageView
    }
  
    func showMessage(message: Message) {
        messageView.display(message: message)
    }
}
  
