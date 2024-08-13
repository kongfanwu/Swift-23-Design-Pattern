//
//  ViewController.swift
//  策略模式
//
//  Created by wangyang on 2024/8/12.
/*
 策略设计模式（Strategy Pattern）是一种行为设计模式，它定义了一系列算法，并将每一个算法封装起来，使它们可以相互替换。这种模式允许算法的变化独立于使用算法的客户，从而使算法的变化不会影响到使用算法的客户。策略设计模式主要由三部分组成：抽象策略类（或接口）、具体策略类以及环境类（或上下文类）。
 策略设计模式的定义
 策略设计模式通过定义一系列的算法，把它们一个个封装起来，并且使它们可以相互替换。此模式让算法的变化独立于使用算法的客户。这通常通过定义一系列的算法接口，然后使算法的不同实现成为该接口的具体类来完成，这样可以在运行时根据需要来替换算法的具体实现。
 策略设计模式的组成部分
 抽象策略类（Strategy）：这是一个抽象类或接口，用于声明算法的方法，但不提供具体的实现。所有具体策略类都需要实现这个接口或继承这个抽象类。
 具体策略类（ConcreteStrategy）：这些类实现了抽象策略类中声明的算法方法，每个具体策略类封装了一种具体的算法。
 环境类（Context）：也被称为上下文类，它持有对抽象策略类的引用，并在运行时根据需要使用具体的策略对象。环境类负责调用策略对象的算法方法。
 策略设计模式的应用场景
 多个类只区别在表现行为不同：当系统中存在多个类，它们之间的主要区别仅在于它们的行为时，可以使用策略模式来动态地选择具体要执行的行为。
 需要在不同情况下使用不同的算法：当需要在不同情况下使用不同的算法，或者这些算法在未来可能以其他方式实现时，策略模式提供了一种灵活的方式来封装和替换这些算法。
 避免使用多重条件语句：当系统中存在大量的if-else或switch-case语句来选择不同的算法时，这会导致代码难以维护和扩展。使用策略模式可以将这些算法封装成独立的类，并通过环境类来调用，从而避免使用大量的条件语句。
 策略设计模式的优点
 更好的扩展性：由于策略类是可以自由切换的，因此可以非常方便地实现新的算法或业务逻辑。
 代码复用：不同的算法可以共享同一个抽象策略类，从而避免重复的代码。
 更好的可维护性：由于算法都被封装在不同的策略类中，因此代码结构更加清晰，易于理解和维护。
 总结
 策略设计模式是一种强大的设计模式，它通过将算法封装成独立的类，并允许在运行时动态地选择算法，从而提高了系统的灵活性和可维护性。这种设计模式在软件开发中有着广泛的应用，特别是在需要处理多种算法或行为选择的场景中。
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 使用示例
        var numbers = [5, 3, 8, 4, 2]
        let sorter = Sorter()
          
        // 使用冒泡排序
        sorter.setStrategy(BubbleSort())
        sorter.sort(array: &numbers)
        print("Bubble Sorted: \(numbers)")
          
        // 改为使用快速排序
        sorter.setStrategy(QuickSort())
        sorter.sort(array: &numbers)
        print("Quick Sorted: \(numbers)")
        
//        在这个示例中，Sorter 类是上下文类，它允许客户端在运行时通过 setStrategy 方法来设置不同的排序策略（BubbleSort 或 QuickSort）。然后，sort 方法会使用当前设置的策略来对数组进行排序。这样，我们就可以轻松地扩展或修改排序算法，而不需要修改 Sorter 类或客户端代码。
    }


}

/*
 当然，我可以给你一个简单的Swift示例，展示如何使用策略设计模式。在这个示例中，我们将创建一个简单的场景，其中有多种排序算法（比如冒泡排序和快速排序），我们将这些算法作为策略封装起来，并通过一个上下文（Context）类来选择并执行这些策略。
 首先，我们定义一个排序策略的协议（或接口），它将包含一个需要被实现的排序方法：
 */
protocol SortStrategy {
    func sort(array: inout [Int])
}
// 接下来，我们定义两个具体策略类，分别实现冒泡排序和快速排序算法：
class BubbleSort: SortStrategy {
    func sort(array: inout [Int]) {
        var n = array.count
//        for (var i, i < n, i++) {
//            for j in n - i {
//                if array[j - 1] > array[j] {
//                    // 交换元素
//                    let temp = array[j - 1]
//                    array[j - 1] = array[j]
//                    array[j] = temp
//                }
//            }
//        }
    }
}
  
class QuickSort: SortStrategy {
    func sort(array: inout [Int]) {
        if array.count <= 1 {
            return
        }
          
        let pivot = array[array.count / 2]
        var left = [Int]()
        var middle = [Int]()
        var right = [Int]()
          
        for num in array {
            if num < pivot {
                left.append(num)
            } else if num > pivot {
                right.append(num)
            } else {
                middle.append(num)
            }
        }
          
        // 递归排序左右两边
        sort(array: &left)
        sort(array: &right)
          
        // 合并
        array = left + middle + right
    }
}
// 最后，我们定义一个上下文类（或环境类），它持有对排序策略的引用，并允许客户端代码在运行时更换策略：
class Sorter {
    private var strategy: SortStrategy?
      
    func setStrategy(_ strategy: SortStrategy) {
        self.strategy = strategy
    }
      
    func sort(array: inout [Int]) {
        guard let strategy = strategy else {
            print("No sorting strategy is set.")
            return
        }
          
        strategy.sort(array: &array)
    }
}
  

