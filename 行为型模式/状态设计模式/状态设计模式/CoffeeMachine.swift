//
//  CoffeeMachine.swift
//  状态设计模式
//
//  Created by wangyang on 2024/8/12.
/*
 当然，我们可以再写一个状态设计模式的示例，这次我们将考虑一个更简单的场景，比如一个咖啡机的状态管理。咖啡机可以有几种状态，比如“空闲”、“加热中”、“冲泡中”和“结束”。下面是这个示例的Swift实现：
 */

import Foundation
// 定义咖啡机状态的协议
protocol CoffeeMachineState {
    func brew(machine: CoffeeMachine)
}
  
// 空闲状态
class IdleState: CoffeeMachineState {
    func brew(machine: CoffeeMachine) {
        print("咖啡机空闲，开始加热...")
        machine.state = HeatingState()
    }
}
  
// 加热状态
class HeatingState: CoffeeMachineState {
    func brew(machine: CoffeeMachine) {
        print("咖啡机正在加热...")
        // 假设加热完成后自动切换到冲泡状态
        machine.state = BrewingState()
    }
}
  
// 冲泡状态
class BrewingState: CoffeeMachineState {
    func brew(machine: CoffeeMachine) {
        print("咖啡机正在冲泡咖啡...")
        // 假设冲泡完成后自动切换到空闲状态
        machine.state = IdleState()
    }
}
  
// 咖啡机环境类
class CoffeeMachine {
    var state: CoffeeMachineState!
      
    init() {
        // 初始化时设置为空闲状态
        self.state = IdleState()
    }
      
    func startBrewing() {
        // 调用当前状态对象的brew方法
        state.brew(machine: self)
    }
}
  
