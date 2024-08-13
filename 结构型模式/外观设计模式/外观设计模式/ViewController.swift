//
//  ViewController.swift
//  外观设计模式
//
//  Created by wangyang on 2024/8/13.
/*
 外观设计模式（Facade Pattern），又称为门面模式，是一种结构型设计模式。它旨在通过为子系统提供一个统一的接口，来简化客户端与系统之间的交互，隐藏系统的复杂性，并使得子系统更加容易地被访问。以下是外观设计模式的主要特点和优势：
 主要特点
 统一的接口：外观设计模式为多个复杂的子系统提供一个对外的接口，使得客户端可以通过这个接口与系统进行交互，而无需了解子系统的内部细节。
 封装复杂性：通过引入一个外观类来封装子系统的复杂性，客户端只需与外观类交互，而无需直接与子系统的各个组件打交道。
 降低耦合度：外观类作为客户端与子系统之间的中介者，降低了客户端和子系统之间的耦合度，提高了系统的灵活性和可扩展性。
 优势
 简化调用过程：客户端只需通过外观类提供的接口进行调用，无需深入了解子系统的具体实现，从而简化了调用过程。
 提高可维护性：由于客户端与子系统之间的耦合度降低，当子系统内部发生变化时，只需修改外观类即可，而无需修改客户端代码，从而提高了系统的可维护性。
 符合迪米特法则：外观设计模式符合迪米特法则（最少知道原则），即一个软件实体应当尽可能少地与其他实体发生相互作用。
 缺点
 不符合开闭原则：如果新增子系统或删除子系统，可能需要修改外观类的代码，这在一定程度上违反了开闭原则（即对扩展开放，对修改关闭）。
 可能隐藏复杂性：如果外观类设计得过于复杂，可能会隐藏子系统的复杂性，使得客户端难以理解和使用。
 应用场景
 外观设计模式适用于以下场景：
 当系统需要对外提供一个简单接口，而内部实现较为复杂时。
 当客户端与多个子系统之间存在复杂的交互关系时，可以通过外观设计模式来简化这些关系。
 当需要降低客户端与子系统之间的耦合度，提高系统的灵活性和可扩展性时。
 实例
 以家庭影院系统为例，家庭影院系统通常包括DVD播放器、投影仪、音响等多个子系统。通过引入一个外观类（如HomeTheaterFacade），可以封装这些子系统的复杂性，并提供一个简单的接口（如watchMovie和endMovie方法）给客户端使用。客户端只需调用外观类的方法即可观看电影或结束电影，而无需了解DVD播放器、投影仪和音响之间的复杂交互关系。
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        test()
    }

    func test() {
        let theater = HomeTheaterFacade()
        theater.watchMovie()
        // 模拟电影结束后
        theater.endMovie()
//        在这个示例中，HomeTheaterFacade类封装了DVDPlayer、Projector和Stereo三个子系统的复杂性。客户端（在这个例子中是main函数）通过调用HomeTheaterFacade的watchMovie和endMovie方法来观看和结束电影，而无需直接与各个子系统交互。这样，就降低了客户端与子系统之间的耦合度，提高了系统的灵活性和可维护性。
//        外观设计模式的关键在于提供一个统一的接口来访问子系统的功能，同时隐藏了子系统的复杂性。在这个例子中，HomeTheaterFacade类就充当了这个角色。
    }
    

    func test2() {
        let storage = Defaults()

        // Store
        storage["Bishop"] = "Disconnect me. I’d rather be nothing"

        // Read
        storage["Bishop"]
    }
}

/*
 对 UserDefaults 系统高层封装，使客户端更简单使用
 */
final class Defaults {

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    subscript(key: String) -> String? {
        get {
            return defaults.string(forKey: key)
        }

        set {
            defaults.set(newValue, forKey: key)
        }
    }
}
