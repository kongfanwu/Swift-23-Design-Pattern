//
//  demo2.swift
//  享元设计模式
//
//  Created by wangyang on 2024/8/13.
//

import Foundation
//在享元设计模式中，外部状态是指那些随环境改变而改变，且不能被多个享元对象共享的状态。以下是一个包含外部状态的Swift示例，其中我们将创建一个表示棋子的享元对象，棋子的颜色（内部状态）将被共享，而棋子的位置（外部状态）将由客户端管理。
//定义享元接口
//首先，我们定义一个协议（接口）来表示棋子享元。
protocol ChessPieceFlyweight {
    var color: String { get }
    func moveTo(_ position: String)
}
//实现具体享元
//然后，我们创建一个具体的享元类，它实现了ChessPieceFlyweight协议，并存储了棋子的颜色作为内部状态。
class ConcreteChessPiece: ChessPieceFlyweight {
    let color: String
  
    init(color: String) {
        self.color = color
    }
  
    func moveTo(_ position: String) {
        print("Moving \(color) piece to \(position)")
    }
}
//享元工厂
//接下来，我们创建一个享元工厂来管理和存储已经创建的棋子享元对象。
class ChessPieceFactory {
    private var flyweights: [String: ChessPieceFlyweight] = [:]
  
    func getChessPiece(color: String) -> ChessPieceFlyweight {
        if let flyweight = flyweights[color] {
            return flyweight
        } else {
            let newFlyweight = ConcreteChessPiece(color: color)
            flyweights[color] = newFlyweight
            return newFlyweight
        }
    }
}
