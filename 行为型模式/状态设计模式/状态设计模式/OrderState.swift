//
//  OrderState.swift
//  状态设计模式
//
//  Created by wangyang on 2024/8/12.
/*
 当然，我们可以再写一个符合实际开发场景的状态设计模式示例。这次，我们将考虑一个在线购物平台的订单处理系统。订单可以处于不同的状态，如“待支付”、“已支付”、“待发货”、“已发货”和“已完成”。这些状态的变化会影响订单可以执行的操作（如支付、发货等）。
 以下是使用Swift编写的示例：
 */

import Foundation

// 定义订单状态的协议
protocol OrderState {
    func pay(order: Order)
    func ship(order: Order)
    func finish(order: Order)
}
  
// 待支付状态
class PendingPaymentState: OrderState {
    func pay(order: Order) {
        print("订单支付成功，状态更新为已支付...")
        order.state = PaidState()
    }
      
    func ship(order: Order) {
        print("订单未支付，无法发货。")
    }
      
    func finish(order: Order) {
        print("订单未支付且未发货，无法完成订单。")
    }
}
  
// 已支付状态
class PaidState: OrderState {
    func pay(order: Order) {
        print("订单已支付，无需重复支付。")
    }
      
    func ship(order: Order) {
        print("订单已支付，开始发货...")
        order.state = ShippingState()
    }
      
    func finish(order: Order) {
        print("订单已支付但尚未发货，无法完成订单。")
    }
}
  
// 待发货状态
class ShippingState: OrderState {
    func pay(order: Order) {
        print("订单已支付，无需支付。")
    }
      
    func ship(order: Order) {
        print("订单正在发货...")
        // 假设发货完成后自动切换到已完成状态
        order.state = CompletedState()
    }
      
    func finish(order: Order) {
        print("订单正在发货，无法完成订单。")
    }
}
  
// 已完成状态
class CompletedState: OrderState {
    func pay(order: Order) {
        print("订单已完成，无需支付。")
    }
      
    func ship(order: Order) {
        print("订单已完成，无需发货。")
    }
      
    func finish(order: Order) {
        print("订单已完成。")
    }
}
  
// 订单类
class Order {
    var state: OrderState!
    var id: Int
      
    init(id: Int) {
        self.id = id
        // 初始化为待支付状态
        self.state = PendingPaymentState()
    }
      
    func pay() {
        state.pay(order: self)
    }
      
    func ship() {
        state.ship(order: self)
    }
      
    func finish() {
        state.finish(order: self)
    }
}
  
