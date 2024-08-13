//
//  demo.swift
//  外观设计模式
//
//  Created by wangyang on 2024/8/13.
//

import Foundation
//在Swift中，我们可以使用外观设计模式（Facade Pattern）来简化对一组复杂子系统的访问。以下是一个简单的示例，展示了如何使用外观设计模式来封装一个家庭影院系统，该系统包括DVD播放器、投影仪和音响等子系统。
//首先，我们定义各个子系统的接口和具体实现。为了简化，我们假设这些子系统只有开启(on)、关闭(off)和特定于每个设备的操作（如DVD播放器的播放play，投影仪的显示showMovie，音响的调高音量increaseVolume）等简单方法。
// DVD Player
class DVDPlayer {
    func on() {
        print("DVD Player is on")
    }
      
    func off() {
        print("DVD Player is off")
    }
      
    func play() {
        print("Playing the DVD...")
    }
}
  
// Projector
class Projector {
    func on() {
        print("Projector is on")
    }
      
    func off() {
        print("Projector is off")
    }
      
    func showMovie() {
        print("Showing the movie...")
    }
}
  
// Stereo
class Stereo {
    func on() {
        print("Stereo is on")
    }
      
    func off() {
        print("Stereo is off")
    }
      
    func increaseVolume() {
        print("Increasing volume...")
    }
}
  
// 家庭影院系统的外观设计类
class HomeTheaterFacade {
    private let dvdPlayer = DVDPlayer()
    private let projector = Projector()
    private let stereo = Stereo()
      
    func watchMovie() {
        self.dvdPlayer.on()
        self.projector.on()
        self.stereo.on()
        self.stereo.increaseVolume()
        self.projector.showMovie()
        self.dvdPlayer.play()
    }
      
    func endMovie() {
        self.dvdPlayer.off()
        self.projector.off()
        self.stereo.off()
    }
}

