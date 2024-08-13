//
//  ViewController.swift
//  保护代理
//
//  Created by wangyang on 2024/8/13.
/*
 保护代理设计模式是代理模式的一种变体，主要用于控制对某个对象的访问权限，以保护敏感资源或数据不被未授权的用户访问。在保护代理模式中，代理对象充当了客户端与目标对象之间的中介，负责检查客户端的访问权限，并根据权限决定是否允许访问目标对象。
 保护代理的特点
 控制访问权限：保护代理的核心功能是控制对目标对象的访问权限。通过代理对象，可以对客户端的访问请求进行验证，确保只有具有适当权限的客户端才能访问目标对象。
 中介作用：代理对象作为客户端和目标对象之间的中介，接收客户端的请求，并根据需要与目标对象进行交互。
 实现透明性：为了保护代理的透明性，代理对象和目标对象通常需要实现相同的接口，这样客户端就可以在不了解具体实现细节的情况下与代理对象交互。
 实现方式
 保护代理的实现方式通常有两种：静态代理和动态代理。
 静态代理：在静态代理中，代理类的代码是在编译时就已经确定的。代理类和被代理类通常实现相同的接口，代理类中持有被代理类的引用，并在方法调用时添加权限检查的逻辑。
 动态代理：动态代理则更加灵活，它允许在运行时动态地创建代理类。在Java中，可以通过反射API和动态代理类（如java.lang.reflect.Proxy）来实现动态代理。动态代理可以根据需要生成代理类的字节码，并在运行时加载和使用。
 应用场景
 保护代理设计模式在需要控制访问权限的场景中非常有用，例如：
 文件访问控制：在文件系统中，可以使用保护代理来控制对敏感文件的访问权限。
 数据库访问控制：在数据库应用中，可以使用保护代理来限制用户对敏感数据的访问。
 API接口保护：在Web服务或API接口中，可以使用保护代理来验证用户的身份和权限，确保只有授权用户才能访问特定的服务或数据。
 总之，保护代理设计模式是一种有效的控制访问权限的方法，通过代理对象的中介作用，可以实现对目标对象访问权限的细粒度控制。
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let sensitiveData = SensitiveData()
        let protectiveProxy = ProtectiveProxy(sensitiveData: sensitiveData)
          
        // 尝试在未经授权的情况下获取敏感信息
        if let info = protectiveProxy.getSecretInfoIfAuthorized() {
            print(info) // 这将不会执行，因为还未授权
        } else {
            print("Access denied")
        }
          
        // 授权
        if protectiveProxy.authorize(withUser: "authorizedUser", password: "secretPassword") {
            // 再次尝试获取敏感信息
            if let info = protectiveProxy.getSecretInfoIfAuthorized() {
                print(info) // 输出: Top Secret Information
            }
        }
        
//        在这个示例中，SensitiveData类持有敏感信息，而ProtectiveProxy类作为代理，通过authorize方法控制对SensitiveData中信息的访问。只有在授权后，才能通过getSecretInfoIfAuthorized方法获取敏感信息。这种方式模拟了保护代理设计模式，用于控制对敏感资源的访问。
    }


}

//在Swift中，实现保护代理（也称为访问控制代理）设计模式通常不直接对应到一个名为“保护代理”的内置概念，但你可以通过定义代理类并使用Swift的访问控制特性（如private、fileprivate、internal、public、open）来模拟这一行为。这里，我将提供一个简单的示例，展示如何使用Swift中的类和方法封装以及条件逻辑来模拟一个保护代理。
//示例场景
//假设我们有一个敏感的数据源（比如用户个人信息），我们不希望直接让外界访问这个数据源，而是希望通过一个代理来控制访问权限。
//代理类定义
// 假设这是我们的数据源类，包含了敏感信息
class SensitiveData {
    private var secretInfo: String = "Top Secret Information"
  
    // 内部方法，用于真实的数据处理或返回，这里仅返回敏感信息
    func getSecretInfo() -> String {
        return secretInfo
    }
}
  
// 代理类，用于控制对SensitiveData的访问
class ProtectiveProxy {
    private let sensitiveData: SensitiveData
    private var isAuthorized: Bool = false
  
    init(sensitiveData: SensitiveData) {
        self.sensitiveData = sensitiveData
    }
  
    // 授权方法，实际应用中可能需要更复杂的逻辑来验证授权
    func authorize(withUser: String, password: String) -> Bool {
        // 假设验证逻辑很简单，只接受特定的用户名和密码
        if withUser == "authorizedUser" && password == "secretPassword" {
            isAuthorized = true
            return true
        }
        return false
    }
  
    // 只有当isAuthorized为true时，才允许访问SensitiveData的数据
    func getSecretInfoIfAuthorized() -> String? {
        guard isAuthorized else {
            return nil
        }
        return sensitiveData.getSecretInfo()
    }
}
