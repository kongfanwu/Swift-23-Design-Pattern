//
//  GameState.swift
//  备忘录
//
//  Created by wangyang on 2024/8/9.
//

import Foundation

// 备忘录
typealias Memento = [String: String]

protocol MementoConvertible {
    var memento: Memento { get }
    init?(memento: Memento)
}

// 发起人
struct GameState {
    var chapter: String // 第几章
    var weapon: String // 武器
    
    init(chapter: String, weapon: String) {
        self.chapter = chapter
        self.weapon = weapon
    }
}

extension GameState: MementoConvertible {
    // 定义缓存key
    enum Keys {
        static let chapter = "com.kfw.capter"
        static let weapon = "com.kfw.weapon"
    }
    
    // 生成当前备忘录快照
    var memento: Memento {
        
        return [Keys.chapter: self.chapter, Keys.weapon: self.weapon]
    }

    // 恢复备忘录构造方法
    init?(memento: Memento) {
        guard let mementoChapter = memento[Keys.chapter],
              let mementoWeapon = memento[Keys.weapon] else {
            return nil
        }
        chapter = mementoChapter
        weapon = mementoWeapon
    }
}

// 未什么枚举?
struct CheckPoint {
    private static let defaults = UserDefaults.standard
    
    static func save(_ state: MementoConvertible, saveNmae: String) {
        defaults.set(state.memento, forKey: saveNmae)
        defaults.synchronize()
    }
    
    static func restore(saveNmae: String) -> Any? {
        return defaults.object(forKey: saveNmae)
    }
}
