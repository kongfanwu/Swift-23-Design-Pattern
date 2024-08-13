//
//  ViewController.swift
//  备忘录
//
//  Created by wangyang on 2024/8/9.
/*
 备忘录设计模式，又称为快照模式或Token模式，是GoF（四人帮）提出的23种设计模式之一，属于行为型设计模式。该模式的主要目的是在不破坏对象封装性的前提下，捕获和保存一个对象的内部状态，以便在需要时能够恢复到该对象到原先的状态。
 备忘录设计模式的定义
 备忘录模式允许在不暴露对象实现细节的情况下保存和恢复对象之前的状态。它通过创建一个备忘录对象来保存当前对象的内部状态，并使用这个备忘录对象来恢复对象的状态。这样，对象的状态可以被保存和恢复，而不会破坏对象的封装性。
 备忘录设计模式的角色
 备忘录设计模式通常涉及三个主要角色：
 发起人（Originator）：负责创建一个备忘录对象，用以记录当前时刻它的内部状态，并可使用备忘录对象恢复内部状态。发起人根据需要决定备忘录对象存储哪些状态。
 备忘录（Memento）：负责存储发起人的内部状态，并且可以防止发起人以外的其他对象访问备忘录。备忘录有两个接口：一是可以将发起人内部状态保存到这个备忘录对象中，二是可以将备忘录对象中的状态信息回复到发起人对象中。
 管理者（Caretaker）：负责保存备忘录对象，但不检查备忘录对象的内容。管理者提供一个存储备忘录的集合，用于保存多个备忘录对象。
 备忘录设计模式的适用场景
 备忘录模式通常用于需要保存一个对象的历史状态并能够恢复到任意一个已保存状态的场景。常见的应用场景包括：
 文本编辑器的撤销/恢复操作：在文本编辑器中，可以使用备忘录模式来保存撤销和重做操作之前的文本状态。
 游戏的存档/读档操作：在游戏中，可以使用备忘录模式来保存游戏进度，并在玩家需要恢复游戏进度时使用。
 数据库事务的回滚：在数据库事务管理中，可以使用备忘录模式来保存事务执行之前的状态，以便在需要回滚事务时可以恢复到之前的状态。
 安全监管：在安全监管中，可以使用备忘录模式来记录系统的运行状态，以便在出现问题时可以回溯到之前的状态，找到问题所在。
 备忘录设计模式的优缺点
 优点：
 封装性：备忘录模式通过将状态信息封装在备忘录对象中，保护了状态的完整性，并且不会暴露给外部对象。
 灵活性：可以随时保存和恢复对象的状态，提高了程序的灵活性和可维护性。
 历史记录：管理者可以管理多个备忘录对象，提供了更好的历史记录和回滚功能。
 缺点：
 资源占用：如果备忘录对象过多或者状态信息过于复杂，会占用较多的内存空间。
 性能影响：捕获和恢复一个对象的状态需要时间和资源，可能会影响程序的性能。
 综上所述，备忘录设计模式是一种非常有用的设计模式，它允许在不破坏对象封装性的前提下保存和恢复对象的状态，适用于需要撤销操作或回滚操作的场景。
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        test2()
    }
    func test2() {
        var gemeState = GameState(chapter: "第一章", weapon: "屠龙刀")
        CheckPoint.save(gemeState, saveNmae: "gameState1")
        
        gemeState.chapter = "第二章"
        gemeState.weapon = "倚天剑"
        CheckPoint.save(gemeState, saveNmae: "gameState2")
//
        gemeState.chapter = "第三章"
        gemeState.weapon = "倚天剑3"
        CheckPoint.save(gemeState, saveNmae: "gameState3")
        
        if let memento = CheckPoint.restore(saveNmae: "gameState2") as? Memento {
            let finalState = GameState(memento: memento)
            dump(finalState)
        }
    }
    
    func test() {
        let caretaker = memoCaretaker()
        
        // 发起者编辑
        let textEditor = TextEditor(currentText: "Hello")
        textEditor.change(text: "World")
        textEditor.displayText()
        
        // 备忘录保存
        caretaker.addMemo(memo: textEditor.saveToMemo())
        
        // 编辑
        textEditor.change(text: "Swift")
        textEditor.displayText()
        
        // 恢复最后一次保存
        if let memo = caretaker.getLastMemo() {
            textEditor.restoreFromMemo(memo: memo)
            textEditor.displayText()
        }
    }

}

