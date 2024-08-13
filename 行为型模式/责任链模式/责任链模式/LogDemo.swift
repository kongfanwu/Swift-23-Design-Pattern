//
//  Log.swift
//  责任链模式
//
//  Created by wangyang on 2024/8/8.
/*
 在Swift中，实现责任链模式的一个示例可以涉及创建一个日志系统，该系统根据日志的优先级（如DEBUG、INFO、ERROR）将日志消息传递给不同的处理器。下面是一个简单的实现示例：

 */

import Foundation

enum LogLevel: UInt {
    case debug = 1, info, error
    var description: String {
        switch self {
        case .debug: return "DEBUG"
        case .info: return "INFO"
        case .error: return "ERROR"
        }
    }
}
// 定义日志
struct LogMessage {
    var level: LogLevel
    var message: String
    var description: String {
        return "\(level.description)" + message
    }
}

// 我们定义一个日志处理器的协议和抽象基类，该基类包含指向下一个处理器的引用：
protocol LogHandler {
    // 执行
    func handle(logMessage: LogMessage)
    // 下一个执行的对象
    var nextHandle: LogHandler? { get set }
}

class BaseLogHandler: LogHandler {
    var nextHandle: LogHandler?
    // 子类处理不了，转下个对象执行
    func handle(logMessage: LogMessage) {
        if let next = nextHandle {
            next.handle(logMessage: logMessage)
        } else {
            print("无对象可处理")
        }
    }
    
    init(nextHandle: LogHandler? = nil) {
        self.nextHandle = nextHandle
    }
}

// 现在，我们可以创建具体的日志处理器，每个处理器只处理特定级别的日志：

class DebugLogHandler: BaseLogHandler {
    override func handle(logMessage: LogMessage) {
        if logMessage.level == .debug {
            print("打印到控制台Debug：\(logMessage.description)")
        } else {
            super.handle(logMessage: logMessage)
        }
    }
}

class InfoLogHandler: BaseLogHandler {
    override func handle(logMessage: LogMessage) {
        if logMessage.level == .info {
            print("打印到控制台Info：\(logMessage.description)")
        } else {
            super.handle(logMessage: logMessage)
        }
    }
}

class ErrorLogHandler: BaseLogHandler {
    override func handle(logMessage: LogMessage) {
        if logMessage.level == .error {
            print("打印到控制台Error：\(logMessage.description)")
        } else {
            super.handle(logMessage: logMessage)
        }
    }
}
