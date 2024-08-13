//
//  ViewController.swift
//  适配器
//
//  Created by wangyang on 2024/8/12.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func test() {
        let oldDataAccess = OldDataAccess()
        let adapter = DataAccessAdapter(oldDataAccess: oldDataAccess)
      
        adapter.fetchData { result in
            switch result {
            case .success(let data):
                print("Fetched data: \(data)")
            case .failure(let error):
                print("Failed to fetch data: \(error.localizedDescription)")
            }
        }
    }

    func test2() {
        let target = OldDeathStarSuperlaserTarget(angleHorizontal: 14.0, angleVertical: 12.0)
        let newFormat = NewDeathStarSuperlaserTarget(target)

        newFormat.angleH
        newFormat.angleV
    }
}

