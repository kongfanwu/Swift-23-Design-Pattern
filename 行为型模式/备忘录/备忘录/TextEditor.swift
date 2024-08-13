//
//  TextEditor.swift
//  备忘录
//
//  Created by wangyang on 2024/8/9.
//

import Foundation

// 备忘录
struct TextMemo {
    var text: String
}
// 发起人
class TextEditor {
    private var currentText: String
    
    init(currentText: String) {
        self.currentText = currentText
    }
    
    func saveToMemo() -> TextMemo {
        return TextMemo(text: currentText)
    }
    
    func restoreFromMemo(memo: TextMemo) {
        self.currentText = memo.text
    }
    
    func change(text: String) {
        currentText += " \(text)"
    }
    
    func displayText() {
        print(currentText)
    }
}
// 管理者
class memoCaretaker {
    private var memos: [TextMemo] = []
    
    func addMemo(memo: TextMemo) {
        memos.append(memo)
    }
    
    func getLastMemo() -> TextMemo? {
        return memos.last
    }
    
    func getMemo(at index: Int) -> TextMemo? {
        if index < memos.count-1 {
            return memos[index]
        }
        return nil
    }
}
