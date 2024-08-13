//
//  ViewController.swift
//  命令模式
//
//  Created by wangyang on 2024/8/9.
/*
 命令模式（Command Pattern）是一种在面向对象程序设计中常用的行为型设计模式。它的核心思想在于将请求封装成一个对象，从而使得我们可以用不同的请求对客户端进行参数化、排队或记录请求日志，以及支持可撤销的操作。以下是命令模式的详细解析：
 定义
 命令模式将“行为请求者”与“行为实现者”解耦，通过引入一个命令对象来封装请求的行为，使得请求发送者和接收者之间消除直接的耦合关系。这种设计模式允许请求的一方（发送者）不必知道接收请求的一方的接口，更不必知道请求是怎么被接收，以及操作是否被执行、何时被执行，以及是怎么被执行的。
 结构
 命令模式主要包含以下几个角色：
 命令角色（Command）：这是一个抽象类或接口，它定义了执行命令的方法，通常包含execute()方法，但不实现具体的命令行为。
 具体命令角色（Concrete Command）：实现了命令接口，持有接收者的引用，并在执行方法中调用接收者的方法来执行具体的命令行为。
 接收者角色（Receiver）：真正执行命令的对象。任何类都可能成为一个接收者，只要它能够实现命令要求实现的相应功能。
 调用者角色（Invoker）：要求命令执行请求的一方。它持有命令对象的引用，可以持有很多的命令对象，并可以触发命令对象的执行。
 优点
 降低对象之间的耦合度：通过引入命令对象，使得发送者和接收者之间不必直接耦合，而是通过命令对象进行交互。
 提高系统的可扩展性：新的命令可以很容易地加入到系统中，而不会影响其他已有的命令类。
 支持撤销和重做：通过命令对象，可以方便地实现撤销和重做操作。
 支持请求排队和日志记录：命令对象可以被存储和传递，从而支持请求排队和日志记录功能。
 缺点
 类数量可能过多：如果系统中存在大量的命令，那么就需要定义大量的具体命令类，这可能会导致类的数量膨胀，增加系统的复杂性。
 应用场景
 宏命令：当需要将多个简单命令组合成一个复合命令时，可以使用命令模式。
 远程控制和自动化：在远程控制系统中，可以使用命令模式来发送远程指令给接收设备。
 GUI 应用程序：在图形用户界面中，命令模式可以用来处理用户的输入事件，例如按钮点击、菜单选项选择等。
 日志记录和历史追踪：命令模式可以用来记录操作的历史，这对于审计和调试非常有用。
 综上所述，命令模式是一种强大的设计模式，它通过将请求封装成对象的方式，实现了发送者和接收者之间的解耦，提高了系统的灵活性和可扩展性。同时，它也支持撤销和重做、请求排队和日志记录等高级功能，为复杂系统的开发提供了有力的支持。
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        testTextEditor()
    }

    func testRemoteControl() {
        // 初始化电视，命令，遥控器
        let tv = TV()
        let onCommand = TVOnCommand(tv: tv)
        let offCommand = TVOffCommand(tv: tv)
        let remoteControl = RemoteControl(onCommand: onCommand, offCommand: offCommand)
        // 模拟发送命令
        remoteControl.pressOnButton()
        remoteControl.pressOffButton()
    }
    
    func testTextEditor() {
        let textEditor = TextEditor(text: "Hello, world!")
        let commandHistory = CommandHistory()
          
        let boldCommand = BoldCommand(textEditor: textEditor)
        let undoCommand = UndoCommand(commandHistory: commandHistory, textEditor: textEditor)
          
        commandHistory.addCommand(command: boldCommand)
        boldCommand.execute() // Current text: Hello, world![B]
          
        commandHistory.addCommand(command: undoCommand)
        undoCommand.execute() // Should undo the bold operation, but our UndoCommand is simplified
        // In a real scenario, we would need to implement the UndoCommand more complexly
        // to actually track and undo the effects of previous commands
    }

}

