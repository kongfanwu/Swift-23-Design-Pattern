//
//  TextEditor.swift
//  命令模式
//
//  Created by wangyang on 2024/8/9.
//

import Foundation
// Command Protocol
protocol TextEditorCommand {
    func execute()
    func undo()
}
  
// Receiver (Text Editor's Content)
class TextEditor {
    var text: String
  
    init(text: String = "") {
        self.text = text
    }
  
    func append(string: String) {
        text += string
        print("Current text: \(text)")
    }
  
    func removeLastCharacter() {
        if !text.isEmpty {
            text = String(text.dropLast())
            print("Current text: \(text)")
        }
    }
}
// Command History for Undo
class CommandHistory {
    private var history: [TextEditorCommand] = []
  
    func addCommand(command: TextEditorCommand) {
        history.append(command)
    }
  
    func undoLastCommand() {
        if !history.isEmpty {
            let lastCommand = history.popLast()!
            lastCommand.undo()
        }
    }
}
  
// Concrete Command - Bold
class BoldCommand: TextEditorCommand {
    private let textEditor: TextEditor
    private let previousState: String
  
    init(textEditor: TextEditor) {
        self.textEditor = textEditor
        self.previousState = textEditor.text
    }
  
    func execute() {
        textEditor.append(string: "[B]")
        // In a real scenario, this would actually make the text bold somehow
    }
  
    func undo() {
        textEditor.text = previousState
        // Remove the undo command from history to prevent infinite undo loop
        // This is a simplification; in a real app, you might handle this differently
    }
}
  
// Concrete Command - Undo (simplified for demonstration)
class UndoCommand: TextEditorCommand {
    private let textEditor: TextEditor
    private let commandHistory: CommandHistory
  
    init(commandHistory: CommandHistory, textEditor: TextEditor) {
        self.commandHistory = commandHistory
        self.textEditor = textEditor
    }
  
    func execute() {
        commandHistory.undoLastCommand()
    }
  
    func undo() {
        // For simplicity, this command does not support an undo operation
        // In a real app, you might implement a redo feature instead
        textEditor.removeLastCharacter()
        print("撤销操作")
    }
}
