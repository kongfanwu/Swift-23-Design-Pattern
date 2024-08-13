//
//  ViewController.swift
//  抽象工厂
//
//  Created by wangyang on 2024/8/8.
/*
 假设我们正在开发一个支持多种支付方式的电商平台。该平台需要支持多种支付服务，如支付宝、微信支付和银联支付等。每种支付服务都提供了一系列的支付接口，如支付、退款、查询等。在这个场景下，我们可以使用抽象工厂设计模式来组织和管理这些支付服务。
 首先，我们定义抽象产品接口，如IPayment接口，它包含了支付、退款、查询等方法的声明。然后，我们为每种支付服务实现具体的产品类，如AlipayPayment、WechatPayment和UnionPayPayment等，这些类实现了IPayment接口并提供了具体的方法实现。
 接下来，我们定义抽象工厂接口，如IPaymentFactory接口，它包含了创建支付产品的方法，如CreatePayment()。然后，我们为每种支付服务实现具体的工厂类，如AlipayFactory、WechatFactory和UnionPayFactory等，这些类实现了IPaymentFactory接口并提供了具体的方法来创建相应的支付产品。
 最后，在客户端代码中，我们可以根据用户的选择或系统配置来选择不同的工厂来创建支付产品对象，并通过这些对象来调用支付服务。这样，我们就可以在不修改客户端代码的情况下，通过更换工厂来支持不同的支付服务了。
 以上例子展示了抽象工厂设计模式在支持多种支付方式的电商平台中的应用。通过这种模式，我们可以将支付服务的创建和使用过程封装起来，使系统更加灵活和可扩展。
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let payment = AlipayFactory().createPayment()
        let _ = payment.pay()
        let _ = payment.refund()
        
        let payment2 = WechatFactory().createPayment()
        let _ = payment2.pay()
        let _ = payment2.refund()
    }


}

protocol IPayment {
    func pay() -> Bool
    func refund() -> Bool
}

struct AlipayPayment: IPayment {
    func pay() -> Bool {
        print("allipay pay")
        return true
    }
    
    func refund() -> Bool {
        print("allipay refund")
        return true
    }
}

struct WechatPayment: IPayment {
    func pay() -> Bool {
        print("Wechat pay")
        return true
    }
    
    func refund() -> Bool {
        print("Wechat refund")
        return true
    }
}

protocol IPaymentFactory {
    func createPayment() -> IPayment
}

struct AlipayFactory: IPaymentFactory {
    func createPayment() -> IPayment {
        return AlipayPayment()
    }
}

struct WechatFactory: IPaymentFactory {
    func createPayment() -> IPayment {
        return WechatPayment()
    }
}
