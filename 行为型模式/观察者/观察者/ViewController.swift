//
//  ViewController.swift
//  观察者
//
//  Created by wangyang on 2024/8/9.
/*
 观察者设计模式（Observer Design Pattern）是一种行为型设计模式，它定义了一种对象间的一对多的依赖关系，使得当一个对象（即主题或可观察者）的状态发生改变时，所有依赖于它的对象（即观察者）都能够得到通知并自动更新。这种设计模式广泛应用于软件开发中，以提高系统的可维护性、可扩展性和灵活性。
 主要特点
 主题（Subject）和观察者（Observer）：
 主题：是被观察的对象，它维护了一组观察者，并提供了添加、删除和通知观察者的方法。主题的状态变化时，会通知所有注册的观察者。
 观察者：是依赖于主题的对象，它实现了一个更新接口，当收到主题的通知时，会调用该接口进行更新操作。
 松散耦合：
 观察者模式实现了主题和观察者之间的松散耦合，即它们之间的关系不是静态的硬编码关系，而是动态的。主题无需知道观察者的具体类，只需知道它们实现了共同的接口。
 一对多通信：
 主题状态发生改变时，会向所有注册的观察者发送通知，实现了一对多的通信机制。
 动态添加和删除：
 在运行时，可以动态地添加新的观察者或删除不再关心主题状态的观察者，而不需要修改主题的代码。
 遵循开闭原则：
 观察者模式遵循开闭原则，即对扩展开放，对修改关闭。通过添加新的观察者，而不是修改现有的代码，可以轻松地扩展系统功能。
 典型角色
 主题（Subject）：也称为被观察者或可观察者，具有状态，并维护一个观察者列表。主题提供注册、移除和通知观察者的方法。
 观察者（Observer）：是一个抽象类或接口，定义了一个更新方法，用于接收主题的通知。
 具体主题（Concrete Subject）：是主题的具体实现类，维护观察者列表，并在状态发生改变时通知观察者。
 具体观察者（Concrete Observer）：是观察者的具体实现类，实现了更新方法，定义了收到主题通知时需要执行的具体操作。
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 4. 使用示例
        let subject = Subject()
        let observerA = ConcreteObserverA()
        let observerB = ConcreteObserverB()
          
        subject.registerObserver(observer: observerA)
        subject.registerObserver(observer: observerB)
          
        subject.setState(newState: "New State")
        // 输出:
        // Observer A received state: New State
        // Observer B received state: New State
          
        subject.removeObserver(observer: observerA)
        subject.setState(newState: "Another New State")
        // 输出:
        // Observer B received state: Another New State
    }


}

// 1. 定义观察者协议
protocol Observer: Equatable {
    func update(state: String)
}

class BaseObserver: Observer {
    static func == (lhs: BaseObserver, rhs: BaseObserver) -> Bool {
        true
    }
    
    func update(state: String) {
        
    }
}
  
// 2. 定义主题类
class Subject {
    private var observers = [BaseObserver]()
    private var state: String = ""
  
    // 注册观察者
    func registerObserver(observer: BaseObserver) {
        observers.append(observer)
    }
  
    // 注销观察者
    func removeObserver(observer: BaseObserver) {
        observers = observers.filter({
            $0 !== observer
        })
    }
  
    // 通知所有观察者
    func notifyObservers() {
        for observer in observers {
            observer.update(state: state)
        }
    }
  
    // 设置状态并通知所有观察者
    func setState(newState: String) {
        state = newState
        notifyObservers()
    }
}
  
// 3. 实现具体的观察者
class ConcreteObserverA: BaseObserver {
    static func == (lhs: ConcreteObserverA, rhs: ConcreteObserverA) -> Bool {
        return true
    }
    
    override func update(state: String) {
        print("Observer A received state: \(state)")
    }
}

class ConcreteObserverB: BaseObserver {
    static func == (lhs: ConcreteObserverB, rhs: ConcreteObserverB) -> Bool {
        return true
    }
    
    override func update(state: String) {
        print("Observer B received state: \(state)")
    }
}
  

