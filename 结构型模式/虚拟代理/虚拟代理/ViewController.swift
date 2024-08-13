//
//  ViewController.swift
//  虚拟代理
//
//  Created by wangyang on 2024/8/13.
/*
 虚拟代理设计模式（Virtual Proxy）是设计模式中的一种，它属于结构型设计模式。该模式主要用于解决在创建或加载一个资源消耗较大或创建过程复杂的对象时，可能会导致的性能问题。虚拟代理通过延迟真实对象的创建，直到真正需要时才进行实例化，从而优化系统的性能和资源利用率。
 虚拟代理设计模式的核心特点
 延迟实例化：虚拟代理不会立即创建真实对象，而是等到真正需要时才进行实例化。这有助于减少系统启动时的内存占用和加载时间。
 接口一致性：虚拟代理对象与真实对象实现相同的接口，这使得客户端可以通过相同的接口与两者进行交互，而无需关心背后是真实对象还是代理对象。
 透明性：对于客户端而言，代理对象的使用应该是透明的，即客户端不应该感知到代理对象的存在。代理对象应该能够无缝地替代真实对象，而不影响客户端的代码和逻辑。
 虚拟代理设计模式的应用场景
 图片加载：在Web开发中，图片加载是一个常见的应用场景。使用虚拟代理可以延迟图片的加载，直到图片真正出现在可视区域内时才进行加载，从而优化页面加载速度和用户体验。
 大数据处理：在处理大数据时，如果直接加载所有数据到内存中可能会导致内存溢出或系统崩溃。使用虚拟代理可以只加载当前需要处理的数据部分，减少内存占用并提高处理效率。
 复杂对象的创建：当对象的创建过程复杂且耗时，或者对象的创建需要依赖一些外部资源时，可以使用虚拟代理来延迟对象的创建过程。这样可以在不牺牲系统性能的前提下，提高系统的响应速度和可用性。
 虚拟代理设计模式的实现方式
 在实现虚拟代理时，通常需要定义一个代理类和一个真实类。代理类中包含对真实类的引用，但并不会立即创建真实类的实例。当客户端通过代理类请求服务时，代理类会检查真实类是否已经被创建：
 如果已经创建，则直接调用真实类的方法。
 如果未创建，则首先创建真实类的实例，然后再调用其方法。
 通过这种方式，虚拟代理能够确保只有在真正需要时才会创建和加载真实对象，从而优化系统的性能和资源利用率。
 总结
 虚拟代理设计模式是一种通过延迟真实对象的创建来优化系统性能和资源利用率的设计模式。它适用于处理资源消耗较大或创建过程复杂的对象，通过延迟实例化来减少系统启动时的内存占用和加载时间。在实现时，需要确保代理对象与真实对象实现相同的接口，并保持对客户端的透明性。
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let proxy = ImageProxy("example_image")
        // 假设这里有一些延迟，比如用户滑动到某个位置时
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            proxy.display() // 这时RealImage才会被创建并加载图片
        }
//        注意：这个示例并不完全符合虚拟代理的典型用法，因为它在display方法中仍然立即创建了RealImage实例（尽管是延迟到显示时）。在更严格的虚拟代理实现中，你可能需要一种机制来确保RealImage的实例化只发生一次，并且可能需要在代理类中缓存这个实例。
//        此外，由于Swift和iOS/macOS的异步特性，实际的图片加载可能会使用URLSession或其他网络框架进行异步处理，而不是像示例中那样简单地使用DispatchQueue来模拟。
//        这个示例主要是为了说明如何在Swift中实现虚拟代理的基本结构，并展示如何通过代理来延迟对复杂或资源密集型对象的访问。
    }


}

//在Swift中，实现虚拟代理（Virtual Proxy）设计模式的一个简单示例可能涉及到一个加载大型数据或资源（如图片）的场景，但仅在需要时才真正加载这些数据。以下是一个简化的例子，模拟了从网络异步加载图片的过程，但使用了虚拟代理来延迟图片的加载直到它实际上被需要显示时。
//首先，我们定义一个图片的协议（或接口），然后实现一个真实的图片类和一个代理类。代理类将延迟真实图片类的实例化，直到某个方法（如display）被调用。
// 图片协议
protocol Image {
    func display()
}
  
// 真实图片类
class RealImage: Image {
    private var imageName: String
    private var image: UIImage?
  
    init(_ imageName: String) {
        self.imageName = imageName
        // 假设这里有一个耗时的加载过程，比如从网络下载
        self.loadImage()
    }
  
    private func loadImage() {
        // 模拟加载过程（在真实场景中，这里可能是异步网络请求）
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 2) {
            // 假设这是从网络或资源文件中加载的图片
            let loadedImage = UIImage(named: self.imageName)
            self.image = loadedImage
            // 在真实场景中，你可能需要通知界面更新
            print("Loaded image: \(self.imageName)")
        }
    }
  
    func display() {
        guard let img = image else {
            print("Image not loaded yet")
            return
        }
        // 在这里处理图片的显示，比如更新UIImageView
        print("Displaying image: \(self.imageName)")
        // 假设这里有一个UIImageView来显示图片
    }
}
  
// 图片代理类
class ImageProxy: Image {
    private var realImage: RealImage?
    private var imageName: String
  
    init(_ imageName: String) {
        self.imageName = imageName
    }
  
    func display() {
        // 延迟创建RealImage实例，直到需要显示时
        if realImage == nil {
            realImage = RealImage(imageName)
        }
        realImage?.display()
    }
}
