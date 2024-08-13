//
//  Login.swift
//  责任链模式
//
//  Created by wangyang on 2024/8/9.
/*
 当然，我可以再提供一个Swift中实现责任链模式的示例。这次我们将以一个简单的用户登录验证流程为例，该流程包括检查用户名是否存在、检查密码是否正确、以及进行双重验证（如果需要的话）。
 */

import Foundation

protocol LoginHandler {
    var next: LoginHandler? { get set }
    func handle(request: LoginRequest)
}
  
struct LoginRequest {
    let username: String
    let password: String
    var isTwoFactorAuthEnabled: Bool
}

class CheckUsernameHandler: LoginHandler {
    var next: LoginHandler?
  
    func handle(request: LoginRequest) {
        if request.username.isEmpty {
            print("用户名不能为空")
        } else {
            print("用户名存在，继续验证...")
            next?.handle(request: request)
        }
    }
}
  
class CheckPasswordHandler: LoginHandler {
    var next: LoginHandler?
  
    func handle(request: LoginRequest) {
        if request.password.isEmpty {
            print("密码不能为空")
        } else {
            // 这里假设密码验证总是通过，实际中应该有密码验证逻辑
            print("密码验证通过，继续验证...")
            next?.handle(request: request)
        }
    }
}
  
class TwoFactorAuthHandler: LoginHandler {
    var next: LoginHandler?
  
    func handle(request: LoginRequest) {
        if request.isTwoFactorAuthEnabled {
            print("请通过双重验证...")
            // 这里可以添加双重验证的逻辑
            // 假设双重验证总是通过
            print("双重验证通过")
            next?.handle(request: request)
        } else {
            print("双重验证未启用，跳过...")
            next?.handle(request: request)
        }
    }
}
  
class LoginSuccessHandler: LoginHandler {
    var next: LoginHandler?
  
    func handle(request: LoginRequest) {
        print("登录成功！")
        // 这里可以添加登录成功后的逻辑
        // 因为是最后一个处理器，所以不需要调用next
    }
}


