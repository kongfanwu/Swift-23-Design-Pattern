//
//  ViewController.swift
//  责任链模式
//
//  Created by wangyang on 2024/8/8.
/*
 责任链模式（Chain of Responsibility Pattern）是一种行为型设计模式，它通过将请求的发送者和接收者解耦，使多个对象都有机会处理请求。具体来说，责任链模式创建了一个请求处理的链，请求在这个链上依次传递，直到链上的某个对象能够处理该请求为止。如果链上的所有对象都不能处理该请求，则可以根据需要决定是否将请求传递给链外的其他对象处理。
 主要特点
 解耦：责任链模式将请求的发送者和接收者解耦，发送者只需将请求发送到链上，无需关心具体是哪个对象处理的。
 灵活性：可以在运行时动态地添加或删除处理者，改变处理链的结构。
 可扩展性：通过增加新的处理者类可以很容易地扩展系统的功能。
 应用场景
 日志处理：不同级别的日志信息可以传递给不同的日志处理器进行处理。
 权限校验：用户请求可能需要经过多个权限校验器的校验，每个校验器根据自己的职责进行校验。
 异常处理：在异常处理系统中，不同类型的异常可以由不同的异常处理器来处理。
 实现方式
 责任链模式通常包含以下几个角色：
 抽象处理者（Handler）：定义了处理请求的接口，通常包含一个指向下一个处理者的引用。
 具体处理者（Concrete Handler）：实现了抽象处理者接口，处理它负责的请求，并可以访问链中的下一个处理者。
 客户端（Client）：创建处理链，并将请求发送到链上的第一个处理者。
 优缺点
 优点
 降低耦合度：将请求的发送者和接收者解耦。
 提高系统的灵活性：可以动态地添加或删除处理者。
 增强系统的可扩展性：通过增加新的处理者类来扩展系统功能。
 缺点
 请求处理可能不被保证：如果没有正确配置责任链或者某个处理者没有正确处理请求，可能会导致请求无法被处理。
 性能问题：当责任链过长或者请求在责任链中被频繁传递时，可能会对性能产生影响。
 调试不方便：当责任链特别是链条比较长、环节比较多的时候，调试时逻辑可能比较复杂。
 
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    func testLog() {
        // 创建日志系统
        let errorHandler = ErrorLogHandler()
        let infoHandler = InfoLogHandler(nextHandle: errorHandler)
        let debugHandle = DebugLogHandler(nextHandle: infoHandler)
        
        // 测试使用
        var arrr = [
            LogMessage(level: .debug, message: "这是debug log"),
            LogMessage(level: .info, message: "这是info log"),
            LogMessage(level: .error, message: "这是error log")
        ]

        for message in arrr {
            debugHandle.handle(logMessage: message)
        }
        
        /*
         在这个例子中，每个日志处理器都会检查传入的日志消息的级别，并根据其级别决定是处理该消息还是将其传递给链中的下一个处理器。这样，DEBUG级别的日志只会打印到控制台，INFO和ERROR级别的日志会打印到控制台和“文件”（在这个示例中只是简单地打印到控制台），而只有ERROR级别的日志会触发发送电子邮件的动作（尽管在这个示例中也只是简单地打印到控制台）。
         */
    }

    func testLogin() {
        let checkUsername = CheckUsernameHandler()
        let checkPassword = CheckPasswordHandler()
        let twoFactorAuth = TwoFactorAuthHandler()
        let loginSuccess = LoginSuccessHandler()
          
        checkUsername.next = checkPassword
        checkPassword.next = twoFactorAuth
        twoFactorAuth.next = loginSuccess
          
        let loginRequest = LoginRequest(username: "user123", password: "password123", isTwoFactorAuthEnabled: true)
        checkUsername.handle(request: loginRequest)
    }
}

