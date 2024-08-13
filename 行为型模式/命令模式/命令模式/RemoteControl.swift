//
//  RemoteControl.swift
//  命令模式
//
//  Created by wangyang on 2024/8/9.
/*
 模拟一个简单的遥控器，它可以执行打开电视和关闭电视的命令。
 */

import Foundation
 
// 接收者角色
class TV {
    var isOn = false
    func turnOn() {
        self.isOn = true
        print("电视已打开")
    }
    func turnOff() {
        self.isOn = false
        print("电视已关闭")
    }
}

// 命令角色
protocol Command {
    func execute()
}

// 具体命令角色
class TVOnCommand: Command {
    var tv:TV
    init(tv: TV) {
        self.tv = tv
    }
    func execute() {
        tv.turnOn()
    }
}

class TVOffCommand: Command {
    var tv:TV
    init(tv: TV) {
        self.tv = tv
    }
    func execute() {
        tv.turnOff()
    }
}
// 调用者
class RemoteControl {
    var onCommand: Command?
    var offCommand: Command?
    
    init(onCommand: Command? = nil, offCommand: Command? = nil) {
        self.onCommand = onCommand
        self.offCommand = offCommand
    }
    
    func pressOnButton() {
        onCommand?.execute()
    }
    
    func pressOffButton() {
        offCommand?.execute()
    }
}
