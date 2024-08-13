//
//  ViewController.swift
//  中介者
//
//  Created by wangyang on 2024/8/9.
/*
 中介者设计模式（Mediator Pattern）是一种行为型设计模式，主要用于减少系统中对象之间的直接依赖和通信的复杂性。它通过引入一个中介者对象来封装对象之间的交互，使得对象之间的交互更加灵活和可扩展。以下是中介者设计模式的详细解释：
 定义与原理
 定义：中介者模式定义了一个中介对象来封装一系列对象之间的交互，使原有对象之间的耦合松散，且可以独立地改变它们之间的交互。
 原理：在中介者模式中，各个对象不再直接相互引用和通信，而是通过中介者来进行间接通信。中介者负责协调各个对象之间的交互，降低了对象之间的耦合性，提高了系统的灵活性和可维护性。
 结构组成
 中介者设计模式通常由以下几个角色组成：
 抽象中介者（Mediator）：定义一个接口，用于规范中介者对象的各个行为，如接收和发送消息等。
 具体中介者（Concrete Mediator）：实现抽象中介者接口，定义一个列表来管理同事对象，并协调各个同事对象之间的交互。
 抽象同事类（Colleague）：保存中介者对象，提供同事对象交互的抽象方法，实现所有相互影响的同事类的公共功能。
 具体同事类（Concrete Colleague）：实现抽象同事类接口，当需要与其他同事对象交互时，通过中介者对象进行。
 优点
 降低复杂度：将一对多转化为一对一，降低了程序的复杂程度。
 解耦：实现了类之间的解耦操作，使得对象之间的依赖关系更加简单清晰。
 提高灵活性和可维护性：由于对象之间的交互都通过中介者进行，因此可以独立地改变交互方式而不需要修改其他对象。
 提高代码的重用性和可扩展性：通过引入中介者，可以将多个对象之间的交互细节封装起来，从而增加代码的复用性和扩展性。
 缺点
 中介者对象可能变得复杂：如果系统中对象之间的交互非常复杂，那么中介者对象可能会变得非常复杂，难以维护。
 增加系统复杂性：在某些情况下，如果中介者数量过多或者中介者之间的交互过于复杂，可能会导致系统整体复杂性增加。
 适用场景
 系统中对象之间存在复杂的引用关系，产生的相互依赖关系结构混乱，难以理解。
 一个对象由于引用了其他的很多对象并且直接和这些对象进行通信，导致难以复用该对象。
 想要通过一个中间类来封装多个类中的行为，而又不想生成太多的子类。
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        test1()
    }

    func test1() {
        let mediator = ChatRoomMediator()
        let user1 = User(name: "Alice")
        let user2 = User(name: "Bob")
          
        mediator.register(user: user1)
        mediator.register(user: user2)
          
        user1.sendMessage(message: "Hello, Bob!")
        // 输出: Bob: Hello, Bob!
          
        user2.sendMessage(message: "Hi, Alice!")
        // 输出: Alice: Hi, Alice!
    }
}

/*
 示例
 以多人聊天室为例，聊天室就是一个典型的中介者模式应用场景。在聊天室中，每个人发言时都需要将消息传达给其他人。如果没有聊天室（中介者），每个人都需要对其他每个人说一遍消息。而有了聊天室作为中介者后，只需要将消息发送给聊天室，由聊天室负责将消息传达给其他人。这样就大大降低了对象之间的耦合度，提高了系统的灵活性和可维护性。
 */
protocol ChatRoomUser {
    var mediator: ChatRoomMediator? { get set }
    func sendMessage(message: String)
    func receiveMessage(message: String, from: String)
    var name: String{ get set }
}
class User: ChatRoomUser {
    var mediator: ChatRoomMediator?
    var name: String
    init(name: String) {
        self.name = name
    }
  
    func sendMessage(message: String) {
        mediator?.sendMessage(user: self, message: message)
    }
  
    func receiveMessage(message: String, from: String) {
        print("\(from): \(message)")
    }
}
class ChatRoomMediator {
    var users: [ChatRoomUser] = []
  
    func register(user: User) {
        users.append(user)
        user.mediator = self
    }
  
    func sendMessage(user: ChatRoomUser, message: String) {
        for otherUser in users where otherUser as? User !== user as? User {
//            if (otherUser as! User === user as! User) {
//                print("不给自己发送消息")
//                continue
//            }
            otherUser.receiveMessage(message: message, from: user.name)
        }
    }
}
